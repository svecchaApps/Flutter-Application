import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'coupon_code_model.dart';
export 'coupon_code_model.dart';

class CouponCodeWidget extends StatefulWidget {
  const CouponCodeWidget({super.key});

  static String routeName = 'couponCode';
  static String routePath = '/couponCode';

  @override
  State<CouponCodeWidget> createState() => _CouponCodeWidgetState();
}

class _CouponCodeWidgetState extends State<CouponCodeWidget> {
  late CouponCodeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CouponCodeModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      future: BackendAPIGroup.getActiveCouponsCall.call(),
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
        final couponCodeGetAllCouponsResponse = snapshot.data!;
        final rawBody = couponCodeGetAllCouponsResponse.jsonBody;
        final listFromApi = BackendAPIGroup.getActiveCouponsCall.body(rawBody);
        debugPrint(
          '[COUPON] Active coupons API: statusCode=${couponCodeGetAllCouponsResponse.statusCode}, '
          'succeeded=${couponCodeGetAllCouponsResponse.succeeded}, '
          'jsonBody type=${rawBody?.runtimeType}, '
          'listFromApi=${listFromApi?.length ?? 0} items',
        );
        if (rawBody != null && rawBody is Map && listFromApi == null) {
          debugPrint(
            '[COUPON] Response keys: ${rawBody.keys.toList()}, data present: ${rawBody.containsKey('data')}',
          );
        }

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
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.safePop();
                },
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24,
                ),
              ),
              title: Text(
                'Apply Coupon',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: FlutterFlowTheme.of(context).bodyMedium,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                        child: Text(
                          'Available Coupons',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                font: FlutterFlowTheme.of(context).bodyLarge,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Enter Coupon Code',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: FlutterFlowTheme.of(context)
                                          .labelMedium,
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final couponCode =
                                _model.textController.text.trim();
                            final userId = FFAppState().userId;
                            final cartId = FFAppState().cartId;

                            if (couponCode.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter a coupon code',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                              return;
                            }
                            if (userId.isEmpty || cartId.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Cart or session missing. Please try again from the cart.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                              return;
                            }

                            final requestBody =
                                '{"userId":"$userId","couponCode":"$couponCode","cartId":"$cartId"}';
                            debugPrint(
                              '[COUPON] Calling apply coupon API (applyUniversal): '
                              'userId=$userId, cartId=$cartId, couponCode=$couponCode',
                            );
                            debugPrint(
                                '[COUPON] Request body (applyUniversal): $requestBody');
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Applying coupon...',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            }

                            try {
                              _model.apiResult8p9 = await BackendAPIGroup
                                  .applyCouponUniversalCall
                                  .call(
                                userId: userId,
                                couponCode: couponCode,
                                cartId: cartId,
                              );
                              final body =
                                  _model.apiResult8p9?.jsonBody?.toString() ??
                                      '';
                              debugPrint(
                                '[COUPON] API response: statusCode=${_model.apiResult8p9?.statusCode}, '
                                'succeeded=${_model.apiResult8p9?.succeeded}, '
                                'body=${body.length > 200 ? '${body.substring(0, 200)}...' : body}',
                              );
                            } catch (e, stack) {
                              debugPrint('[COUPON] API exception: $e');
                              debugPrint('[COUPON] Stack: $stack');
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to apply coupon. Please try again.',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                              }
                              safeSetState(() {});
                              return;
                            }

                            if (_model.apiResult8p9?.succeeded ?? false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Coupon Applied Successfully ',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                              FFAppState().applyCoupon = true;
                              safeSetState(() {});

                              context.goNamed(PaymentpageWidget.routeName);
                            } else {
                              final message = getJsonField(
                                (_model.apiResult8p9?.jsonBody ?? ''),
                                r'''$.message''',
                              ).toString();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    message.isNotEmpty
                                        ? message
                                        : 'Coupon could not be applied.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
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
                          text: 'Apply Coupon',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width,
                            height: 40,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 16, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: FlutterFlowTheme.of(context).titleSmall,
                                  color: Colors.white,
                                  fontSize: 12,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Available Coupons',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: FlutterFlowTheme.of(context)
                                            .bodyLarge,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final jsonBody =
                                        (listFromApi?.toList() ?? []);

                                    if (jsonBody.isEmpty &&
                                        couponCodeGetAllCouponsResponse
                                            .succeeded) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          'No active coupons at the moment.',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      );
                                    }
                                    if (jsonBody.isEmpty &&
                                        !couponCodeGetAllCouponsResponse
                                            .succeeded) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          'Could not load coupons. Please try again.',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: jsonBody.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 16),
                                      itemBuilder: (context, jsonBodyIndex) {
                                        final jsonBodyItem =
                                            jsonBody[jsonBodyIndex];
                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE3F2FD),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 12, 12, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      getJsonField(
                                                        jsonBodyItem,
                                                        r'''$.couponCode''',
                                                      ).toString(),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .override(
                                                                font: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                    ),
                                                    Text(
                                                      'Save ${getJsonField(
                                                        jsonBodyItem,
                                                        r'''$.couponAmount''',
                                                      ).toString()}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                font: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    final userId =
                                                        FFAppState().userId;
                                                    final cartId =
                                                        FFAppState().cartId;
                                                    final couponCodeFromItem =
                                                        getJsonField(
                                                      jsonBodyItem,
                                                      r'''$.couponCode''',
                                                    ).toString();
                                                    if (userId.isEmpty ||
                                                        cartId.isEmpty) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Cart or session missing. Please try again from the cart.',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    final requestBodyApply =
                                                        '{"userId":"$userId","couponCode":"$couponCodeFromItem","cartId":"$cartId"}';
                                                    debugPrint(
                                                      '[COUPON] Calling apply coupon API (applyUniversal from list): '
                                                      'userId=$userId, cartId=$cartId, couponCode=$couponCodeFromItem',
                                                    );
                                                    debugPrint(
                                                      '[COUPON] Request body (applyUniversal): $requestBodyApply',
                                                    );
                                                    try {
                                                      _model.apiResult8p9 =
                                                          await BackendAPIGroup
                                                              .applyCouponUniversalCall
                                                              .call(
                                                        userId: userId,
                                                        couponCode:
                                                            couponCodeFromItem,
                                                        cartId: cartId,
                                                      );
                                                      final resBody = _model
                                                              .apiResult8p9
                                                              ?.jsonBody
                                                              ?.toString() ??
                                                          '';
                                                      debugPrint(
                                                        '[COUPON] API response (applyUniversal): statusCode=${_model.apiResult8p9?.statusCode}, '
                                                        'succeeded=${_model.apiResult8p9?.succeeded}, '
                                                        'body=${resBody.length > 200 ? '${resBody.substring(0, 200)}...' : resBody}',
                                                      );
                                                    } catch (e, stack) {
                                                      debugPrint(
                                                          '[COUPON] API exception (applyUniversal): $e');
                                                      debugPrint(
                                                          '[COUPON] Stack: $stack');
                                                      if (mounted) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Failed to apply coupon. Please try again.',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }
                                                      safeSetState(() {});
                                                      return;
                                                    }

                                                    if (_model.apiResult8p9
                                                            ?.succeeded ??
                                                        false) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Coupon applied successfully',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                      FFAppState().applyCoupon =
                                                          true;
                                                      safeSetState(() {});

                                                      context.goNamed(
                                                          PaymentpageWidget
                                                              .routeName);
                                                    } else {
                                                      final message =
                                                          getJsonField(
                                                        (_model.apiResult8p9
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''',
                                                      ).toString();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            message.isNotEmpty
                                                                ? message
                                                                : 'Coupon could not be applied.',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  text: 'Apply',
                                                  options: FFButtonOptions(
                                                    width: 80,
                                                    height: 36,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 0, 0, 0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 0, 0, 0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodySmall
                                                        .override(
                                                          font: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                              ].divide(const SizedBox(height: 16)),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Terms & Conditions',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        font: FlutterFlowTheme.of(context)
                                            .bodyLarge,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  '• Coupons are valid for a limited time only\n• Only one coupon can be applied per order\n• Coupons cannot be combined with other offers\n• Minimum order value may apply for some coupons\n• Indigo Rhapsody reserves the right to modify or cancel any coupon at any time',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: FlutterFlowTheme.of(context)
                                            .bodySmall,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(const SizedBox(height: 12)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                      ),
                    ].divide(const SizedBox(height: 24)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
