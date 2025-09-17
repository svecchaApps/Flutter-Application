import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'designer_store_page_model.dart';

export 'designer_store_page_model.dart';

class DesignerStorePageWidget extends StatefulWidget {
  const DesignerStorePageWidget({
    super.key,
    required this.designerref,
  });

  final String? designerref;

  static String routeName = 'DesignerStorePage';
  static String routePath = '/designerStorePage';

  @override
  State<DesignerStorePageWidget> createState() =>
      _DesignerStorePageWidgetState();
}

class _DesignerStorePageWidgetState extends State<DesignerStorePageWidget>
    with TickerProviderStateMixin {
  late DesignerStorePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DesignerStorePageModel());

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 2.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(BackendAPIGroup.getDesignerProductsCall.call(
              designerId: widget.designerref,
              category: FFAppState().categoryFilter,
              minPrice: FFAppState().min,
              maxPrice: FFAppState().max,
              sortBy: 'Price',
              order: FFAppState().sort,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.

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
        final designerStorePageGetDesignerProductsResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 50, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                                FFAppState().categoryFilter = '';
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.chevron_left,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 0, 0),
                              child: Text(
                                'Store',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Inter'),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 20, 0),
                              child: FlutterFlowIconButton(
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize:
                                    MediaQuery.sizeOf(context).width * 0.1,
                                fillColor:
                                    FlutterFlowTheme.of(context).alternate,
                                icon: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Color(0xFF263F96),
                                  size: 22,
                                ),
                                onPressed: () async {
                                  context.pushNamed(
                                      CartPagenewCopyWidget.routeName);
                                },
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 30,
                              buttonSize: 40,
                              fillColor: FlutterFlowTheme.of(context).alternate,
                              icon: const Icon(
                                Icons.filter_alt,
                                color: Color(0xFF263F96),
                                size: 24,
                              ),
                              onPressed: () async {
                                context.pushNamed(
                                  ApplyFilterspageDesignerWidget.routeName,
                                  queryParameters: {
                                    'designerRef': serializeParam(
                                      widget.designerref,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: FutureBuilder<ApiCallResponse>(
                      future: BackendAPIGroup.getCategoriesCall.call(),
                      builder: (context, snapshot) {
                        print(snapshot.data?.statusCode);
                        if (snapshot.data?.statusCode == 404) {
                          return SizedBox(
                            height: 400, // Adjust height as needed
                            child: Center(
                                child: Image.asset(
                              'assets/images/images.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            )
                                // Lottie.asset(
                                //   'assets/lottie/empty.json',
                                //   width: 200,
                                //   height: 200,
                                //   fit: BoxFit.contain,
                                // ),
                                ),
                          );
                        }
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
                        final rowGetCategoriesResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final categoryVBody =
                                BackendAPIGroup.getCategoriesCall
                                        .categoryPath(
                                          rowGetCategoriesResponse.jsonBody,
                                        )
                                        ?.toList() ??
                                    [];

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(categoryVBody.length,
                                    (categoryVBodyIndex) {
                                  final categoryVBodyItem =
                                      categoryVBody[categoryVBodyIndex];
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 20, 0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        FFAppState().categoryFilter =
                                            getJsonField(
                                          categoryVBodyItem,
                                          r'''$._id''',
                                        ).toString();
                                        safeSetState(() {});
                                        HapticFeedback.heavyImpact();
                                        safeSetState(() =>
                                            _model.apiRequestCompleter = null);
                                        await _model
                                            .waitForApiRequestCompleted();
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.17,
                                            height: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.17,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              getJsonField(
                                                categoryVBodyItem,
                                                r'''$.image''',
                                              ).toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 5, 0, 0),
                                            child: Text(
                                              getJsonField(
                                                categoryVBodyItem,
                                                r'''$.name''',
                                              ).toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
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
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                    child: FutureBuilder<ApiCallResponse>(
                      future: BackendAPIGroup.wishlistCall.call(
                        userId: FFAppState().userId,
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
                        final gridViewWishlistResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            if (designerStorePageGetDesignerProductsResponse
                                    .statusCode ==
                                404) {
                              return SizedBox(
                                height: 400, // Adjust height as needed
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/emptyimage.png',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.contain,
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     safeSetState(() {
                                      //       _model.apiRequestCompleter = null;
                                      //     });
                                      //   },
                                      //   child: const Text('Reload Products'),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            final mainBody =
                                BackendAPIGroup.getDesignerProductsCall
                                        .productsMain(
                                          designerStorePageGetDesignerProductsResponse
                                              .jsonBody,
                                        )
                                        ?.toList() ??
                                    [];

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.59,
                              ),
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: mainBody.length,
                              itemBuilder: (context, mainBodyIndex) {
                                final mainBodyItem = mainBody[mainBodyIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ProductDescriptionColorWidget.routeName,
                                      queryParameters: {
                                        'productId': serializeParam(
                                          getJsonField(
                                            mainBodyItem,
                                            r'''$._id''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                        'price': serializeParam(
                                          getJsonField(
                                            mainBodyItem,
                                            r'''$.price''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  2.5,
                                          height: 210,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 5, 5, 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                  child: Image.network(
                                                    getJsonField(
                                                      mainBodyItem,
                                                      r'''$.coverImage''',
                                                    ).toString(),
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    height: 230,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Container(
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 15, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    getJsonField(
                                                      mainBodyItem,
                                                      r'''$.productName''',
                                                    )
                                                        .toString()
                                                        .maybeHandleOverflow(
                                                          maxChars: 20,
                                                          replacement: '…',
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: const Color(
                                                              0xFF263F96),
                                                          fontSize: 10,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Inter'),
                                                        ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      if (functions
                                                              .newCustomFunction3(
                                                                  getJsonField(
                                                                    mainBodyItem,
                                                                    r'''$.wishlistedBy''',
                                                                  ),
                                                                  FFAppState()
                                                                      .userId) ??
                                                          true)
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0, 0),
                                                          child: InkWell(
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
                                                              _model.apiResultdsh =
                                                                  await BackendAPIGroup
                                                                      .createWishListCall
                                                                      .call(
                                                                userId:
                                                                    FFAppState()
                                                                        .userId,
                                                                productId:
                                                                    getJsonField(
                                                                  mainBodyItem,
                                                                  r'''$._id''',
                                                                ).toString(),
                                                              );

                                                              if ((_model
                                                                      .apiResultdsh
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      getJsonField(
                                                                        (_model.apiResultdsh?.jsonBody ??
                                                                            ''),
                                                                        r'''$.message''',
                                                                      ).toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                  ),
                                                                );
                                                                safeSetState(() =>
                                                                    _model.apiRequestCompleter =
                                                                        null);
                                                                await _model
                                                                    .waitForApiRequestCompleted();
                                                                if (animationsMap[
                                                                        'iconOnActionTriggerAnimation'] !=
                                                                    null) {
                                                                  await animationsMap[
                                                                          'iconOnActionTriggerAnimation']!
                                                                      .controller
                                                                      .forward(
                                                                          from:
                                                                              0.0);
                                                                }
                                                                HapticFeedback
                                                                    .mediumImpact();
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      getJsonField(
                                                                        (_model.apiResultdsh?.jsonBody ??
                                                                            ''),
                                                                        r'''$.message''',
                                                                      ).toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                  ),
                                                                );
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      if (!functions
                                                          .newCustomFunction3(
                                                              getJsonField(
                                                                mainBodyItem,
                                                                r'''$.wishlistedBy''',
                                                              ),
                                                              FFAppState()
                                                                  .userId)!)
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0, 0),
                                                          child: InkWell(
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
                                                              _model.apiResultdshcopy =
                                                                  await BackendAPIGroup
                                                                      .createWishListCall
                                                                      .call(
                                                                userId:
                                                                    FFAppState()
                                                                        .userId,
                                                                productId:
                                                                    getJsonField(
                                                                  mainBodyItem,
                                                                  r'''$._id''',
                                                                ).toString(),
                                                              );

                                                              if ((_model
                                                                      .apiResultdshcopy
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      getJsonField(
                                                                        (_model.apiResultdshcopy?.jsonBody ??
                                                                            ''),
                                                                        r'''$.message''',
                                                                      ).toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                  ),
                                                                );
                                                                safeSetState(() =>
                                                                    _model.apiRequestCompleter =
                                                                        null);
                                                                await _model
                                                                    .waitForApiRequestCompleted();
                                                                if (animationsMap[
                                                                        'iconOnActionTriggerAnimation'] !=
                                                                    null) {
                                                                  await animationsMap[
                                                                          'iconOnActionTriggerAnimation']!
                                                                      .controller
                                                                      .forward(
                                                                          from:
                                                                              0.0);
                                                                }
                                                                HapticFeedback
                                                                    .mediumImpact();
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      getJsonField(
                                                                        (_model.apiResultdshcopy?.jsonBody ??
                                                                            ''),
                                                                        r'''$.message''',
                                                                      ).toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                      ),
                                                                    ),
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                  ),
                                                                );
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              size: 18,
                                                            ),
                                                          ).animateOnActionTrigger(
                                                            animationsMap[
                                                                'iconOnActionTriggerAnimation']!,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 5, 0, 0),
                                            child: Text(
                                              getJsonField(
                                                mainBodyItem,
                                                r'''$.price''',
                                              ).toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color:
                                                        const Color(0xFF323FA4),
                                                    fontSize: 12,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily),
                                                  ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
