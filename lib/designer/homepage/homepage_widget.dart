import '/backend/api_requests/api_calls.dart';
import '/designer/pages/shimmerbanner/shimmerbanner_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/shimmer/categories_shimmer/categories_shimmer_widget.dart';
import '/shimmer/hiddengems_shimmer/hiddengems_shimmer_widget.dart';
import '/shimmer/products_shimmer/products_shimmer_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

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
            begin: 0.0,
            end: 1.0,
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
            begin: 0.0,
            end: 1.0,
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.sizeOf(context).height * 0.1),
            child: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                            20.0, 0.0, 20.0, 8.0),
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
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.asset(
                                      'assets/images/Asset_3.webp',
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  buttonSize: 40.0,
                                  fillColor: const Color(0xFFE0E6ED),
                                  icon: const Icon(
                                    FFIcons.kshoppingBag,
                                    color: Color(0xFF263F96),
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed('CartPagenewCopy');
                                  },
                                ),
                              ],
                            ),
                          ],
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 21.0, 10.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Search here....',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: const Color(0xFF232323),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Inter'),
                                            ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 12.0, 0.0),
                                        child: Icon(
                                          FFIcons.ksearch,
                                          color: Color(0xFF263F96),
                                          size: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 10.0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: FFAppState().carousel(
                              requestFn: () =>
                                  BackendAPIGroup.getBannersCall.call(),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
                                  child: const ShimmerbannerWidget(),
                                );
                              }
                              final carouselGetBannersResponse = snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final bannersMain =
                                      BackendAPIGroup.getBannersCall
                                              .bannersMain(
                                                carouselGetBannersResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];

                                  return SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.2,
                                    child: CarouselSlider.builder(
                                      itemCount: bannersMain.length,
                                      itemBuilder:
                                          (context, bannersMainIndex, _) {
                                        final bannersMainItem =
                                            bannersMain[bannersMainIndex];
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                        initialPage: max(
                                            0, min(1, bannersMain.length - 1)),
                                        viewportFraction: 1.0,
                                        disableCenter: true,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 1.0,
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
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Shop By Category',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Inter'),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 15.0, 10.0, 0.0),
                          child: FutureBuilder<ApiCallResponse>(
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
                                  final category =
                                      BackendAPIGroup.getCategoriesCall
                                              .categoryPath(
                                                rowGetCategoriesResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(category.length,
                                          (categoryIndex) {
                                        final categoryItem =
                                            category[categoryIndex];
                                        return Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'DesignerCategoryClientyCopy',
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
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.22,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.043,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF323FA4),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      categoryItem,
                                                      r'''$.name''',
                                                    )?.toString(),
                                                    'values',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        fontSize: 10.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
                                                                .containsKey(
                                                                    'Open Sans'),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 20.0, 10.0, 20.0),
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
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final gridViewSubcategoriesResponse =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final newbody =
                                        (BackendAPIGroup.subcategoriesCall
                                                    .body(
                                                      gridViewSubcategoriesResponse
                                                          .jsonBody,
                                                    )
                                                    ?.toList() ??
                                                [])
                                            .take(8)
                                            .toList();

                                    return GridView.builder(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0.0,
                                        0,
                                        0.0,
                                      ),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 20.0,
                                        childAspectRatio: 1.2,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: newbody.length,
                                      itemBuilder: (context, newbodyIndex) {
                                        final newbodyItem =
                                            newbody[newbodyIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'ProductofdesignerclientCopyCopy',
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
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.15,
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    getJsonField(
                                                      newbodyItem,
                                                      r'''$.image''',
                                                    ).toString(),
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.14,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.08,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      newbodyItem,
                                                      r'''$.name''',
                                                    ).toString(),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Inter'),
                                                        ),
                                                  ),
                                                ),
                                              ],
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
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      '',
                                    ).image,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 20.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Designers For You',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts:
                                                      GoogleFonts.asMap()
                                                          .containsKey('Inter'),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5.0, 10.0, 5.0, 0.0),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: FFAppState().designer(
                                          requestFn: () => BackendAPIGroup
                                              .getDesignersCall
                                              .call(),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return const HiddengemsShimmerWidget();
                                          }
                                          final rowGetDesignersResponse =
                                              snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              final designer = (BackendAPIGroup
                                                          .getDesignersCall
                                                          .designerBody(
                                                            rowGetDesignersResponse
                                                                .jsonBody,
                                                          )
                                                          ?.toList() ??
                                                      [])
                                                  .take(8)
                                                  .toList();

                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: List.generate(
                                                      designer.length,
                                                      (designerIndex) {
                                                    final designerItem =
                                                        designer[designerIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
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
                                                          context.pushNamed(
                                                            'HiddenGems',
                                                            queryParameters: {
                                                              'designerId':
                                                                  serializeParam(
                                                                getJsonField(
                                                                  designerItem,
                                                                  r'''$._id''',
                                                                ).toString(),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                getJsonField(
                                                                  designerItem,
                                                                  r'''$.logoUrl''',
                                                                ).toString(),
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.2,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.1,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Style inspiration For You!!',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      GoogleFonts.asMap()
                                                          .containsKey(
                                                              'Montserrat'),
                                                ),
                                          ).animateOnPageLoad(animationsMap[
                                              'textOnPageLoadAnimation1']!),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 20.0),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: FFAppState().videosection(
                                          requestFn: () => BackendAPIGroup
                                              .getallvideosCall
                                              .call(),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final rowGetallvideosResponse =
                                              snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              final bodyforvideos =
                                                  (BackendAPIGroup
                                                              .getallvideosCall
                                                              .body(
                                                                rowGetallvideosResponse
                                                                    .jsonBody,
                                                              )
                                                              ?.toList() ??
                                                          [])
                                                      .take(4)
                                                      .toList();

                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      bodyforvideos.length,
                                                      (bodyforvideosIndex) {
                                                    final bodyforvideosItem =
                                                        bodyforvideos[
                                                            bodyforvideosIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Stack(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, 1.0),
                                                          children: [
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                context.pushNamed(
                                                                    'VideoContent');
                                                              },
                                                              child:
                                                                  FlutterFlowVideoPlayer(
                                                                path:
                                                                    getJsonField(
                                                                  bodyforvideosItem,
                                                                  r'''$.videoUrl''',
                                                                ).toString(),
                                                                videoType:
                                                                    VideoType
                                                                        .network,
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.25,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.18,
                                                                autoPlay: false,
                                                                looping: true,
                                                                showControls:
                                                                    false,
                                                                allowFullScreen:
                                                                    false,
                                                                allowPlaybackSpeedMenu:
                                                                    false,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child: Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                                child: Text(
                                                                  getJsonField(
                                                                    bodyforvideosItem,
                                                                    r'''$.userId.displayName''',
                                                                  )
                                                                      .toString()
                                                                      .maybeHandleOverflow(
                                                                        maxChars:
                                                                            10,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey('Inter'),
                                                                        lineHeight:
                                                                            2.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Newly added products',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Montserrat'),
                                    ),
                              ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation2']!),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: const BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 50.0),
                              child: FutureBuilder<ApiCallResponse>(
                                future: FFAppState().products(
                                  requestFn: () => BackendAPIGroup
                                      .getLatestProductsCall
                                      .call(),
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
                                          crossAxisSpacing: 8.0,
                                          childAspectRatio: 0.67,
                                        ),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: latestProducts.length,
                                        itemBuilder:
                                            (context, latestProductsIndex) {
                                          final latestProductsItem =
                                              latestProducts[
                                                  latestProductsIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'productDescriptionColor',
                                                queryParameters: {
                                                  'productId': serializeParam(
                                                    getJsonField(
                                                      latestProductsItem,
                                                      r'''$._id''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          2.5,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.23,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 10.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.network(
                                                        getJsonField(
                                                          latestProductsItem,
                                                          r'''$.coverImage''',
                                                        ).toString(),
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 15.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    decoration: const BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: Text(
                                                        getJsonField(
                                                          latestProductsItem,
                                                          r'''$.productName''',
                                                        )
                                                            .toString()
                                                            .maybeHandleOverflow(
                                                              maxChars: 20,
                                                              replacement: '…',
                                                            ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              color: const Color(
                                                                  0xFF232323),
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              useGoogleFonts:
                                                                  GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          'Inter'),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                10.0,
                                                                15.0,
                                                                0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '₹${getJsonField(
                                                            latestProductsItem,
                                                            r'''$.price''',
                                                          ).toString()}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: const Color(
                                                                    0xFF263F96),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Inter'),
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
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
