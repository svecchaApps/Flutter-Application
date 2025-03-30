import '';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'productofdesignerclient_copy_copy_model.dart';
export 'productofdesignerclient_copy_copy_model.dart';

class ProductofdesignerclientCopyCopyWidget extends StatefulWidget {
  const ProductofdesignerclientCopyCopyWidget({
    super.key,
    this.subcategoryid,
  });

  final String? subcategoryid;

  static String routeName = 'ProductofdesignerclientCopyCopy';
  static String routePath = '/productofdesignerclientCopyCopy';

  @override
  State<ProductofdesignerclientCopyCopyWidget> createState() =>
      _ProductofdesignerclientCopyCopyWidgetState();
}

class _ProductofdesignerclientCopyCopyWidgetState
    extends State<ProductofdesignerclientCopyCopyWidget>
    with TickerProviderStateMixin {
  late ProductofdesignerclientCopyCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductofdesignerclientCopyCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});

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
            ..complete(BackendAPIGroup.getProductsBySubcategoryCall.call(
              subcategoryId: widget!.subcategoryid,
              color: FFAppState().color,
              minPrice: FFAppState().min,
              maxPrice: FFAppState().max,
              fit: FFAppState().fit,
              sort: FFAppState().sort,
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
        final productofdesignerclientCopyCopyGetProductsBySubcategoryResponse =
            snapshot.data!;

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
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.safePop();
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24,
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      height: MediaQuery.sizeOf(context).width * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            ApplyFiltersWidget.routeName,
                            queryParameters: {
                              'subCategoryid': serializeParam(
                                widget!.subcategoryid,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Icon(
                          FFIcons.kparams,
                          color: Color(0xFF263F96),
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().max = '';
                        FFAppState().fit = '';
                        FFAppState().color = '';
                        FFAppState().sort = '';
                        safeSetState(() {});
                        safeSetState(() => _model.apiRequestCompleter = null);
                        await _model.waitForApiRequestCompleted();
                      },
                      child: Icon(
                        Icons.close_sharp,
                        color: Color(0x6D04137B),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 50),
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
                              final productBody =
                                  BackendAPIGroup.getProductsBySubcategoryCall
                                          .pRODUCTbODY(
                                            productofdesignerclientCopyCopyGetProductsBySubcategoryResponse
                                                .jsonBody,
                                          )
                                          ?.toList() ??
                                      [];

                              return RefreshIndicator(
                                onRefresh: () async {},
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.63,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: productBody.length,
                                  itemBuilder: (context, productBodyIndex) {
                                    final productBodyItem =
                                        productBody[productBodyIndex];
                                    return InkWell(
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
                                                productBodyItem,
                                                r'''$._id''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                            'price': serializeParam(
                                              getJsonField(
                                                productBodyItem,
                                                r'''$.price''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  2.5,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.28,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 5, 5, 5),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      child: Image.network(
                                                        getJsonField(
                                                          productBodyItem,
                                                          r'''$.coverImage''',
                                                        ).toString(),
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.25,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(15, 0, 15, 0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 5, 0),
                                                  child: Text(
                                                    getJsonField(
                                                      productBodyItem,
                                                      r'''$.productName''',
                                                    )
                                                        .toString()
                                                        .maybeHandleOverflow(
                                                          maxChars: 20,
                                                          replacement: '…',
                                                        ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF232323),
                                                          fontSize: 12,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(15, 10, 15, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '₹${getJsonField(
                                                      productBodyItem,
                                                      r'''$.price''',
                                                    ).toString()}',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF263F96),
                                                          fontSize: 12,
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
                                                  Stack(
                                                    children: [
                                                      if (functions
                                                              .newCustomFunction3(
                                                                  getJsonField(
                                                                    productBodyItem,
                                                                    r'''$.wishlistedBy''',
                                                                  ),
                                                                  FFAppState()
                                                                      .userId) ??
                                                          true)
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
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
                                                                  productBodyItem,
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
                                                                    duration: Duration(
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
                                                                    duration: Duration(
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
                                                                productBodyItem,
                                                                r'''$.wishlistedBy''',
                                                              ),
                                                              FFAppState()
                                                                  .userId)!)
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
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
                                                                  productBodyItem,
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
                                                                    duration: Duration(
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
                                                                    duration: Duration(
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
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
          ),
        );
      },
    );
  }
}
