import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indigo_rhapsody_dupli/components/cart_nav_button.dart';

import '';
import '/backend/api_requests/api_calls.dart';
import '/designer/pages/shimmerbanner/shimmerbanner_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/index.dart';
import '/shimmer/categories_shimmer/categories_shimmer_widget.dart';
import '/shimmer/hiddengems_shimmer/hiddengems_shimmer_widget.dart';
import '/shimmer/products_shimmer/products_shimmer_widget.dart';
import 'homepage_model.dart';

export 'homepage_model.dart';

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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TintEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Colors.black,
            begin: 0,
            end: 1,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TintEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Colors.black,
            begin: 0,
            end: 1,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        onPopInvokedWithResult: (canPop, res) async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            toolbarHeight: 64,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'assets/images/Asset_4.webp',
                    width: screenSize.width * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/images/Asset_3.webp',
                      width: screenSize.width * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(top: 10, right: 16),
                child: CartNavButton(),
              ),
            ],
            elevation: 0,
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding:
                          const EdgeInsets.only(left: 20, top: 16, bottom: 16),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Searchpage1Widget()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search here....',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: const Color(0xFF232323),
                                    fontSize: 12,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Inter'),
                                  ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15, right: 12),
                              child: Icon(
                                FFIcons.ksearch,
                                color: Color(0xFF263F96),
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 12),
                      child: FutureBuilder<ApiCallResponse>(
                        future: FFAppState().subcategory(
                          requestFn: () =>
                              BackendAPIGroup.subcategoriesCall.call(),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }

                          final gridViewSubcategoriesResponse = snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final newbody = (BackendAPIGroup.subcategoriesCall
                                          .body(
                                            gridViewSubcategoriesResponse
                                                .jsonBody,
                                          )
                                          ?.toList() ??
                                      [])
                                  .take(8)
                                  .toList();

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.1,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: newbody.length,
                                itemBuilder: (context, newbodyIndex) {
                                  final newbodyItem = newbody[newbodyIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        ProductofdesignerclientCopyCopyWidget
                                            .routeName,
                                        queryParameters: {
                                          'subcategoryid': serializeParam(
                                            getJsonField(
                                              newbodyItem,
                                              r'''$._id''',
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            getJsonField(
                                              newbodyItem,
                                              r'''$.image''',
                                            ).toString(),
                                            width: screenSize.width * 0.14,
                                            height: screenSize.height * 0.07,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          getJsonField(
                                            newbodyItem,
                                            r'''$.name''',
                                          ).toString(),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey('Inter'),
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    FutureBuilder<ApiCallResponse>(
                      future: FFAppState().carousel(
                        requestFn: () => BackendAPIGroup.getBannersCall.call(),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return SizedBox(
                            width: screenSize.width,
                            height: screenSize.height * 0.1,
                            child: const ShimmerbannerWidget(),
                          );
                        }
                        final carouselGetBannersResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final bannersMain = BackendAPIGroup.getBannersCall
                                    .bannersMain(
                                      carouselGetBannersResponse.jsonBody,
                                    )
                                    ?.toList() ??
                                [];

                            return SizedBox(
                              width: screenSize.width,
                              height: screenSize.height * 0.2,
                              child: CarouselSlider.builder(
                                itemCount: bannersMain.length,
                                itemBuilder: (context, bannersMainIndex, _) {
                                  final bannersMainItem =
                                      bannersMain[bannersMainIndex];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      getJsonField(
                                        bannersMainItem,
                                        r'''$.image''',
                                      ).toString(),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  );
                                },
                                carouselController:
                                    _model.carouselController ??=
                                        CarouselSliderController(),
                                options: CarouselOptions(
                                  initialPage:
                                      max(0, min(1, bannersMain.length - 1)),
                                  viewportFraction: 1,
                                  disableCenter: true,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 1,
                                  enableInfiniteScroll: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: false,
                                  onPageChanged: (index, _) =>
                                      _model.carouselCurrentIndex = index,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    _sectionTitle('Shop By Category'),
                    FutureBuilder<ApiCallResponse>(
                      future: FFAppState().categories(
                        requestFn: () =>
                            BackendAPIGroup.getCategoriesCall.call(),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return const CategoriesShimmerWidget();
                        }
                        final rowGetCategoriesResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final category = BackendAPIGroup.getCategoriesCall
                                    .categoryPath(
                                      rowGetCategoriesResponse.jsonBody,
                                    )
                                    ?.toList() ??
                                [];

                            return Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(category.length,
                                      (categoryIndex) {
                                    final categoryItem =
                                        category[categoryIndex];
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 5, 0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          context.pushNamed(
                                            DesignerCategoryClientyCopyWidget
                                                .routeName,
                                            queryParameters: {
                                              'categoryref': serializeParam(
                                                getJsonField(
                                                  categoryItem,
                                                  r'''$._id''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Container(
                                          width: screenSize.width * 0.22,
                                          height: screenSize.height * 0.043,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF323FA4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            valueOrDefault<String>(
                                              getJsonField(
                                                categoryItem,
                                                r'''$.name''',
                                              )?.toString(),
                                              'values',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 10,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      GoogleFonts.asMap()
                                                          .containsKey(
                                                              'Open Sans'),
                                                ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    _sectionTitle('Designers For You'),
                    FutureBuilder<ApiCallResponse>(
                      future: FFAppState().designer(
                        requestFn: () =>
                            BackendAPIGroup.getDesignersCall.call(),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return const HiddengemsShimmerWidget();
                        }
                        final rowGetDesignersResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final designer = (BackendAPIGroup.getDesignersCall
                                        .designerBody(
                                          rowGetDesignersResponse.jsonBody,
                                        )
                                        ?.toList() ??
                                    [])
                                .take(8)
                                .toList();

                            return Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(designer.length,
                                      (designerIndex) {
                                    final designerItem =
                                        designer[designerIndex];
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 10, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            HiddenGemsWidget.routeName,
                                            queryParameters: {
                                              'designerId': serializeParam(
                                                getJsonField(
                                                  designerItem,
                                                  r'''$._id''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                getJsonField(
                                                  designerItem,
                                                  r'''$.logoUrl''',
                                                ).toString(),
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.2,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.1,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _sectionTitle('Style inspiration For You!!')
                        .animateOnPageLoad(
                            animationsMap['textOnPageLoadAnimation1']!),
                    FutureBuilder<ApiCallResponse>(
                      future: FFAppState().videosection(
                        requestFn: () =>
                            BackendAPIGroup.getallvideosCall.call(),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final rowGetallvideosResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final bodyforvideos =
                                (BackendAPIGroup.getallvideosCall
                                            .body(
                                              rowGetallvideosResponse.jsonBody,
                                            )
                                            ?.toList() ??
                                        [])
                                    .take(4)
                                    .toList();

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(bodyforvideos.length,
                                    (bodyforvideosIndex) {
                                  final bodyforvideosItem =
                                      bodyforvideos[bodyforvideosIndex];
                                  final videoUrl = getJsonField(
                                    bodyforvideosItem,
                                    r'''$.videoUrl''',
                                  ).toString();
                                  debugPrint(
                                      'videourl $bodyforvideosIndex: $videoUrl');
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      alignment:
                                          const AlignmentDirectional(-1, 1),
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoContentWidget(
                                                  videoUrl: videoUrl,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: FlutterFlowVideoPlayer(
                                              path: videoUrl,
                                              videoType: VideoType.network,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.25,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.18,
                                              autoPlay: false,
                                              looping: true,
                                              showControls: false,
                                              allowFullScreen: false,
                                              allowPlaybackSpeedMenu: false,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 10),
                                            child: Text(
                                              (getJsonField(
                                                        bodyforvideosItem,
                                                        r'''$.userId.displayName''',
                                                      ) ??
                                                      '')
                                                  .toString()
                                                  .maybeHandleOverflow(
                                                    maxChars: 10,
                                                    replacement: '…',
                                                  ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 10,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                                'Inter'),
                                                    lineHeight: 2,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _sectionTitle('Newly added products').animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation2']!),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: FutureBuilder<ApiCallResponse>(
                        future: FFAppState().products(
                          requestFn: () =>
                              BackendAPIGroup.getLatestProductsCall.call(),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return const ProductsShimmerWidget();
                          }
                          final gridViewGetLatestProductsResponse =
                              snapshot.data!;

                          return Builder(
                            builder: (context) {
                              final latestProducts =
                                  BackendAPIGroup.getLatestProductsCall
                                          .body(
                                            gridViewGetLatestProductsResponse
                                                .jsonBody,
                                          )
                                          ?.toList() ??
                                      [];

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.68,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: latestProducts.length,
                                itemBuilder: (context, latestProductsIndex) {
                                  final latestProductsItem =
                                      latestProducts[latestProductsIndex];
                                  return Material(
                                    color: Colors.transparent,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            ProductDescriptionColorWidget
                                                .routeName,
                                            queryParameters: {
                                              'productId': serializeParam(
                                                getJsonField(
                                                  latestProductsItem,
                                                  r'''$._id''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                              'price': serializeParam(
                                                getJsonField(
                                                  latestProductsItem,
                                                  r'''$.price''',
                                                ).toString(),
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                maxHeight:
                                                    screenSize.height * 0.23,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                  getJsonField(
                                                    latestProductsItem,
                                                    r'''$.coverImage''',
                                                  ).toString(),
                                                  width: double.maxFinite,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6, top: 10),
                                              child: Text(
                                                getJsonField(
                                                  latestProductsItem,
                                                  r'''$.productName''',
                                                ).toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: const Color(
                                                          0xFF232323),
                                                      fontSize: 11,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                  'Inter'),
                                                    ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, bottom: 12),
                                              child: Text(
                                                '₹${getJsonField(
                                                  latestProductsItem,
                                                  r'''$.price''',
                                                ).toString()}',
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: const Color(
                                                          0xFF263F96),
                                                      fontSize: 14,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
                                                              .containsKey(
                                                                  'Inter'),
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
                          );
                        },
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Text(
        title,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Montserrat',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 13,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              useGoogleFonts: GoogleFonts.asMap().containsKey('Montserrat'),
            ),
      ),
    );
  }
}
