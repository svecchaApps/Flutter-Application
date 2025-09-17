import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'cart_pagenew_copy_model.dart';

export 'cart_pagenew_copy_model.dart';

class CartPagenewCopyWidget extends StatefulWidget {
  const CartPagenewCopyWidget({super.key});

  static String routeName = 'CartPagenewCopy';
  static String routePath = '/cartPagenewCopy';

  @override
  State<CartPagenewCopyWidget> createState() => _CartPagenewCopyWidgetState();
}

class _CartPagenewCopyWidgetState extends State<CartPagenewCopyWidget> {
  late CartPagenewCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartPagenewCopyModel());
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
            ..complete(BackendAPIGroup.getCartForUserCall.call(
              userId: FFAppState().userId,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final cartPagenewCopyGetCartForUserResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 0,
              leading: const SizedBox.shrink(),
              titleSpacing: 24,
              title: Text(
                'My Cart',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: const Color(0xAD14181B),
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  if (BackendAPIGroup.getCartForUserCall
                          .cartItems(
                            cartPagenewCopyGetCartForUserResponse.jsonBody,
                          )
                          ?.length ==
                      null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'No Items in Cart',
                            style: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyLargeFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyLargeFamily),
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Lottie.asset(
                              'assets/jsons/Animation_-_1729773863949.json',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.contain,
                              animate: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (getJsonField(
                        cartPagenewCopyGetCartForUserResponse.jsonBody,
                        r'''$.*.products''',
                      ) !=
                      null) {
                    return Builder(
                      builder: (context) {
                        final cartItems = BackendAPIGroup.getCartForUserCall
                                .cartItems(
                                  cartPagenewCopyGetCartForUserResponse
                                      .jsonBody,
                                )
                                ?.toList() ??
                            [];

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cartItems.length,
                          itemBuilder: (context, cartItemsIndex) {
                            return _cartItemWidget(cartItems[cartItemsIndex]);
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: (BackendAPIGroup.getCartForUserCall
                        .cartItems(
                          cartPagenewCopyGetCartForUserResponse.jsonBody,
                        )
                        ?.length !=
                    null)
                ? Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Color(0xFF263F96),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 5.0, 20.0, 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '₹${BackendAPIGroup.getCartForUserCall.cartSubtotal(
                                  cartPagenewCopyGetCartForUserResponse
                                      .jsonBody,
                                )?.toString()}',
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .displaySmallFamily),
                                ),
                          ),
                          const Spacer(),
                          FFButtonWidget(
                            onPressed: () async {
                              if (isUserAuthenticated) {
                                context.pushNamed('paymentpage');
                              } else {
                                // Show login dialog - phone login only
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Login Required'),
                                      content: const Text(
                                          'Please login with your phone number to place order.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context
                                                .pushNamed('LoginMobileScreen');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF3B82F6),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.phone_android,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Login with Phone',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            text: 'Check Out',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.24,
                              padding: EdgeInsets.zero,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Inter'),
                                  ),
                              elevation: 0.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _cartItemWidget(dynamic cartItemData) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width * 0.88,
      height: screenSize.height * 0.189,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: screenSize.width * 0.25,
            height: screenSize.height * 0.13,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                getJsonField(
                  cartItemData,
                  r'''$.image''',
                ).toString(),
                width: 300.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, -1.0),
                    child: Text(
                      getJsonField(
                        cartItemData,
                        r'''$.productName''',
                      ).toString(),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: const Color(0xFF201A25),
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                  ),
                  Text(
                    '₹${getJsonField(
                      cartItemData,
                      r'''$.price''',
                    ).toString()}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                  Text(
                    'Size:${getJsonField(
                      cartItemData,
                      r'''$.size''',
                    ).toString()}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: const Color(0xFF201A25),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                  Text(
                    'Color:${getJsonField(
                      cartItemData,
                      r'''$.color''',
                    ).toString()}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: const Color(0xFF201A25),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.2,
              height: MediaQuery.sizeOf(context).height * 0.15,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.apiResulta4w = await BackendAPIGroup
                          .updateQuantityForCartItemsCall
                          .call(
                        userId: FFAppState().userId,
                        productId: getJsonField(
                          cartItemData,
                          r'''$.*._id''',
                        ).toString(),
                        size: getJsonField(
                          cartItemData,
                          r'''$.size''',
                        ).toString(),
                        quantity: functions.decrementvalue(getJsonField(
                          cartItemData,
                          r'''$.quantity''',
                        )),
                        color: getJsonField(
                          cartItemData,
                          r'''$.color''',
                        ).toString(),
                      );

                      if ((_model.apiResulta4w?.succeeded ?? true)) {
                        safeSetState(() => _model.apiRequestCompleter = null);
                        await _model.waitForApiRequestCompleted();
                      }

                      safeSetState(() {});
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.06,
                      height: MediaQuery.sizeOf(context).height * 0.03,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECEEF6),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.minus,
                          color: Color(0xFF263F96),
                          size: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      getJsonField(
                        cartItemData,
                        r'''$.quantity''',
                      ).toString(),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.apiResulta4wCopy = await BackendAPIGroup
                          .updateQuantityForCartItemsCall
                          .call(
                        userId: FFAppState().userId,
                        productId: getJsonField(
                          cartItemData,
                          r'''$.*._id''',
                        ).toString(),
                        size: getJsonField(
                          cartItemData,
                          r'''$.size''',
                        ).toString(),
                        quantity: functions.incrementValue(getJsonField(
                          cartItemData,
                          r'''$.quantity''',
                        )),
                        color: getJsonField(
                          cartItemData,
                          r'''$.color''',
                        ).toString(),
                      );

                      if ((_model.apiResulta4wCopy?.succeeded ?? true)) {
                        safeSetState(() => _model.apiRequestCompleter = null);
                        await _model.waitForApiRequestCompleted();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              getJsonField(
                                (_model.apiResulta4wCopy?.jsonBody ?? ''),
                                r'''$.message''',
                              ).toString(),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }

                      safeSetState(() {});
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.06,
                      height: MediaQuery.sizeOf(context).height * 0.03,
                      decoration: BoxDecoration(
                        color: const Color(0xFF263F96),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Icon(
                          Icons.add,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 16.0,
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
    );
  }
}
