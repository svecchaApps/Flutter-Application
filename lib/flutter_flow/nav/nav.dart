import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? const NavBarPage()
          : const LoginOrGuestWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? const NavBarPage()
              : const LoginOrGuestWidget(),
        ),
        FFRoute(
          name: 'ClientFav',
          path: '/clientFav',
          builder: (context, params) => const ClientFavWidget(),
        ),
        FFRoute(
          name: 'Emaillogin',
          path: '/emaillogin',
          builder: (context, params) => const EmailloginWidget(),
        ),
        FFRoute(
          name: 'MyOrders',
          path: '/myOrders',
          builder: (context, params) => const MyOrdersWidget(),
        ),
        FFRoute(
          name: 'DesignerCategoryClientyCopy',
          path: '/designerCategoryClientyCopy',
          builder: (context, params) => DesignerCategoryClientyCopyWidget(
            categoryref: params.getParam(
              'categoryref',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'thankyou',
          path: '/thankyou',
          builder: (context, params) => const ThankyouWidget(),
        ),
        FFRoute(
          name: 'paymentpage',
          path: '/paymentpage',
          builder: (context, params) => const PaymentpageWidget(),
        ),
        FFRoute(
          name: 'privacy',
          path: '/privacy',
          builder: (context, params) => const PrivacyWidget(),
        ),
        FFRoute(
          name: 'aboutus',
          path: '/aboutus',
          builder: (context, params) => const AboutusWidget(),
        ),
        FFRoute(
          name: 'contactus',
          path: '/contactus',
          builder: (context, params) => const ContactusWidget(),
        ),
        FFRoute(
          name: 'payment_failed',
          path: '/paymentFailed',
          builder: (context, params) => const PaymentFailedWidget(),
        ),
        FFRoute(
          name: 'ProductofdesignerclientCopyCopy',
          path: '/productofdesignerclientCopyCopy',
          builder: (context, params) => ProductofdesignerclientCopyCopyWidget(
            subcategoryid: params.getParam(
              'subcategoryid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'searchpage1',
          path: '/searchpage1',
          builder: (context, params) => const Searchpage1Widget(),
        ),
        FFRoute(
          name: 'Orderdetails',
          path: '/orderdetails',
          builder: (context, params) => OrderdetailsWidget(
            orderRef: params.getParam(
              'orderRef',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'Brandsignup1',
          path: '/brandsignup1',
          builder: (context, params) => const Brandsignup1Widget(),
        ),
        FFRoute(
          name: 'Alldesigners',
          path: '/alldesigners',
          builder: (context, params) => const AlldesignersWidget(),
        ),
        FFRoute(
          name: 'allbrands',
          path: '/allbrands',
          builder: (context, params) => const AllbrandsWidget(),
        ),
        FFRoute(
          name: 'ordercompletedCopy',
          path: '/ordercompletedCopy',
          builder: (context, params) => const OrdercompletedCopyWidget(),
        ),
        FFRoute(
          name: 'approval',
          path: '/approval',
          builder: (context, params) => const ApprovalWidget(),
        ),
        FFRoute(
          name: 'approvalCopy',
          path: '/approvalCopy',
          builder: (context, params) => const ApprovalCopyWidget(),
        ),
        FFRoute(
          name: 'paymentprocessingpage',
          path: '/paymentprocessingpage',
          builder: (context, params) => const PaymentprocessingpageWidget(),
        ),
        FFRoute(
          name: 'loginOrGuest',
          path: '/loginOrGuest',
          builder: (context, params) => const LoginOrGuestWidget(),
        ),
        FFRoute(
          name: 'CreateAnAccount',
          path: '/createAnAccount',
          builder: (context, params) => const CreateAnAccountWidget(),
        ),
        FFRoute(
          name: 'Homepage',
          path: '/homepage',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Homepage')
              : const NavBarPage(
                  initialPage: 'Homepage',
                  page: HomepageWidget(),
                ),
        ),
        FFRoute(
          name: 'addaddressPage',
          path: '/addaddressPage',
          builder: (context, params) => const AddaddressPageWidget(),
        ),
        FFRoute(
          name: 'productDescription',
          path: '/productDescription',
          builder: (context, params) => ProductDescriptionWidget(
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
            colorId: params.getParam(
              'colorId',
              ParamType.String,
            ),
            price: '',
          ),
        ),
        FFRoute(
          name: 'Settingscopy',
          path: '/settingscopy',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Settingscopy')
              : const SettingscopyWidget(),
        ),
        FFRoute(
          name: 'choosePayment',
          path: '/choosePayment',
          builder: (context, params) => ChoosePaymentWidget(
            amount: params.getParam(
              'amount',
              ParamType.double,
            ),
            cartId: params.getParam(
              'cartId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'HiddenGems',
          path: '/hiddenGems',
          builder: (context, params) => HiddenGemsWidget(
            designerId: params.getParam(
              'designerId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'DesignerStorePage',
          path: '/designerStorePage',
          builder: (context, params) => DesignerStorePageWidget(
            designerref: params.getParam(
              'designerref',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'CartPagenewCopy',
          path: '/cartPagenewCopy',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'CartPagenewCopy')
              : const CartPagenewCopyWidget(),
        ),
        FFRoute(
          name: 'forgotpassword',
          path: '/forgotpassword',
          builder: (context, params) => const ForgotpasswordWidget(),
        ),
        FFRoute(
          name: 'productDescriptionColor',
          path: '/productDescriptionColor',
          builder: (context, params) => ProductDescriptionColorWidget(
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
            price: params.getParam(
              'price',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'editaddresspage',
          path: '/editaddresspage',
          builder: (context, params) => const EditaddresspageWidget(),
        ),
        FFRoute(
          name: 'ApplyasacreatorPage',
          path: '/applyasacreatorPage',
          builder: (context, params) => const ApplyasacreatorPageWidget(),
        ),
        FFRoute(
          name: 'VideoContent',
          path: '/videoContent',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'VideoContent')
              : VideoContentWidget(
                  likedVideo: params.getParam(
                    'likedVideo',
                    ParamType.bool,
                  ),
                ),
        ),
        FFRoute(
          name: 'creatorProfile',
          path: '/creatorProfile',
          builder: (context, params) => const CreatorProfileWidget(),
        ),
        FFRoute(
          name: 'uploadVideo',
          path: '/uploadVideo',
          builder: (context, params) => const UploadVideoWidget(),
        ),
        FFRoute(
          name: 'ApplyFilters',
          path: '/applyFilters',
          builder: (context, params) => ApplyFiltersWidget(
            subCategoryid: params.getParam(
              'subCategoryid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'couponCode',
          path: '/couponCode',
          builder: (context, params) => const CouponCodeWidget(),
        ),
        FFRoute(
          name: 'ReturnRequest',
          path: '/returnRequest',
          builder: (context, params) => ReturnRequestWidget(
            orderId: params.getParam(
              'orderId',
              ParamType.String,
            ),
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ApplyFilterspageDesigner',
          path: '/applyFilterspageDesigner',
          builder: (context, params) => ApplyFilterspageDesignerWidget(
            subCategoryid: params.getParam(
              'subCategoryid',
              ParamType.String,
            ),
            designerRef: params.getParam(
              'designerRef',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ReturnRequestDetails',
          path: '/returnRequestDetails',
          builder: (context, params) => const ReturnRequestDetailsWidget(),
        ),
        FFRoute(
          name: 'ReturnExchange',
          path: '/returnExchange',
          builder: (context, params) => ReturnExchangeWidget(
            orderId: params.getParam(
              'orderId',
              ParamType.String,
            ),
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'returnexchangePage',
          path: '/returnexchangePage',
          builder: (context, params) => ReturnexchangePageWidget(
            orderId: params.getParam(
              'orderId',
              ParamType.String,
            ),
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'mobileverificationPage',
          path: '/mobileverificationPage',
          builder: (context, params) => MobileverificationPageWidget(
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'Otpscreen',
          path: '/otpscreen',
          builder: (context, params) => OtpscreenWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
            displayName: params.getParam(
              'displayName',
              ParamType.String,
            ),
            password: params.getParam(
              'password',
              ParamType.String,
            ),
            address: params.getParam(
              'address',
              ParamType.String,
            ),
            city: params.getParam(
              'city',
              ParamType.String,
            ),
            state: params.getParam(
              'state',
              ParamType.String,
            ),
            pincode: params.getParam(
              'pincode',
              ParamType.int,
            ),
            iscreator: params.getParam(
              'iscreator',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: 'LoginMobileScreen',
          path: '/loginMobileScreen',
          builder: (context, params) => const LoginMobileScreenWidget(),
        ),
        FFRoute(
          name: 'OtpLogin',
          path: '/otpLogin',
          builder: (context, params) => OtpLoginWidget(
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
            username: params.getParam(
              'username',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'productDescriptionCopy',
          path: '/productDescriptionCopy',
          builder: (context, params) => ProductDescriptionCopyWidget(
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
            colorId: params.getParam(
              'colorId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ManageAddress',
          path: '/manageAddress',
          builder: (context, params) => const ManageAddressWidget(),
        ),
        FFRoute(
          name: 'addnewaddress',
          path: '/addnewaddress',
          builder: (context, params) => const AddnewaddressWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginOrGuest';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Asset_3.webp',
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() =>
      const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
