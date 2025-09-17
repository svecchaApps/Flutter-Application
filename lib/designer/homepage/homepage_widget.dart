import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/nav/serialization_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '/backend/api_requests/recently_viewed_api.dart';
import '/backend/api_requests/trending_products_api.dart';
import '/backend/api_requests/banners_api.dart';
import '/utils/recently_viewed_helper.dart';
import 'homepage_shimmer.dart';
import '/designer/product_description_color/product_description_color_widget.dart';
import '/designer/video_content/video_content_widget.dart';
import '/services/auth_service.dart';
import '/utils/modern_snackbar.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  static String routeName = 'Homepage';
  static String routePath = '/homepage';

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget>
    with TickerProviderStateMixin {
  late HomepageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  // Video performance optimizations
  final ScrollController _scrollController = ScrollController();

  // Track video controllers for proper disposal
  final Map<String, VideoPlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TintEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Colors.black,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    // Add scroll listener for video performance optimization
    _scrollController.addListener(_onScroll);

    // Set up callback to refresh recently viewed when products are added
    RecentlyViewedHelper.setOnProductAddedCallback(() {
      if (mounted) {
        setState(() {
          // This will trigger a rebuild and refresh the recently viewed section
        });
      }
    });

    // Test the recently viewed endpoint on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RecentlyViewedApi.testRecentlyViewedEndpoint();
      BannersApi.testBannersEndpoint();
      // Temporarily comment out trending API test to avoid null error
      // try {
      //   TrendingProductsApi.testTrendingEndpoint();
      // } catch (e) {
      //   print('🔥 [HOMEPAGE] Error testing trending endpoint: $e');
      // }

      // Check if user profile is complete
      _checkProfileCompletion();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _scrollController.dispose();

    // Dispose all video controllers
    for (final controller in _videoControllers.values) {
      controller.dispose();
    }
    _videoControllers.clear();

    // Remove the callback when widget is disposed
    RecentlyViewedHelper.removeOnProductAddedCallback();

    super.dispose();
  }

  // Get responsive font size based on screen width
  double _getResponsiveFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 320) {
      return 12.0; // Very small screens
    } else if (screenWidth < 375) {
      return 13.0; // Small screens
    } else if (screenWidth < 414) {
      return 14.0; // Medium screens
    } else if (screenWidth < 600) {
      return 15.0; // Large screens
    } else {
      return 16.0; // Very large screens/tablets
    }
  }

  // Example method showing how to use authentication service
  void _handleAuthenticatedAction(BuildContext context) {
    context.withAuth(
      () async {
        // This code only runs if user is authenticated
        ModernSnackbar.success(
          context: context,
          message: 'Welcome back! You can now access premium features.',
        );
        // Perform authenticated action here
        return true;
      },
      message: 'Please login to access this feature',
      redirectRoute: 'LoginMobileScreen',
    );
  }

  void _showVideoPlayer(BuildContext context, String videoUrl, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Header with title and close button
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.volume_off,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Muted',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Video player
                Expanded(
                  child: _buildVideoPlayer(
                    videoUrl,
                    title,
                    'dialog_video_${DateTime.now().millisecondsSinceEpoch}',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isValidVideoUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return url.startsWith('http://') || url.startsWith('https://');
  }

  // Actual video player that loads and displays video
  Widget _buildVideoPlayer(String videoUrl, String title, String videoId) {
    if (videoUrl.isEmpty) {
      // Fallback to placeholder if no video URL
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[800]!, Colors.grey[900]!],
          ),
        ),
        child: const Center(
          child: Icon(Icons.video_library, color: Colors.white54, size: 50),
        ),
      );
    }

    return FutureBuilder<VideoPlayerController>(
      future: _initializeVideoController(videoUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey[800]!, Colors.grey[900]!],
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey[800]!, Colors.grey[900]!],
              ),
            ),
            child: const Center(
              child: Icon(Icons.error_outline, color: Colors.white54, size: 50),
            ),
          );
        }

        final controller = snapshot.data!;
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        );
      },
    );
  }

  // Initialize video controller
  Future<VideoPlayerController> _initializeVideoController(
    String videoUrl,
  ) async {
    // Check if controller already exists
    if (_videoControllers.containsKey(videoUrl)) {
      return _videoControllers[videoUrl]!;
    }

    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await controller.initialize();
    await controller.setLooping(true);
    await controller.setVolume(0.0); // Mute by default

    // Store controller for later disposal
    _videoControllers[videoUrl] = controller;

    return controller;
  }

  // Handle scroll events for video optimization
  void _onScroll() {
    // This can be used for lazy loading videos when they come into view
    // For now, we'll keep it simple and load all videos
  }

  // Check if user profile is complete and redirect if needed
  void _checkProfileCompletion() {
    // Check if user is logged in but profile is incomplete
    if (FFAppState().userId.isNotEmpty && !FFAppState().isProfileComplete) {
      print(
          '🏠 [HOMEPAGE] User profile incomplete, redirecting to add address page');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Please complete your profile setup to continue',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
              ),
              duration: const Duration(milliseconds: 3000),
              backgroundColor: FlutterFlowTheme.of(context).primary,
            ),
          );
          context.goNamed('addaddressPage');
        }
      });
    }
  }

  // Build video player with actual video content
  Widget _buildVideoThumbnail(String videoUrl, String title, String videoId) {
    return GestureDetector(
      onTap: () {
        // Navigate to video content page with the specific video
        // Determine tab based on video content (shopping vs fashion)
        const initialTabIndex = 1; // Default to FASHION tab

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VideoContentWidget(
              initialTabIndex: initialTabIndex,
              showBackButton: true,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          // Actual video player
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: _buildVideoPlayer(videoUrl, title, videoId),
          ),
          // Play button overlay
          Center(
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black87,
                size: 35,
              ),
            ),
          ),
          // Video title overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(140),
              child: AppBar(
                backgroundColor: FlutterFlowTheme.of(
                  context,
                ).secondaryBackground,
                automaticallyImplyLeading: false,
                actions: const [],
                flexibleSpace: FlexibleSpaceBar(
                  title: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0,
                            10.0,
                            15.0,
                            8.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/Asset_4.webp',
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  context.pushNamed('CartPagenewCopy');
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E6ED),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Color(0xFF263F96),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0,
                              0.0,
                              10.0,
                              0.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(
                                  context,
                                ).secondaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('searchpage1');
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0,
                                        0.0,
                                        12.0,
                                        0.0,
                                      ),
                                      child: Icon(
                                        Icons.search,
                                        color: Color(0xFF263F96),
                                        size: 16.0,
                                      ),
                                    ),
                                    Text(
                                      'Search here....',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                            color: const Color(0xFF999999),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  expandedTitleScale: 1.0,
                ),
                elevation: 0.0,
              ),
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Banners Section
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              20.0,
                              0.0,
                              0.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(
                                  context,
                                ).secondaryBackground,
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: FutureBuilder(
                                future: BannersApi.getBanners(),
                                builder: (
                                  context,
                                  AsyncSnapshot<List<Map<String, dynamic>>>
                                      snapshot,
                                ) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return HomepageShimmer.bannerShimmer();
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.grey[400],
                                            size: 48,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Error loading banners',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  final banners = snapshot.data ?? [];

                                  if (banners.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey[400],
                                            size: 48,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'No banners available',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Stack(
                                    children: [
                                      PageView.builder(
                                        itemCount: banners.length,
                                        itemBuilder: (context, index) {
                                          final banner = banners[index];
                                          final imageUrl = banner['imageUrl'] ??
                                              banner['image'] ??
                                              '';
                                          final title = banner['title'] ?? '';
                                          final description =
                                              banner['description'] ?? '';
                                          final actionUrl =
                                              banner['actionUrl'] ??
                                                  banner['link'] ??
                                                  '';

                                          return GestureDetector(
                                            onTap: () {
                                              if (actionUrl.isNotEmpty) {
                                                print(
                                                  '🔍 [BANNERS] Banner tapped: $actionUrl',
                                                );
                                                // Handle banner tap - could navigate to specific page or open URL
                                                // For now, just log the action
                                              }
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12.0,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 8,
                                                    offset: const Offset(
                                                      0,
                                                      4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12.0,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    // Banner Image
                                                    Image.network(
                                                      imageUrl,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: [
                                                                Colors
                                                                    .blue[300]!,
                                                                Colors.purple[
                                                                    300]!,
                                                              ],
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.image,
                                                            color: Colors.white,
                                                            size: 60,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    // Banner Content Overlay
                                                    if (title.isNotEmpty ||
                                                        description.isNotEmpty)
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black
                                                                    .withOpacity(
                                                                  0.7,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(
                                                            16.0,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              if (title
                                                                  .isNotEmpty)
                                                                Text(
                                                                  title,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              if (description
                                                                  .isNotEmpty)
                                                                Text(
                                                                  description,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // Page Indicators
                                      if (banners.length > 1)
                                        Positioned(
                                          bottom: 10,
                                          left: 0,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              banners.length,
                                              (index) => Container(
                                                width: 8,
                                                height: 8,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: index == 0
                                                      ? Colors.white
                                                      : Colors.white
                                                          .withOpacity(
                                                          0.5,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              10.0,
                              0.0,
                              0.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(
                                  context,
                                ).secondaryBackground,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              15.0,
                              0.0,
                              0.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: const BoxDecoration(),
                              child: FutureBuilder<http.Response>(
                                future: http.get(
                                  Uri.parse(
                                    'https://indigo-rhapsody-backend-ten.vercel.app/category',
                                  ),
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return HomepageShimmer
                                        .categoriesRowShimmer();
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Error loading categories',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.statusCode != 200) {
                                    return Center(
                                      child: Text(
                                        'No categories available',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }

                                  try {
                                    final Map<String, dynamic> responseData =
                                        json.decode(snapshot.data!.body);
                                    final List<dynamic> categories =
                                        responseData['categories'] ?? [];

                                    if (categories.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'No categories found',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categories.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 10.0),
                                      itemBuilder: (context, categoriesIndex) {
                                        final category =
                                            categories[categoriesIndex];
                                        return Container(
                                          width: MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.22,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                          ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              HapticFeedback.mediumImpact();
                                              print(
                                                'Tapped category: ${category['name']}',
                                              );

                                              // Navigate to designerCategoryClientyCopy with category ID
                                              context.pushNamed(
                                                'DesignerCategoryClientyCopy',
                                                queryParameters: {
                                                  'categoryref': serializeParam(
                                                    category['_id'] ?? '',
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.0,
                                                  ),
                                                  child: Image.network(
                                                    category['image'] ?? '',
                                                    width: MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        1.0,
                                                    height: MediaQuery.of(
                                                          context,
                                                        ).size.height *
                                                        0.126,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            1.0,
                                                        height: MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            0.126,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.image,
                                                          color:
                                                              Colors.grey[400],
                                                          size: 30,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                    0.0,
                                                    5.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                                  child: Text(
                                                    category['name'] ?? '',
                                                    style: FlutterFlowTheme.of(
                                                      context,
                                                    ).bodyMedium.override(
                                                          fontFamily:
                                                              FlutterFlowTheme
                                                                  .of(
                                                            context,
                                                          ).bodyMediumFamily,
                                                          color: Colors.black,
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                  .of(
                                                            context,
                                                          ).bodyMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    return Center(
                                      child: Text(
                                        'Error parsing data',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  10.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.network('').image,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          10.0,
                                          0.0,
                                          10.0,
                                          0.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Designers For You',
                                                style: FlutterFlowTheme.of(
                                                  context,
                                                ).bodyMedium.override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                        context,
                                                      ).bodyMediumFamily,
                                                      fontSize:
                                                          _getResponsiveFontSize(
                                                              context),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                        context,
                                                      ).bodyMedium.fontStyle,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                        context,
                                                      ).bodyMediumIsCustom,
                                                    ),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.23,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryBackground,
                                        ),
                                        child: FutureBuilder<http.Response>(
                                          future: http.get(
                                            Uri.parse(
                                              'https://indigo-rhapsody-backend-ten.vercel.app/designer/designers',
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return HomepageShimmer
                                                  .trendingProductsShimmer();
                                            }

                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                  'Error loading designers',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.statusCode !=
                                                    200) {
                                              return Center(
                                                child: Text(
                                                  'No designers available',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }

                                            try {
                                              final Map<String, dynamic>
                                                  responseData = json.decode(
                                                snapshot.data!.body,
                                              );
                                              final List<dynamic> designers =
                                                  responseData['designers'] ??
                                                      [];

                                              if (designers.isEmpty) {
                                                return Center(
                                                  child: Text(
                                                    'No designers found',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }

                                              return ListView.separated(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: designers.length,
                                                separatorBuilder: (_, __) =>
                                                    const SizedBox(width: 10.0),
                                                itemBuilder:
                                                    (context, designersIndex) {
                                                  final designersItem =
                                                      designers[designersIndex];
                                                  return Container(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                        context,
                                                      ).secondaryBackground,
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        HapticFeedback
                                                            .mediumImpact();

                                                        context.pushNamed(
                                                          HiddenGemsWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'designerId':
                                                                serializeParam(
                                                              designersItem[
                                                                      '_id']
                                                                  .toString(),
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              8.0,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              designersItem[
                                                                      'logoUrl'] ??
                                                                  'https://picsum.photos/seed/807/600',
                                                              width: 200.0,
                                                              height: MediaQuery
                                                                          .of(
                                                                    context,
                                                                  )
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) {
                                                                return Container(
                                                                  width: 200.0,
                                                                  height: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).size.height *
                                                                      0.15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      8.0,
                                                                    ),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.store,
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    size: 30,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                              0.0,
                                                              5.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                            child: SizedBox(
                                                              height: 40,
                                                              child: Text(
                                                                designersItem[
                                                                            'userId']
                                                                        ?[
                                                                        'displayName'] ??
                                                                    'Unknown Designer',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme
                                                                              .of(
                                                                        context,
                                                                      ).bodyMediumFamily,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme
                                                                              .of(
                                                                        context,
                                                                      ).bodyMediumIsCustom,
                                                                    ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } catch (e) {
                                              return Center(
                                                child: Text(
                                                  'Error parsing data',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          10.0,
                                          15.0,
                                          10.0,
                                          0.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Style inspiration For You!!',
                                              style: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                      context,
                                                    ).bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).primaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                      context,
                                                    ).bodyMedium.fontStyle,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                      context,
                                                    ).bodyMediumIsCustom,
                                                  ),
                                            ).animateOnPageLoad(
                                              animationsMap[
                                                  'textOnPageLoadAnimation']!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          0.0,
                                          5.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          height: MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.25,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFEFF7FF),
                                          ),
                                          child: FutureBuilder<http.Response>(
                                            future: http.get(
                                              Uri.parse(
                                                'https://indigo-rhapsody-backend-ten.vercel.app/content-video/videos',
                                              ),
                                            ),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return HomepageShimmer
                                                    .videoShimmer();
                                              }

                                              if (snapshot.hasError) {
                                                print(
                                                  'API Error: ${snapshot.error}',
                                                );
                                                return Center(
                                                  child: Text(
                                                    'Error loading videos',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.statusCode !=
                                                      200) {
                                                print(
                                                  'API Status Code: ${snapshot.data?.statusCode}',
                                                );
                                                print(
                                                  'API Response: ${snapshot.data?.body}',
                                                );
                                                return Center(
                                                  child: Text(
                                                    'No videos available',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }

                                              try {
                                                final Map<String, dynamic>
                                                    responseData = json.decode(
                                                  snapshot.data!.body,
                                                );
                                                print(
                                                  'API Response Data: $responseData',
                                                );

                                                final List<dynamic> videos =
                                                    responseData['videos'] ??
                                                        [];

                                                print('Videos array: $videos');
                                                print(
                                                  'Number of videos: ${videos.length}',
                                                );

                                                if (videos.isEmpty) {
                                                  return Center(
                                                    child: Text(
                                                      'No videos found',
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  );
                                                }

                                                return ListView.separated(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20.0,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: videos.length,
                                                  separatorBuilder: (_, __) =>
                                                      const SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  itemBuilder:
                                                      (context, videoIndex) {
                                                    final video =
                                                        videos[videoIndex];

                                                    // Debug: Print the video object
                                                    print(
                                                      'Video object: $video',
                                                    );
                                                    print(
                                                      'Video URL type: ${video['videoUrl'].runtimeType}',
                                                    );
                                                    print(
                                                      'Video URL value: ${video['videoUrl']}',
                                                    );
                                                    print(
                                                      'Video ID: ${video['_id']}',
                                                    );
                                                    print(
                                                      'User: ${video['userId']?['displayName']}',
                                                    );
                                                    print(
                                                      'Likes: ${video['likes']}',
                                                    );
                                                    print(
                                                      'Product Tagged: ${video['productTagged']}',
                                                    );

                                                    // Handle videoUrl as array - get first video URL
                                                    String? videoUrl;
                                                    if (video['videoUrl'] !=
                                                        null) {
                                                      if (video['videoUrl']
                                                          is List) {
                                                        // If it's an array, get the first URL
                                                        final videoUrls =
                                                            video['videoUrl']
                                                                as List;
                                                        if (videoUrls
                                                            .isNotEmpty) {
                                                          videoUrl = videoUrls
                                                              .first
                                                              .toString();
                                                        }
                                                      } else {
                                                        // If it's a string, use it directly
                                                        videoUrl =
                                                            video['videoUrl']
                                                                .toString();
                                                      }
                                                    }

                                                    // Validate video URL
                                                    final isValidVideo =
                                                        _isValidVideoUrl(
                                                      videoUrl,
                                                    );

                                                    return Container(
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.width *
                                                          0.35,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                          context,
                                                        ).secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          12.0,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                              0.1,
                                                            ),
                                                            blurRadius: 4,
                                                            offset:
                                                                const Offset(
                                                              0,
                                                              2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Navigate to video content page
                                                          print(
                                                            'Tapped video: ${video['_id']}',
                                                          );
                                                          print(
                                                            'Video URL for tap: $videoUrl',
                                                          );

                                                          // Check if video has products to determine tab
                                                          final hasProducts = video[
                                                                      'products'] !=
                                                                  null &&
                                                              (video['products']
                                                                      as List)
                                                                  .isNotEmpty;

                                                          // Navigate to video content page with appropriate tab
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoContentWidget(
                                                                initialTabIndex:
                                                                    hasProducts
                                                                        ? 0
                                                                        : 1, // 0 = SHOPPING, 1 = FASHION
                                                                showBackButton:
                                                                    true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            // Video thumbnail - always show thumbnail for better performance
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                12.0,
                                                              ),
                                                              child:
                                                                  _buildVideoThumbnail(
                                                                videoUrl ?? '',
                                                                video['title'] ??
                                                                    (video['userId'] !=
                                                                            null
                                                                        ? video['userId']['displayName'] ??
                                                                            'Video'
                                                                        : 'Video'),
                                                                video['_id']
                                                                        ?.toString() ??
                                                                    'video_${DateTime.now().millisecondsSinceEpoch}',
                                                              ),
                                                            ),
                                                            // Mute indicator overlay
                                                            Positioned(
                                                              top: 8,
                                                              right: 8,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                  4,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                    0.6,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .volume_off,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } catch (e) {
                                                return Center(
                                                  child: Text(
                                                    'Error parsing data',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0,
                              0.0,
                              10.0,
                              0.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              10.0,
                              0.0,
                              0.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(
                                  context,
                                ).secondaryBackground,
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.network(
                                  'https://i.pinimg.com/originals/24/c7/b6/24c7b6bc82dec49ffce7f23a0822109f.png',
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.38,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/indigo-rhapsody-dupli-7begfm/assets/6sc684gqifpu/HTEX440230_1.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1E3A8A), // Dark blue
                                      Color(0xFF3B82F6), // Medium blue
                                      Color(0xFF60A5FA), // Light blue
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                        15.0,
                                        15.0,
                                        15.0,
                                        0.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'TRENDS JUST FOR YOU',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.firaMono(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                      context,
                                                    ).bodyMedium.fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).secondaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMedium.fontStyle,
                                                ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                // Trigger refresh of trending products
                                                print(
                                                  '🔥 [HOMEPAGE] Manual refresh of trending products triggered',
                                                );
                                              });
                                            },
                                            icon: Icon(
                                              Icons.refresh,
                                              size: 20,
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        5.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.29,
                                        decoration: const BoxDecoration(),
                                        child: FutureBuilder<
                                            List<Map<String, dynamic>>?>(
                                          future: () async {
                                            // Temporarily return empty list to test import
                                            print(
                                              '🔥 [HOMEPAGE] Testing trending API import...',
                                            );
                                            try {
                                              // Test if the class exists
                                              print(
                                                '🔥 [HOMEPAGE] TrendingProductsApi class test...',
                                              );
                                              return await TrendingProductsApi
                                                  .getTrendingProducts();
                                            } catch (e) {
                                              print(
                                                '🔥 [HOMEPAGE] Error fetching trending products: $e',
                                              );
                                              return <Map<String, dynamic>>[];
                                            }
                                          }(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return HomepageShimmer
                                                  .trendingProductsShimmer();
                                            }

                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                  'Error loading trending products',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }

                                            final products = snapshot.data;
                                            if (products == null ||
                                                products.isEmpty) {
                                              return const SizedBox
                                                  .shrink(); // Don't show section if no products
                                            }

                                            return ListView.separated(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: products.length,
                                              separatorBuilder: (_, __) =>
                                                  const SizedBox(width: 15.0),
                                              itemBuilder: (context, index) {
                                                final product = products[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    // Navigate to product details
                                                    final productId =
                                                        product['_id'] ??
                                                            product['id'];
                                                    final productPrice =
                                                        product['price']
                                                                ?.toString() ??
                                                            '0';
                                                    if (productId != null) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDescriptionColorWidget(
                                                            productId: productId
                                                                .toString(),
                                                            price: productPrice,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.35,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 15.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        16.0,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(
                                                            0.08,
                                                          ),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                            0,
                                                            4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Product Image
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                              16.0,
                                                            ),
                                                            topRight:
                                                                Radius.circular(
                                                              16.0,
                                                            ),
                                                          ),
                                                          child: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height: MediaQuery
                                                                    .of(
                                                                  context,
                                                                ).size.height *
                                                                0.15,
                                                            child:
                                                                Image.network(
                                                              _getProductImage(
                                                                product,
                                                              ),
                                                              width: double
                                                                  .infinity,
                                                              height: MediaQuery
                                                                          .of(
                                                                    context,
                                                                  )
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) {
                                                                return Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).size.height *
                                                                      0.15,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/indigo-rhapsody-dupli-7begfm/assets/6sc684gqifpu/HTEX440230_1.png',
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .image,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        // Product Details
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(
                                                            12.0,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _getProductTitle(
                                                                  product,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0,
                                                                      ),
                                                                    ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                _getProductDescription(
                                                                  product,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        179,
                                                                        0,
                                                                        0,
                                                                        0,
                                                                      ),
                                                                    ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    _getProductPrice(
                                                                      product,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          color:
                                                                              const Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green[50],
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        12,
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .green[200]!,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Trending',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .green[700],
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0,
                                  5.0,
                                  15.0,
                                  0.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recently Viewed',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.notoSansJp(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // Trigger refresh of recently viewed by rebuilding the widget
                                          print(
                                            '🔄 [HOMEPAGE] Manual refresh of recently viewed triggered',
                                          );
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                        size: 20,
                                        color: Color(0xFF263F96),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.25,
                                decoration: const BoxDecoration(),
                                child:
                                    FutureBuilder<List<Map<String, dynamic>>?>(
                                  future: RecentlyViewedHelper
                                      .getRecentlyViewedProducts(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return HomepageShimmer
                                          .recentlyViewedShimmer();
                                    }

                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          'Error loading recently viewed',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    }

                                    final products = snapshot.data;
                                    if (products == null || products.isEmpty) {
                                      return const SizedBox
                                          .shrink(); // Don't show section if no products
                                    }

                                    return ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: products.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 18.0),
                                      itemBuilder: (context, index) {
                                        final product = products[index];
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(
                                            0.0,
                                            10.0,
                                            0.0,
                                            10.0,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigate to product details
                                              final productId =
                                                  product['_id'] ??
                                                      product['id'];
                                              final productPrice =
                                                  product['price']
                                                          ?.toString() ??
                                                      '0';
                                              if (productId != null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDescriptionColorWidget(
                                                      productId:
                                                          productId.toString(),
                                                      price: productPrice,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: MediaQuery.sizeOf(
                                                    context,
                                                  ).width *
                                                  0.273,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top: Radius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      _getProductImage(product),
                                                      width: 200.0,
                                                      height: MediaQuery.sizeOf(
                                                            context,
                                                          ).height *
                                                          0.15,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return Container(
                                                          width: 200.0,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                    context,
                                                                  ).height *
                                                                  0.15,
                                                          color:
                                                              Colors.grey[200],
                                                          child: const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            color: Colors.grey,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                      8.0,
                                                      5.0,
                                                      8.0,
                                                      0.0,
                                                    ),
                                                    child: Text(
                                                      _getProductTitle(product),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                        context,
                                                      ).bodyMedium.override(
                                                                font: GoogleFonts
                                                                    .encodeSans(
                                                                  fontWeight:
                                                                      FlutterFlowTheme
                                                                          .of(
                                                                    context,
                                                                  ).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme
                                                                          .of(
                                                                    context,
                                                                  )
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    FlutterFlowTheme
                                                                            .of(
                                                                  context,
                                                                )
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                              ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                      8.0,
                                                      5.0,
                                                      8.0,
                                                      8.0,
                                                    ),
                                                    child: Text(
                                                      _getProductPrice(product),
                                                      style: FlutterFlowTheme
                                                              .of(
                                                        context,
                                                      ).bodyMedium.override(
                                                            fontFamily:
                                                                FlutterFlowTheme
                                                                    .of(
                                                              context,
                                                            ).bodyMediumFamily,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: const Color(
                                                              0xFF263F96,
                                                            ),
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme
                                                                    .of(
                                                              context,
                                                            ).bodyMediumIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\"I Don\'t design clothes i design dreams\"',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.eduSaBeginner(
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                    ),
                                    Text(
                                      '-Ralph lauren',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.eduSaBeginner(
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(
                                    context,
                                  ).primaryBackground,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    10.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'INDIGO RHAPSODY',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.encodeSans(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FlutterFlowTheme.of(
                                                  context,
                                                ).bodyMedium.fontStyle,
                                              ),
                                              color: const Color(0xFF787878),
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                      ),
                                      Text(
                                        'Made In 🇮🇳',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.encodeSans(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FlutterFlowTheme.of(
                                                  context,
                                                ).bodyMedium.fontStyle,
                                              ),
                                              color: const Color(0xFFBDBDBD),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodyMedium.fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Recently Viewed Section
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getProductImage(Map<String, dynamic> product) {
    // Try to get the first image from the product
    if (product['images'] != null &&
        product['images'] is List &&
        (product['images'] as List).isNotEmpty) {
      return product['images'][0];
    }

    // Fallback to image field if it exists
    if (product['image'] != null) {
      return product['image'];
    }

    // Fallback to coverImage field (from recently viewed API)
    if (product['coverImage'] != null) {
      return product['coverImage'];
    }

    // Default placeholder image
    return 'https://picsum.photos/seed/922/600';
  }

  String _getProductTitle(Map<String, dynamic> product) {
    // Try different possible title fields
    if (product['name'] != null) {
      return product['name'];
    }
    if (product['title'] != null) {
      return product['title'];
    }
    if (product['displayName'] != null) {
      return product['displayName'];
    }
    if (product['productName'] != null) {
      return product['productName'];
    }

    // Default fallback
    return 'Product Name';
  }

  String _getProductPrice(Map<String, dynamic> product) {
    // Try different possible price fields
    if (product['price'] != null) {
      final price = product['price'];
      if (price is num) {
        return '₹${price.toStringAsFixed(0)}';
      }
      if (price is String) {
        return '₹$price';
      }
    }

    if (product['cost'] != null) {
      final cost = product['cost'];
      if (cost is num) {
        return '₹${cost.toStringAsFixed(0)}';
      }
      if (cost is String) {
        return '₹$cost';
      }
    }

    if (product['mrp'] != null) {
      final mrp = product['mrp'];
      if (mrp is num) {
        return '₹${mrp.toStringAsFixed(0)}';
      }
      if (mrp is String) {
        return '₹$mrp';
      }
    }

    // Default fallback
    return '₹0';
  }

  String _getProductDescription(Map<String, dynamic> product) {
    // Try different possible description fields
    if (product['description'] != null) {
      final description = product['description'];
      if (description is String) {
        // Return first 50 characters or first sentence
        if (description.length > 50) {
          return '${description.substring(0, 50)}...';
        }
        return description;
      }
    }

    if (product['subtitle'] != null) {
      final subtitle = product['subtitle'];
      if (subtitle is String) {
        return subtitle;
      }
    }

    if (product['category'] != null && product['category'] is Map) {
      final category = product['category'];
      if (category['name'] != null) {
        return category['name'];
      }
    }

    // Default fallback
    return 'Trending Products';
  }
}
