import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '/backend/api_requests/api_calls.dart';
import '/components/comment_box_widget.dart';
import '/components/commenttext_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/designer/product_description_color/product_description_color_widget.dart';
import '/designer/hidden_gems/hidden_gems_widget.dart';

import 'video_content_model.dart';

class VideoContentWidget extends StatefulWidget {
  const VideoContentWidget({
    super.key,
    this.videoUrl,
    this.likedVideo,
    this.singleVideo, // 🔹 NEW – full JSON of one reel
    this.initialTabIndex, // 🔹 NEW – specify which tab to open initially
    this.showBackButton = false, // 🔹 NEW – whether to show back button
  });

  final bool? likedVideo;
  final String? videoUrl;
  final Map<String, dynamic>? singleVideo; // 🔹 NEW
  final int? initialTabIndex; // 🔹 NEW
  final bool showBackButton; // 🔹 NEW

  static String routeName = 'VideoContent';
  static String routePath = '/videoContent';

  @override
  State<VideoContentWidget> createState() => _VideoContentWidgetState();
}

class _VideoContentWidgetState extends State<VideoContentWidget>
    with TickerProviderStateMixin {
  late VideoContentModel _model;
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool get _isSingle => widget.singleVideo != null;

  // Video controller management
  final Map<String, VideoPlayerController> _videoControllers = {};
  final Map<String, bool> _videoInitialized = {};

  // Track which videos belong to which tab
  final Set<String> _shoppingVideoIds = <String>{};
  final Set<String> _fashionVideoIds = <String>{};

  // Shopping tab video navigation
  int _currentShoppingVideoIndex = 0;
  List<dynamic> _shoppingVideos = [];
  late PageController _shoppingPageController;

  // Reaction state management
  final Map<String, String> _userReactions =
      {}; // videoId -> reactionType (like/dislike)
  final Map<String, int> _reactionCounts = {}; // videoId -> like count
  final Map<String, int> _dislikeCounts = {}; // videoId -> dislike count

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoContentModel());
    _tabController = TabController(length: 2, vsync: this);
    _shoppingPageController = PageController();

    // Set initial tab if specified
    if (widget.initialTabIndex != null) {
      _selectedTabIndex = widget.initialTabIndex!;
      _tabController.animateTo(widget.initialTabIndex!);
    }

    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
      // Handle video playback based on tab switching
      _handleTabChange(_tabController.index);
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _tabController.dispose();
    // Dispose all video controllers
    for (final controller in _videoControllers.values) {
      controller.dispose();
    }
    _videoControllers.clear();
    super.dispose();
  }

  // Handle tab change and control video playback
  void _handleTabChange(int tabIndex) {
    print(
        '🔍 [VIDEO_CONTROL] Tab changed to: ${tabIndex == 0 ? "SHOPPING" : "FASHION"}');

    // Pause ALL videos immediately when switching tabs
    _pauseAllVideos();
  }

  // Pause all videos immediately when switching tabs
  void _pauseAllVideos() {
    print('🔍 [VIDEO_CONTROL] Pausing ALL videos due to tab switch');

    for (final entry in _videoControllers.entries) {
      final videoId = entry.key;
      final controller = entry.value;

      if (controller.value.isInitialized && controller.value.isPlaying) {
        controller.pause();
        print('🔍 [VIDEO_CONTROL] Paused video: $videoId');
      }
    }

    // Update UI to reflect the paused state
    setState(() {});
  }

  // Handle page change in fashion tab
  void _handlePageChange(int index, List<dynamic> videos) {
    if (_selectedTabIndex != 1) return; // Only handle if on fashion tab

    print('🔍 [VIDEO_CONTROL] Page changed to index: $index');

    // Initialize video if not ready, but don't auto-pause others
    if (index < videos.length) {
      final currentVideo = videos[index];
      final videoId = getJsonField(currentVideo, r'''$._id''').toString();
      print('🔍 [VIDEO_CONTROL] Switched to fashion video: $videoId');

      // Initialize if not ready
      if (!_videoControllers.containsKey(videoId) ||
          _videoInitialized[videoId] != true) {
        final videoUrl = _getVideoUrl(currentVideo);
        if (videoUrl.isNotEmpty) {
          _initializeVideoController(videoId, videoUrl, tabType: 'fashion');
        }
      }
    }
  }

  // Initialize video controller for a specific video
  Future<void> _initializeVideoController(String videoId, String videoUrl,
      {String? tabType}) async {
    if (_videoControllers.containsKey(videoId) &&
        _videoInitialized[videoId] == true) {
      print('🔍 [VIDEO_CONTROL] Video already initialized: $videoId');
      return; // Already initialized
    }

    // Check if initialization is already in progress
    if (_videoControllers.containsKey(videoId) &&
        _videoInitialized[videoId] == false) {
      print(
          '🔍 [VIDEO_CONTROL] Video initialization already in progress: $videoId');
      return;
    }

    try {
      print(
          '🔍 [VIDEO_CONTROL] Starting initialization for video: $videoId, tabType: $tabType');
      print('🔍 [VIDEO_CONTROL] Video URL: $videoUrl');

      final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      _videoControllers[videoId] = controller;

      print('🔍 [VIDEO_CONTROL] Controller created, initializing...');
      await controller.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print(
              '🔍 [VIDEO_CONTROL] Video initialization timeout for: $videoId');
          throw TimeoutException(
              'Video initialization timeout', const Duration(seconds: 10));
        },
      );
      _videoInitialized[videoId] = true;
      print('🔍 [VIDEO_CONTROL] Controller initialized successfully: $videoId');

      // Set looping
      controller.setLooping(true);

      // Track which tab this video belongs to
      if (tabType == 'shopping' || _selectedTabIndex == 0) {
        _shoppingVideoIds.add(videoId);
        print('🔍 [VIDEO_CONTROL] Added video to shopping tab: $videoId');
        print('🔍 [VIDEO_CONTROL] Shopping video IDs now: $_shoppingVideoIds');
      } else {
        _fashionVideoIds.add(videoId);
        print('🔍 [VIDEO_CONTROL] Added video to fashion tab: $videoId');
        print('🔍 [VIDEO_CONTROL] Fashion video IDs now: $_fashionVideoIds');
      }

      // Set initial volume and playback - start paused for user control
      controller.setVolume(1.0);
      controller.pause();
      print(
          '🔍 [VIDEO_CONTROL] Video initialized with sound and paused: $videoId');

      // Verify the controller is properly set up
      print(
          '🔍 [VIDEO_CONTROL] Final controller state - initialized: ${controller.value.isInitialized}, playing: ${controller.value.isPlaying}, volume: ${controller.value.volume}');

      setState(() {});
    } catch (e) {
      print('🔍 [VIDEO_CONTROL] Error initializing video controller: $e');
    }
  }

  // Handle visit store button tap
  void _handleVisitStore(dynamic currentVideo) {
    if (currentVideo == null) return;

    // Enhanced designer ID extraction based on product's designerRef._id
    String designerId = '';

    print('🔍 [SHOPPING] === DESIGNER ID EXTRACTION DEBUG ===');
    print('🔍 [SHOPPING] Current video: $currentVideo');
    print('🔍 [SHOPPING] Video keys: ${currentVideo.keys.toList()}');

    // Get products from current video
    final products = currentVideo['products'] as List? ?? [];
    print('🔍 [SHOPPING] Products count: ${products.length}');

    // Extract designer ID from the first product's designerRef._id
    if (products.isNotEmpty) {
      final firstProduct = products[0];
      print('🔍 [SHOPPING] First product: $firstProduct');

      if (firstProduct['productId'] != null) {
        final productId = firstProduct['productId'] as Map<String, dynamic>;
        print('🔍 [SHOPPING] ProductId keys: ${productId.keys.toList()}');

        if (productId['designerRef'] != null) {
          final designerRef = productId['designerRef'] as Map<String, dynamic>;
          print('🔍 [SHOPPING] DesignerRef keys: ${designerRef.keys.toList()}');

          if (designerRef['_id'] != null) {
            designerId = designerRef['_id'].toString();
            print(
                '🔍 [SHOPPING] ✅ Found designerId from product.designerRef._id: $designerId');
          } else {
            print('🔍 [SHOPPING] ❌ designerRef._id is null');
          }
        } else {
          print('🔍 [SHOPPING] ❌ designerRef is null');
        }
      } else {
        print('🔍 [SHOPPING] ❌ productId is null');
      }
    } else {
      print('🔍 [SHOPPING] ❌ No products available');
    }

    // Fallback to video's userId._id if no product designerRef found
    if (designerId.isEmpty && currentVideo['userId'] != null) {
      print('🔍 [SHOPPING] Falling back to userId._id');
      if (currentVideo['userId'] is Map) {
        final userIdMap = currentVideo['userId'] as Map;
        if (userIdMap['_id'] != null) {
          designerId = userIdMap['_id'].toString();
          print(
              '🔍 [SHOPPING] ✅ Found designerId from fallback userId._id: $designerId');
        }
      } else if (currentVideo['userId'] is String) {
        designerId = currentVideo['userId'].toString();
        print(
            '🔍 [SHOPPING] ✅ Found designerId from fallback userId (string): $designerId');
      }
    }

    // Additional fallback checks
    if (designerId.isEmpty && currentVideo['designerId'] != null) {
      designerId = currentVideo['designerId'].toString();
      print(
          '🔍 [SHOPPING] ✅ Found designerId from designerId field: $designerId');
    }

    if (designerId.isEmpty && currentVideo['creatorId'] != null) {
      designerId = currentVideo['creatorId'].toString();
      print(
          '🔍 [SHOPPING] ✅ Found designerId from creatorId field: $designerId');
    }

    print('🔍 [SHOPPING] Final designerId: "$designerId"');
    print('🔍 [SHOPPING] Designer ID length: ${designerId.length}');
    print('🔍 [SHOPPING] === END DESIGNER ID EXTRACTION DEBUG ===');

    if (designerId.isNotEmpty) {
      print(
          '🔍 [SHOPPING] ✅ Navigating to HiddenGems with designerId: $designerId');

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                  'Opening ${currentVideo['userId']?['displayName'] ?? 'Designer'} store...'),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HiddenGemsWidget(
            designerId: designerId,
          ),
        ),
      );
      print('🔍 [SHOPPING] ✅ Navigation completed');
    } else {
      print('🔍 [SHOPPING] ❌ No designer ID available for Visit Store');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Designer information not available'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  // Handle video reaction (like/dislike toggle)
  Future<void> _handleVideoReaction(String videoId) async {
    // Store current state for rollback if needed
    final previousReaction = _userReactions[videoId];
    final previousLikeCount = _reactionCounts[videoId] ?? 0;
    final previousDislikeCount = _dislikeCounts[videoId] ?? 0;

    try {
      // Get current user ID from app state
      final userId = FFAppState().userId;
      if (userId.isEmpty) {
        print('🔍 [REACTION] Error: No user ID available');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to react to videos'),
          ),
        );
        return;
      }

      // Determine reaction type based on current state
      String reactionType;
      if (_userReactions[videoId] == 'like') {
        reactionType = 'dislike'; // Switch to dislike
      } else if (_userReactions[videoId] == 'dislike') {
        reactionType = 'like'; // Switch to like
      } else {
        reactionType = 'like'; // Default to like
      }

      print(
          '🔍 [REACTION] Toggling reaction: $reactionType for video: $videoId');
      print('🔍 [REACTION] Using user ID: $userId');

      // Update UI immediately (optimistic update)
      setState(() {
        if (reactionType == 'like') {
          if (previousReaction == 'dislike') {
            // Switching from dislike to like
            _dislikeCounts[videoId] =
                (previousDislikeCount - 1).clamp(0, double.infinity).toInt();
          }
          _userReactions[videoId] = 'like';
          _reactionCounts[videoId] = previousReaction == 'like'
              ? previousLikeCount - 1
              : previousLikeCount + 1;
        } else {
          if (previousReaction == 'like') {
            // Switching from like to dislike
            _reactionCounts[videoId] =
                (previousLikeCount - 1).clamp(0, double.infinity).toInt();
          }
          _userReactions[videoId] = 'dislike';
          _dislikeCounts[videoId] = previousReaction == 'dislike'
              ? previousDislikeCount - 1
              : previousDislikeCount + 1;
        }
      });

      // Make direct HTTP request to the correct endpoint
      final url = Uri.parse(
          'https://indigo-rhapsody-backend-ten.vercel.app/content-video/videos/$videoId/reaction');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'reactionType': reactionType,
        }),
      );

      print('🔍 [REACTION] Response status: ${response.statusCode}');
      print('🔍 [REACTION] Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] ?? '';

        print('🔍 [REACTION] Response: message=$message');
        print('🔍 [REACTION] Full response data: $responseData');

        // Update with actual server data
        setState(() {
          final updatedVideo = responseData['video'];

          if (updatedVideo != null) {
            final currentUserId = FFAppState().userId;
            final likedBy = updatedVideo['likedBy'] as List? ?? [];
            final dislikedBy = updatedVideo['dislikedBy'] as List? ?? [];

            // Update user reaction state
            if (likedBy.contains(currentUserId)) {
              _userReactions[videoId] = 'like';
            } else if (dislikedBy.contains(currentUserId)) {
              _userReactions[videoId] = 'dislike';
            } else {
              _userReactions.remove(videoId); // No reaction
            }

            // Update counts from API response
            _reactionCounts[videoId] = updatedVideo['no_of_likes'] ?? 0;
            _dislikeCounts[videoId] = updatedVideo['no_of_dislikes'] ?? 0;

            print(
                '🔍 [REACTIONS] Updated reaction for video $videoId: ${_userReactions[videoId]}');
            print(
                '🔍 [REACTIONS] Updated counts - likes: ${_reactionCounts[videoId]}, dislikes: ${_dislikeCounts[videoId]}');
          }
        });

        // Show success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Video ${reactionType}d successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        print('🔍 [REACTION] HTTP Error: ${response.statusCode}');

        // Rollback optimistic update on error
        setState(() {
          if (previousReaction != null) {
            _userReactions[videoId] = previousReaction;
          } else {
            _userReactions.remove(videoId);
          }
          _reactionCounts[videoId] = previousLikeCount;
          _dislikeCounts[videoId] = previousDislikeCount;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update reaction. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('🔍 [REACTION] Error: $e');

      // Rollback optimistic update on error
      setState(() {
        if (previousReaction != null) {
          _userReactions[videoId] = previousReaction;
        } else {
          _userReactions.remove(videoId);
        }
        _reactionCounts[videoId] = previousLikeCount;
        _dislikeCounts[videoId] = previousDislikeCount;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please check your connection.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Initialize user reactions from API response data
  void _initializeUserReactions(List<dynamic> videos) {
    final currentUserId = FFAppState().userId;
    if (currentUserId.isEmpty) return;

    print('🔍 [REACTIONS] Initializing reactions for user: $currentUserId');

    for (final video in videos) {
      final videoId = video['_id']?.toString() ?? '';
      if (videoId.isEmpty) continue;

      // Check if user has liked this video
      final likedBy = video['likedBy'] as List? ?? [];
      if (likedBy.contains(currentUserId)) {
        _userReactions[videoId] = 'like';
        print('🔍 [REACTIONS] User has liked video: $videoId');
      }

      // Check if user has disliked this video
      final dislikedBy = video['dislikedBy'] as List? ?? [];
      if (dislikedBy.contains(currentUserId)) {
        _userReactions[videoId] = 'dislike';
        print('🔍 [REACTIONS] User has disliked video: $videoId');
      }

      // Update reaction counts
      _reactionCounts[videoId] = video['no_of_likes'] ?? 0;
      _dislikeCounts[videoId] = video['no_of_dislikes'] ?? 0;
    }

    print('🔍 [REACTIONS] Initialized reactions: $_userReactions');
  }

  // Get user's current reaction for a video
  String? _getUserReaction(String videoId) {
    return _userReactions[videoId];
  }

  // Check if video is currently playing
  bool _isVideoPlaying(String videoId) {
    final controller = _videoControllers[videoId];
    return controller != null &&
        controller.value.isInitialized &&
        controller.value.isPlaying;
  }

  // Toggle video playback (play/pause) - Independent control
  void _toggleVideoPlayback(String videoId) {
    final controller = _videoControllers[videoId];
    if (controller != null && controller.value.isInitialized) {
      if (controller.value.isPlaying) {
        // Pause the current video
        controller.pause();
        print('🔍 [VIDEO_CONTROL] User paused video: $videoId');
      } else {
        // Before playing, pause all other videos to prevent audio bleeding
        _pauseAllOtherVideos(videoId);

        // Play the selected video
        controller.setVolume(1.0); // Ensure audio is enabled
        controller.play();
        print('🔍 [VIDEO_CONTROL] User playing video: $videoId');
      }
      setState(() {}); // Update UI to reflect play/pause state
    }
  }

  // Pause all videos except the specified one
  void _pauseAllOtherVideos(String exceptVideoId) {
    for (final entry in _videoControllers.entries) {
      final videoId = entry.key;
      final controller = entry.value;

      if (videoId != exceptVideoId &&
          controller.value.isInitialized &&
          controller.value.isPlaying) {
        controller.pause();
        print('🔍 [VIDEO_CONTROL] Paused other video: $videoId');
      }
    }
  }

  // Show comment bottom sheet
  void _showCommentBottomSheet(String videoId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.3, // 30% of screen height
        minChildSize: 0.2, // Minimum 20% of screen height
        maxChildSize: 0.8, // Maximum 80% of screen height
        builder: (context, scrollController) => _CommentBottomSheet(
          videoId: videoId,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    if (_isSingle) {
      final video = widget.singleVideo!;
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          elevation: 0,
          automaticallyImplyLeading: widget.showBackButton,
          leading: widget.showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Hero(
              tag: 'videoPlayer-${video['_id']}',
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FlutterFlowVideoPlayer(
                        path: widget.videoUrl ?? _getVideoUrl(video),
                        videoType: VideoType.network,
                        autoPlay: true,
                        looping: true,
                        showControls: false,
                        allowFullScreen: true,
                      ),
                    ),
                  ),
                  // Comment section
                  Align(
                    alignment: const AlignmentDirectional(-0.8, 0.97),
                    child: CommenttextWidget(oldvideo: video['_id']),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(BackendAPIGroup.getallvideosCall.call()))
          .future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data?.statusCode == 404) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
            body: Center(
              child: Image.asset(
                'assets/images/404.avif',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        final videoContentGetallvideosResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              elevation: 0,
              automaticallyImplyLeading: widget.showBackButton,
              leading: widget.showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : null,
              title: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = 0;
                            _tabController.animateTo(0);
                          });
                          _handleTabChange(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 0
                                ? const Color(0xFF04137B)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'SHOPPING',
                              style: TextStyle(
                                color: _selectedTabIndex == 0
                                    ? Colors.white
                                    : Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = 1;
                            _tabController.animateTo(1);
                          });
                          _handleTabChange(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 1
                                ? const Color(0xFF04137B)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'FASHION',
                              style: TextStyle(
                                color: _selectedTabIndex == 1
                                    ? Colors.white
                                    : Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              top: true,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Tab content
                    Expanded(
                      child: IndexedStack(
                        index: _selectedTabIndex,
                        children: [
                          // SHOPPING Tab - Tabular Form
                          _buildShoppingTab(videoContentGetallvideosResponse),
                          // FASHION Tab - Video Feed
                          _buildFashionTab(videoContentGetallvideosResponse),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // SHOPPING Tab - Tabular Form (like first image)
  Widget _buildShoppingTab(ApiCallResponse videoContentGetallvideosResponse) {
    return FutureBuilder<ApiCallResponse>(
      future: BackendAPIGroup.getVideosWithProductsCall.call(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _buildShoppingSkeletonLoading();
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading videos with products'),
          );
        }

        final videosWithProductsResponse = snapshot.data!;
        final videos = BackendAPIGroup.getVideosWithProductsCall
                .videos(videosWithProductsResponse.jsonBody)
                ?.toList() ??
            [];

        if (videos.isEmpty) {
          return const Center(
            child: Text('No product videos available'),
          );
        }

        // Initialize user reactions from API response
        _initializeUserReactions(videos);

        return _buildShoppingTabLayout(videos);
      },
    );
  }

  // Shopping tab layout - Reels-like interface
  Widget _buildShoppingTabLayout(List<dynamic> videos) {
    // Store videos for navigation
    _shoppingVideos = videos;

    // Initialize video controllers for shopping videos
    for (final video in videos) {
      final videoId = video['_id']?.toString() ?? '';
      final videoUrl = _getVideoUrl(video);
      print(
          '🔍 [SHOPPING] Initializing video: $videoId, URL: ${videoUrl.isNotEmpty ? "exists" : "empty"}');
      if (videoUrl.isNotEmpty && videoId.isNotEmpty) {
        _initializeVideoController(videoId, videoUrl, tabType: 'shopping');
      }
    }

    // Debug: Print the videos data to see what we're getting
    print('🔍 [SHOPPING] === VIDEO DATA LOADING DEBUG ===');
    print('🔍 [SHOPPING] Videos length: ${videos.length}');
    print('🔍 [SHOPPING] Current video index: $_currentShoppingVideoIndex');

    // Ensure current index is within bounds
    if (_currentShoppingVideoIndex >= videos.length) {
      _currentShoppingVideoIndex = 0;
    }

    return Container(
      color: Colors.black,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        controller: _shoppingPageController,
        onPageChanged: (index) {
          setState(() {
            _currentShoppingVideoIndex = index;
          });
          print('🔍 [SHOPPING] Switched to video at index $index');
          // Note: Not automatically pausing other videos to allow independent control
        },
        itemBuilder: (context, index) {
          final video = videos[index];
          final products = video['products'] as List? ?? [];

          return _buildShoppingReelItem(video, products, index);
        },
      ),
    );
  }

  // Individual shopping reel item
  Widget _buildShoppingReelItem(
      dynamic video, List<dynamic> products, int index) {
    final videoUrl = _getVideoUrl(video);
    final videoId = video['_id']?.toString() ?? '';
    final videoTitle = video['title']?.toString() ?? 'Video Title';
    final userDisplayName =
        video['userId']?['displayName']?.toString() ?? 'User';
    final userProfileImage = video['userId']?['profileImage']?.toString() ?? '';

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Video background - Full screen
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: videoUrl.isNotEmpty
                ? _buildCustomVideoPlayer(videoId, videoUrl)
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[800]!,
                          Colors.grey[900]!,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Video not available',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),

          // Play/Pause button overlay
          if (videoUrl.isNotEmpty)
            Center(
              child: GestureDetector(
                onTap: () {
                  _toggleVideoPlayback(videoId);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Icon(
                    _isVideoPlaying(videoId) ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),

          // Products section with heading
          if (products.isNotEmpty)
            Positioned(
              top: MediaQuery.of(context).size.width < 400 ? 120 : 100,
              right: MediaQuery.of(context).size.width < 400 ? 10 : 20,
              child: Column(
                children: [
                  // Heading
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: const Text(
                      'Products in this video',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Products container
                  Container(
                    width: MediaQuery.of(context).size.width < 400 ? 70 : 80,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length > 3 ? 3 : products.length,
                      itemBuilder: (context, productIndex) {
                        final product = products[productIndex];
                        final productId =
                            product['productId']?['_id']?.toString() ?? '';
                        final productName =
                            product['productId']?['productName']?.toString() ??
                                'Product';
                        final productImage =
                            product['productId']?['coverImage']?.toString() ??
                                '';
                        final productPrice =
                            product['productId']?['price']?.toString() ?? '0';

                        return GestureDetector(
                          onTap: () {
                            // Navigate to product description
                            if (productId.isNotEmpty) {
                              print(
                                  '🎯 [VIDEO] Navigating to product: $productId with price: $productPrice');
                              context.pushNamed(
                                'productDescriptionColor',
                                queryParameters: {
                                  'productId': productId,
                                  'price': productPrice,
                                }.withoutNulls,
                              );
                            } else {
                              print(
                                  '⚠️ [VIDEO] Product ID is empty, cannot navigate');
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: MediaQuery.of(context).size.width < 400
                                ? 70
                                : 80,
                            height: MediaQuery.of(context).size.width < 400
                                ? 70
                                : 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: productImage.isNotEmpty
                                  ? Image.network(
                                      productImage,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.shopping_bag,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.shopping_bag,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // "View All Products" button
                  if (products.length > 3)
                    GestureDetector(
                      onTap: () {
                        // Show all products in a bottom sheet
                        _showCommentBottomSheet(videoId);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF04137B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

          // Right side action buttons
          Positioned(
            bottom: MediaQuery.of(context).size.width < 400 ? 30 : 20,
            right: MediaQuery.of(context).size.width < 400 ? 10 : 20,
            child: Column(
              children: [
                // Like button
                GestureDetector(
                  onTap: () => _handleVideoReaction(videoId),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width < 400 ? 45 : 50,
                          height:
                              MediaQuery.of(context).size.width < 400 ? 45 : 50,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            _userReactions[videoId] == 'like'
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _userReactions[videoId] == 'like'
                                ? Colors.red
                                : Colors.white,
                            size: MediaQuery.of(context).size.width < 400
                                ? 20
                                : 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${video['no_of_likes'] ?? 0}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width < 400
                                ? 10
                                : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Comment button
                GestureDetector(
                  onTap: () => _showCommentBottomSheet(videoId),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width < 400 ? 45 : 50,
                          height:
                              MediaQuery.of(context).size.width < 400 ? 45 : 50,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width < 400
                                ? 20
                                : 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${video['comments']?.length ?? 0}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width < 400
                                ? 10
                                : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Dislike button
                GestureDetector(
                  onTap: () => _handleVideoReaction(videoId),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width < 400 ? 45 : 50,
                          height:
                              MediaQuery.of(context).size.width < 400 ? 45 : 50,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            _userReactions[videoId] == 'dislike'
                                ? Icons.thumb_down
                                : Icons.thumb_down_outlined,
                            color: _userReactions[videoId] == 'dislike'
                                ? const Color(0xFF04137B)
                                : Colors.white,
                            size: MediaQuery.of(context).size.width < 400
                                ? 20
                                : 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${video['no_of_dislikes'] ?? 0}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width < 400
                                ? 10
                                : 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom info section
          Positioned(
            bottom: MediaQuery.of(context).size.width < 400 ? 30 : 20,
            left: MediaQuery.of(context).size.width < 400 ? 15 : 20,
            right: MediaQuery.of(context).size.width < 400 ? 90 : 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.3), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width:
                            MediaQuery.of(context).size.width < 400 ? 35 : 40,
                        height:
                            MediaQuery.of(context).size.width < 400 ? 35 : 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width < 400
                                  ? 17.5
                                  : 20),
                          child: userProfileImage.isNotEmpty
                              ? Image.network(
                                  userProfileImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size:
                                            MediaQuery.of(context).size.width <
                                                    400
                                                ? 18
                                                : 20,
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size:
                                        MediaQuery.of(context).size.width < 400
                                            ? 18
                                            : 20,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userDisplayName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 400
                                        ? 14
                                        : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (products.isNotEmpty)
                              Text(
                                '${products.length} Product${products.length > 1 ? 's' : ''}',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 10
                                          : 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Video title and description (same as swipe up text)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.3), width: 1),
                  ),
                  child: Text(
                    videoTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          MediaQuery.of(context).size.width < 400 ? 12 : 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 8),

                // Visit Store button
                if (products.isNotEmpty)
                  GestureDetector(
                    onTap: () => _handleVisitStore(video),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF04137B),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.store,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width < 400
                                ? 14
                                : 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Visit Store',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width < 400
                                  ? 11
                                  : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Swipe indicator
          Positioned(
            top: MediaQuery.of(context).size.width < 400 ? 50 : 40,
            left: 0,
            right: MediaQuery.of(context).size.width < 400 ? 90 : 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Swipe up for more',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Main video area - Original design
  Widget _buildMainVideoArea(dynamic video) {
    final videoUrl = _getVideoUrl(video);
    final videoId = video['_id']?.toString() ?? '';
    final products = video['products'] as List? ?? [];
    final videoTitle = video['title']?.toString() ?? 'Video Title';
    final userDisplayName =
        video['userId']?['displayName']?.toString() ?? 'User';

    print('🔍 [SHOPPING] Video details:');
    print('  - Title: $videoTitle');
    print('  - User: $userDisplayName');
    print('  - Products count: ${products.length}');

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Video background
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: videoUrl.isNotEmpty
                  ? _buildCustomVideoPlayer(videoId, videoUrl)
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey[300]!,
                            Colors.grey[400]!,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.video_library,
                              color: Colors.white,
                              size: 60,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Video not available',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),

          // Play/Pause button overlay
          if (videoUrl.isNotEmpty)
            Center(
              child: GestureDetector(
                onTap: () {
                  _toggleVideoPlayback(videoId);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Icon(
                    _isVideoPlaying(videoId) ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),

          // Product tag indicator (top-left)
          if (products.isNotEmpty)
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF04137B), Color(0xFF1E3A8A)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${products.length} Product${products.length > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Video title and user info (bottom-left)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFF04137B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'by $userDisplayName',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Action buttons and store buttons section
  Widget _buildActionAndStoreButtons(String? currentVideoId) {
    // Get current video data to extract designer ID
    final currentVideo = _shoppingVideos.isNotEmpty &&
            _currentShoppingVideoIndex < _shoppingVideos.length
        ? _shoppingVideos[_currentShoppingVideoIndex]
        : null;

    // Enhanced designer ID extraction based on product's designerRef._id
    String designerId = '';

    if (currentVideo != null) {
      print('🔍 [SHOPPING] === DESIGNER ID EXTRACTION DEBUG ===');
      print('🔍 [SHOPPING] Current video: $currentVideo');
      print('🔍 [SHOPPING] Video keys: ${currentVideo.keys.toList()}');

      // Get products from current video
      final products = currentVideo['products'] as List? ?? [];
      print('🔍 [SHOPPING] Products count: ${products.length}');

      // Extract designer ID from the first product's designerRef._id
      if (products.isNotEmpty) {
        final firstProduct = products[0];
        print('🔍 [SHOPPING] First product: $firstProduct');

        if (firstProduct['productId'] != null) {
          final productId = firstProduct['productId'] as Map<String, dynamic>;
          print('🔍 [SHOPPING] ProductId keys: ${productId.keys.toList()}');

          if (productId['designerRef'] != null) {
            final designerRef =
                productId['designerRef'] as Map<String, dynamic>;
            print(
                '🔍 [SHOPPING] DesignerRef keys: ${designerRef.keys.toList()}');

            if (designerRef['_id'] != null) {
              designerId = designerRef['_id'].toString();
              print(
                  '🔍 [SHOPPING] ✅ Found designerId from product.designerRef._id: $designerId');
            } else {
              print('🔍 [SHOPPING] ❌ designerRef._id is null');
            }
          } else {
            print('🔍 [SHOPPING] ❌ designerRef is null');
          }
        } else {
          print('🔍 [SHOPPING] ❌ productId is null');
        }
      } else {
        print('🔍 [SHOPPING] ❌ No products available');
      }

      // Fallback to video's userId._id if no product designerRef found
      if (designerId.isEmpty && currentVideo['userId'] != null) {
        print('🔍 [SHOPPING] Falling back to userId._id');
        if (currentVideo['userId'] is Map) {
          final userIdMap = currentVideo['userId'] as Map;
          if (userIdMap['_id'] != null) {
            designerId = userIdMap['_id'].toString();
            print(
                '🔍 [SHOPPING] ✅ Found designerId from fallback userId._id: $designerId');
          }
        } else if (currentVideo['userId'] is String) {
          designerId = currentVideo['userId'].toString();
          print(
              '🔍 [SHOPPING] ✅ Found designerId from fallback userId (string): $designerId');
        }
      }

      // Additional fallback checks
      if (designerId.isEmpty && currentVideo['designerId'] != null) {
        designerId = currentVideo['designerId'].toString();
        print(
            '🔍 [SHOPPING] ✅ Found designerId from designerId field: $designerId');
      }

      if (designerId.isEmpty && currentVideo['creatorId'] != null) {
        designerId = currentVideo['creatorId'].toString();
        print(
            '🔍 [SHOPPING] ✅ Found designerId from creatorId field: $designerId');
      }

      print('🔍 [SHOPPING] Final designerId: "$designerId"');
      print('🔍 [SHOPPING] Designer ID length: ${designerId.length}');
      print('🔍 [SHOPPING] === END DESIGNER ID EXTRACTION DEBUG ===');
    } else {
      print(
          '🔍 [SHOPPING] ❌ No current video available for designer ID extraction');
    }

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Action buttons
          Row(
            children: [
              // Combined Like/Dislike toggle button
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    if (currentVideoId != null) {
                      _handleVideoReaction(currentVideoId);
                    }
                  },
                  icon: Icon(
                    _getUserReaction(currentVideoId ?? '') == 'like'
                        ? Icons.favorite
                        : _getUserReaction(currentVideoId ?? '') == 'dislike'
                            ? Icons.thumb_down
                            : Icons.favorite_border,
                    color: _getUserReaction(currentVideoId ?? '') == 'like'
                        ? Colors.red
                        : _getUserReaction(currentVideoId ?? '') == 'dislike'
                            ? Colors.blue
                            : Colors.grey[600],
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Comment button
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    if (currentVideoId != null) {
                      _showCommentBottomSheet(currentVideoId);
                    }
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Color(0xFF04137B),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Right side - View Product button
          GestureDetector(
            onTap: () {
              // Add haptic feedback
              HapticFeedback.lightImpact();

              print('🔍 [SHOPPING] === VIEW PRODUCT BUTTON TAPPED ===');

              // Get the first product from the current video
              final products = currentVideo?['products'] as List? ?? [];
              if (products.isNotEmpty) {
                final firstProduct = products[0];
                final productId =
                    firstProduct['productId'] as Map<String, dynamic>?;

                if (productId != null) {
                  final productIdString = productId['_id']?.toString() ?? '';
                  final productPrice = productId['price']?.toString() ?? '0';
                  final productName =
                      productId['productName']?.toString() ?? 'Product';

                  print(
                      '🔍 [SHOPPING] ✅ Found product: $productName (ID: $productIdString)');

                  if (productIdString.isNotEmpty) {
                    // Show loading indicator
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text('Opening $productName...'),
                          ],
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDescriptionColorWidget(
                          productId: productIdString,
                          price: productPrice,
                        ),
                      ),
                    );
                    print(
                        '🔍 [SHOPPING] ✅ Navigation to product description completed');
                  } else {
                    print('🔍 [SHOPPING] ❌ Product ID is empty');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product details not available'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                } else {
                  print('🔍 [SHOPPING] ❌ No product data available');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product information not available'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              } else {
                print('🔍 [SHOPPING] ❌ No products available in video');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No products available in this video'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
              print('🔍 [SHOPPING] === END VIEW PRODUCT BUTTON ===');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF04137B), Color(0xFF1E3A8A)],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF04137B).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'View Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Product grid / Tabular form
  Widget _buildProductGrid(List<dynamic> products) {
    // Debug: Print the products data to see what we're getting
    print('🔍 [SHOPPING] Products data: $products');
    print('🔍 [SHOPPING] Products length: ${products.length}');

    if (products.isEmpty) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 40,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No products available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Products will appear here when tagged to videos',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      // padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF04137B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  color: Color(0xFF04137B),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Products in this video',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200, // Fixed height for product list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                print('🔍 [SHOPPING] Product $index: $product');
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Skeleton loading for shopping tab
  Widget _buildShoppingSkeletonLoading() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey[50]!,
            Colors.grey[100]!,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Main content - Scrollable
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Main video area skeleton (top section)
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.grey[300],
                      child: Stack(
                        children: [
                          // Video skeleton
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey[400],
                          ),
                          // Play button skeleton
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[500]!,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.grey[600]!, width: 3),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.grey[700],
                                size: 40,
                              ),
                            ),
                          ),
                          // Product tag skeleton
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey[500]!,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Colors.grey[700],
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '3 Products',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Video info skeleton
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.grey[800]!.withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        height: 16,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Action buttons skeleton (middle section)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Like button skeleton
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Comment button skeleton
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      // Store button skeleton
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.store,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Visit Store',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Product grid skeleton (bottom section)
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header skeleton
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                height: 24,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Product cards skeleton
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 140,
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product image skeleton
                                      Container(
                                        width: 140,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          ),
                                        ),
                                      ),
                                      // Product details skeleton
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Product name skeleton
                                              Container(
                                                height: 12,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                height: 12,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              // Price skeleton
                                              Container(
                                                height: 16,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              // Button skeleton
                                              Container(
                                                width: double.infinity,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Extra space at bottom for FAB
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Next button skeleton (FAB)
          Positioned(
            bottom: 30,
            right: 30,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[500],
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Individual product card for horizontal grid
  Widget _buildProductCard(dynamic product) {
    // Debug: Print individual product data
    print('🔍 [SHOPPING] Building product card for: $product');

    // Extract product details from the nested productId structure
    final productId = product['productId'] as Map<String, dynamic>?;
    if (productId == null) {
      print('🔍 [SHOPPING] No productId found in product: $product');
      return Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        child: const Center(
          child: Text('Invalid product data'),
        ),
      );
    }

    final productName = productId['productName']?.toString() ?? 'Product Name';
    final productPrice = productId['price']?.toString() ?? '0';
    final productImage = productId['coverImage']?.toString() ?? '';
    final productSku = productId['sku']?.toString() ?? '';
    final productIdString = productId['_id']?.toString() ?? '';

    print('🔍 [SHOPPING] Extracted product details:');
    print('  - Name: $productName');
    print('  - Price: $productPrice');
    print('  - Image: $productImage');
    print('  - SKU: $productSku');
    print('  - Product ID: $productIdString');

    return GestureDetector(
      onTap: () {
        print('🔍 [SHOPPING] Product tapped: $productName');
        if (productIdString.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDescriptionColorWidget(
                productId: productIdString,
                price: productPrice,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product details not available'),
            ),
          );
        }
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              width: 140,
              height: 120,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(
                    productImage.isNotEmpty
                        ? productImage
                        : 'https://images.unsplash.com/photo-1591422510968-0a13744207f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxNnx8YmFubmVycyUyMHNob29waW5nfGVufDB8fHx8MTc1NTExMTc5MHww&ixlib=rb-4.1.0&q=80&w=1080',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Product details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Expanded(
                      child: Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Product price
                    Text(
                      '₹$productPrice',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF04137B),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Add to Cart button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF04137B), Color(0xFF1E3A8A)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FASHION Tab - Video Feed (like second image)
  Widget _buildFashionTab(ApiCallResponse videoContentGetallvideosResponse) {
    return FutureBuilder<ApiCallResponse>(
      future: BackendAPIGroup.getallvideosCall.call(
        filter: 'without-products',
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading fashion videos'),
          );
        }

        final fashionVideosResponse = snapshot.data!;
        final videoPasth = BackendAPIGroup.getallvideosCall
                .body(fashionVideosResponse.jsonBody)
                ?.toList() ??
            [];

        // Initialize user reactions from API response
        _initializeUserReactions(videoPasth);

        if (videoPasth.isEmpty) {
          return const Center(
            child: Text('No fashion videos available'),
          );
        }

        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: PageView.builder(
            controller: _model.pageViewController ??= PageController(
                initialPage: max(0, min(0, videoPasth.length - 1))),
            onPageChanged: (index) {
              safeSetState(() {});
              _handlePageChange(index, videoPasth);
            },
            scrollDirection: Axis.vertical,
            itemCount: videoPasth.length,
            itemBuilder: (context, videoPasthIndex) {
              final videoPasthItem = videoPasth[videoPasthIndex];
              return _buildVideoFeedItem(
                  videoPasthItem, videoPasthIndex, videoPasth.length);
            },
          ),
        );
      },
    );
  }

  // Empty video area for when no videos are available
  Widget _buildEmptyVideoArea() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No videos available',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for FASHION tab - Video Style (Social Media UI)
  Widget _buildVideoFeedItem(
      dynamic videoPasthItem, int videoPasthIndex, int totalVideos) {
    final videoId = getJsonField(videoPasthItem, r'''$._id''').toString();
    final videoUrl = widget.videoUrl ?? _getVideoUrl(videoPasthItem);
    final videoTitle =
        getJsonField(videoPasthItem, r'''$.title''')?.toString() ?? '';
    final userDisplayName =
        videoPasthItem['userId']?['displayName']?.toString() ?? 'User';

    // Initialize video controller when building the item
    if (videoUrl.isNotEmpty) {
      _initializeVideoController(videoId, videoUrl, tabType: 'fashion');
    }

    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // Video player
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildCustomVideoPlayer(videoId, videoUrl),
              ),
            ),
          ),

          // Play/Pause overlay
          Center(
            child: GestureDetector(
              onTap: () {
                _toggleVideoPlayback(videoId);
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Icon(
                  _isVideoPlaying(videoId) ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),

          // Engagement Icons (Right Side)
          Positioned(
            bottom: 120,
            right: 20,
            child: Column(
              children: [
                // Combined Like/Dislike button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _handleVideoReaction(videoId);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getUserReaction(videoId) == 'like'
                          ? Icons.favorite
                          : _getUserReaction(videoId) == 'dislike'
                              ? Icons.thumb_down
                              : Icons.favorite_border,
                      color: _getUserReaction(videoId) == 'like'
                          ? Colors.red
                          : _getUserReaction(videoId) == 'dislike'
                              ? Colors.blue
                              : Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Comment button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _showCommentBottomSheet(videoId);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Video Information (Bottom Left) - Properly aligned
          Positioned(
            bottom: 20,
            left: 20,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video description
                Text(
                  videoTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Music info
                Row(
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Original Sound - $userDisplayName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Profile picture and username - Properly aligned at bottom
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@$userDisplayName',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Follow',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get video URL
  String _getVideoUrl(dynamic video) {
    if (video['videoUrl'] != null) {
      if (video['videoUrl'] is List) {
        final videoUrls = video['videoUrl'] as List;
        if (videoUrls.isNotEmpty) {
          return videoUrls.first.toString();
        }
      } else {
        return video['videoUrl'].toString();
      }
    }
    return '';
  }

  // Helper method to get designer name from products
  String? _getDesignerNameFromProducts(dynamic video) {
    if (video == null) return null;

    final products = video['products'] as List? ?? [];
    if (products.isNotEmpty) {
      final firstProduct = products[0];
      if (firstProduct['productId'] != null) {
        final productId = firstProduct['productId'] as Map<String, dynamic>;
        // Try to get designer name from product data
        if (productId['designerName'] != null) {
          return productId['designerName'].toString();
        }
        if (productId['designer'] != null) {
          final designer = productId['designer'] as Map<String, dynamic>?;
          if (designer?['displayName'] != null) {
            return designer!['displayName'].toString();
          }
        }
      }
    }

    // Fallback to video's userId displayName
    if (video['userId'] != null && video['userId'] is Map) {
      final userId = video['userId'] as Map;
      if (userId['displayName'] != null) {
        return userId['displayName'].toString();
      }
    }

    return null;
  }

  // Build custom video player with controlled playback
  Widget _buildCustomVideoPlayer(String videoId, String videoUrl) {
    final controller = _videoControllers[videoId];
    final isInitialized = _videoInitialized[videoId] ?? false;

    if (controller == null || !isInitialized) {
      // Show loading placeholder while video is initializing
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }
}

// Comment Bottom Sheet Widget
class _CommentBottomSheet extends StatefulWidget {
  final String videoId;
  final ScrollController scrollController;

  const _CommentBottomSheet({
    required this.videoId,
    required this.scrollController,
  });

  @override
  State<_CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<_CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  List<dynamic> _comments = [];
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    try {
      setState(() => _isLoading = true);

      // Make direct HTTP request to get comments
      final url = Uri.parse(
          'https://indigo-rhapsody-backend-ten.vercel.app/content-video/videos/${widget.videoId}/comments');
      final response = await http.get(url);

      print('🔍 [COMMENTS] GET Response status: ${response.statusCode}');
      print('🔍 [COMMENTS] GET Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final comments = responseData['comments'] as List? ?? [];

        setState(() {
          _comments = comments;
          _isLoading = false;
        });
        print('🔍 [COMMENTS] Loaded ${_comments.length} comments');
      } else {
        print('🔍 [COMMENTS] HTTP Error: ${response.statusCode}');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('🔍 [COMMENTS] Error loading comments: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addComment() async {
    if (_commentController.text.trim().isEmpty) return;

    try {
      setState(() => _isSubmitting = true);

      // Get current user ID from app state
      final userId = FFAppState().userId;
      if (userId.isEmpty) {
        print('🔍 [COMMENTS] Error: No user ID available');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to add comments'),
          ),
        );
        return;
      }

      print('🔍 [COMMENTS] Adding comment for video: ${widget.videoId}');
      print('🔍 [COMMENTS] Using user ID: $userId');
      print('🔍 [COMMENTS] Comment text: ${_commentController.text.trim()}');

      // Make direct HTTP request to add comment
      final url = Uri.parse(
          'https://indigo-rhapsody-backend-ten.vercel.app/content-video/videos/${widget.videoId}/comments');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'commentText': _commentController.text.trim(),
        }),
      );

      print('🔍 [COMMENTS] POST Response status: ${response.statusCode}');
      print('🔍 [COMMENTS] POST Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        _commentController.clear();
        await _loadComments(); // Reload comments
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment added successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        print('🔍 [COMMENTS] HTTP Error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add comment. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('🔍 [COMMENTS] Error adding comment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please check your connection.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _deleteComment(String commentId) async {
    try {
      print(
          '🔍 [COMMENTS] Deleting comment: $commentId for video: ${widget.videoId}');

      // Make direct HTTP request to delete comment
      final url = Uri.parse(
          'https://indigo-rhapsody-backend-ten.vercel.app/content-video/videos/${widget.videoId}/comments/$commentId');
      final response = await http.delete(url);

      print('🔍 [COMMENTS] DELETE Response status: ${response.statusCode}');
      print('🔍 [COMMENTS] DELETE Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        await _loadComments(); // Reload comments
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment deleted successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        print('🔍 [COMMENTS] HTTP Error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete comment. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('🔍 [COMMENTS] Error deleting comment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please check your connection.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header with comment count and view all
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Comments (${_comments.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement view all comments functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View all comments')),
                    );
                  },
                  child: const Text(
                    'view all',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.purple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Comments list - Scrollable
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _comments.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No comments yet',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Be the first to comment!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _comments.length,
                        itemBuilder: (context, index) {
                          final comment = _comments[index];
                          final commentText =
                              comment['commentText']?.toString() ?? '';
                          final userDisplayName =
                              comment['userId']?['displayName']?.toString() ??
                                  'User';
                          final createdAt =
                              comment['createdAt']?.toString() ?? '';
                          final commentId = comment['_id']?.toString() ?? '';
                          final isOwnComment =
                              comment['userId']?['_id']?.toString() ==
                                  FFAppState().userId;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User name and delete button row
                                Row(
                                  children: [
                                    Text(
                                      userDisplayName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    // Delete button for own comments
                                    if (isOwnComment)
                                      GestureDetector(
                                        onTap: () => _deleteComment(commentId),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Comment text
                                Text(
                                  commentText,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Timestamp
                                Text(
                                  _formatDate(createdAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),

          // Comment input section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                // Emoji button
                GestureDetector(
                  onTap: () {
                    // TODO: Implement emoji picker
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Emoji picker coming soon')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      '😊',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Text input
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Send button
                _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : GestureDetector(
                        onTap: _addComment,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF04137B),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown time';
    }
  }
}
