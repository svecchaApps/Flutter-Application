import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '/backend/supabase/supabase.dart';
import '/services/deep_link_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';
import 'package:http/http.dart' as http;
import '/config/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment configuration
  EnvironmentConfig.printEnvironmentInfo();

  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
  await initFirebase();

  if (isFirstLaunch) {
    // Clear Firebase session and app data on first launch after reinstall
    await FirebaseAuth.instance.signOut();
    await prefs.setBool(
        'firstLaunch', false); // Set flag to false after first launch
  }

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await SupaFlow.initialize();

  // Initialize deep link service
  await DeepLinkService.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});
  Future<void> _checkForUpdates() async {
    if (Platform.isAndroid) {
      await _checkForAndroidUpdate();
    } else if (Platform.isIOS) {
      await _checkForIOSUpdate();
    }
  }

  Future<void> _checkForAndroidUpdate() async {
    try {
      print('🔄 [UPDATE] Checking for Android updates...');
      final updateInfo = await InAppUpdate.checkForUpdate();

      print(
          '🔄 [UPDATE] Update availability: ${updateInfo.updateAvailability}');

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        print('🔄 [UPDATE] Update available!');

        // Check if update is high priority (staleness days)
        final int? staleDays = updateInfo.clientVersionStalenessDays;
        final bool isHighPriority = staleDays != null && staleDays >= 7;

        if (updateInfo.immediateUpdateAllowed && isHighPriority) {
          // For critical updates, perform immediate update
          print('🔄 [UPDATE] Performing immediate update (high priority)');
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          // For regular updates, use flexible update
          print('🔄 [UPDATE] Starting flexible update');
          await InAppUpdate.startFlexibleUpdate();

          // Listen for update download completion
          InAppUpdate.completeFlexibleUpdate().then((_) {
            print('🔄 [UPDATE] Flexible update completed');
            _showUpdateCompletedSnackbar();
          }).catchError((error) {
            print('🔄 [UPDATE] Flexible update error: $error');
          });
        }
      } else {
        print('🔄 [UPDATE] No updates available');
      }
    } catch (e) {
      print('🔄 [UPDATE] Android update error: $e');
    }
  }

  void _showUpdateCompletedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Update downloaded. Restart app to apply.'),
        action: SnackBarAction(
          label: 'RESTART',
          onPressed: () {
            InAppUpdate.completeFlexibleUpdate();
          },
        ),
        duration: const Duration(seconds: 10),
      ),
    );
  }

  Future<void> _checkForIOSUpdate() async {
    try {
      print('🔄 [UPDATE] Checking for iOS updates...');
      final packageInfo = await PackageInfo.fromPlatform();
      final bundleId = packageInfo.packageName;
      final currentVersion = packageInfo.version;
      print('🔄 [UPDATE] Current iOS version: $currentVersion');
      print('🔄 [UPDATE] Bundle ID: $bundleId');

      final url =
          Uri.parse('https://itunes.apple.com/lookup?bundleId=$bundleId');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print(
            '🔄 [UPDATE] Failed to check for updates: ${response.statusCode}');
        return;
      }

      final data = json.decode(response.body);

      if (data['resultCount'] == 1) {
        final latestVersion = data['results'][0]['version'];
        final releaseNotes =
            data['results'][0]['releaseNotes'] ?? 'Bug fixes and improvements';

        print('🔄 [UPDATE] Latest version: $latestVersion');

        if (_isNewerVersion(currentVersion, latestVersion)) {
          print('🔄 [UPDATE] Update available!');
          // Wait a bit before showing dialog to ensure context is ready
          Future.delayed(const Duration(milliseconds: 500), () {
            _showIOSUpdateDialog(latestVersion, releaseNotes);
          });
        } else {
          print('🔄 [UPDATE] App is up to date');
        }
      } else {
        print('🔄 [UPDATE] App not found in App Store');
      }
    } catch (e) {
      print('🔄 [UPDATE] iOS update check error: $e');
    }
  }

  bool _isNewerVersion(String currentVersion, String latestVersion) {
    try {
      List<int> current = currentVersion.split('.').map(int.parse).toList();
      List<int> latest = latestVersion.split('.').map(int.parse).toList();

      // Pad shorter version with zeros
      while (current.length < latest.length) current.add(0);
      while (latest.length < current.length) latest.add(0);

      for (int i = 0; i < current.length; i++) {
        if (latest[i] > current[i]) return true;
        if (latest[i] < current[i]) return false;
      }
      return false;
    } catch (e) {
      print('🔄 [UPDATE] Version comparison error: $e');
      return false;
    }
  }

  void _showIOSUpdateDialog(String latestVersion, String releaseNotes) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.system_update,
                color: FlutterFlowTheme.of(dialogContext).primary,
              ),
              const SizedBox(width: 8),
              const Text('Update Available'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version $latestVersion is now available.',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "What's New:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: FlutterFlowTheme.of(dialogContext).secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                releaseNotes,
                style: TextStyle(
                  color: FlutterFlowTheme.of(dialogContext).secondaryText,
                  fontSize: 14,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Later',
                style: TextStyle(
                  color: FlutterFlowTheme.of(dialogContext).secondaryText,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(dialogContext).primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Update Now'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _launchAppStore();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchAppStore() async {
    final url = Uri.parse(
      Platform.isIOS
          ? 'https://apps.apple.com/app/id6471662460' // Your iOS App ID
          : 'https://play.google.com/store/apps/details?id=com.mycompany.lsdapp', // Your Android package ID
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        print('🔄 [UPDATE] Launched app store: $url');
      } else {
        print('🔄 [UPDATE] Could not launch $url');
      }
    } catch (e) {
      print('🔄 [UPDATE] Error launching app store: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = indigoRhapsodyDupliFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        _appStateNotifier.stopShowingSplashImage();
        _checkForUpdates(); // Changed to check for both platforms
      },
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'IndigoRhapsodyDupli',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged)) {
              return const Color(0xff57636c);
            }
            if (states.contains(WidgetState.hovered)) {
              return const Color(0xff57636c);
            }
            return const Color(0xff57636c);
          }),
        ),
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Homepage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Homepage': const HomepageWidget(),
      'CartPagenewCopy': const CartPagenewCopyWidget(),
      'VideoContent': const VideoContentWidget(),
      'Settingscopy': const SettingsWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: UpgradeAlert(child: _currentPage ?? tabs[_currentPageName]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kshop,
              size: 22.0,
            ),
            activeIcon: Icon(
              FFIcons.kshop,
              size: 24.0,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kshoppingBag,
              size: 22.0,
            ),
            activeIcon: Icon(
              FFIcons.kshoppingBag,
              size: 24.0,
            ),
            label: 'cart',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kvideo,
              size: 24.0,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.person_outlined,
              size: 24.0,
            ),
            label: 'profile',
            tooltip: '',
          )
        ],
      ),
    );
  }
}

void requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
