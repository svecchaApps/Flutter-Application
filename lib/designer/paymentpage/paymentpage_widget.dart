import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'paymentpage_model.dart';

export 'paymentpage_model.dart';

class PaymentpageWidget extends StatefulWidget {
  const PaymentpageWidget({super.key});

  @override
  State<PaymentpageWidget> createState() => _PaymentpageWidgetState();
}

class _PaymentpageWidgetState extends State<PaymentpageWidget> {
  late PaymentpageModel _model;
  int? selectedIndex;
  String? selectedPaymentMethod;
  String callback =
      "https://indigo-rhapsody-backend-ten.vercel.app/payment/webhook";
  String checksum = "";
  bool enableLogs = true;
  Object? result;
  String environmentValue = 'PRODUCTION';
  String appId = "";
  String merchantId = "M1LA2M87XNOE";
  String packageName = "com.mycompany.lsdapp";

  String saltKey = "6362bd9f-17b6-4eb2-b030-1ebbb78ce518";
  String saltIndex = "1";
  String apiEndPoint = "/pg/v1/pay";

  Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initPhonePeSdk() {
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogs)
        .then((isInitialized) {
      setState(() {
        result = 'PhonePe SDK Initialized - $isInitialized';
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize PhonePe SDK: $error')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    initPhonePeSdk();
    _model = createModel(context, () => PaymentpageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() => _model.apiRequestCompleter = null);
      await _model.waitForApiRequestCompleted();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleError(dynamic error) {
      result = error;
    }

    getChecksum(double amount) {
      final reqdata = {
        "merchantId": merchantId,
        "merchantTransactionId": FFAppState().paymentId,
        "merchantUserId": FFAppState().userId,
        "amount": (amount * 100).toInt(), // Use the grand total amount
        "callbackUrl": callback,
        "mobileNumber": "9560360744",
        "paymentInstrument": {"type": "PAY_PAGE"}
      };
      String base64body = base64.encode(utf8.encode(json.encode(reqdata)));
      checksum =
          '${sha256.convert(utf8.encode(base64body + apiEndPoint + saltKey))}###$saltIndex';
      return base64body;
    }

    void startTransaction(double grandTotalAmount) async {
      String body =
          getChecksum(grandTotalAmount); // Pass the amount to getChecksum
      try {
        PhonePePaymentSdk.startTransaction(
          body,
          callback,
          checksum,
          packageName,
        ).then((response) async {
          if (response != null) {
            // Handle successful transaction
            final transactionId = FFAppState().paymentId;

            final paymentResponse =
                await BackendAPIGroup.getPaymentDetailsCall.call(
              transactionId: transactionId,
            );

            if (paymentResponse.succeeded) {
              final paymentStatus = getJsonField(
                paymentResponse.jsonBody,
                r'''$.paymentDetails.paymentStatus''',
              );

              if (paymentStatus == 'Completed') {
                context.pushNamed('ordercompletedCopy');
              } else {
                context.pushNamed('payment_failed');
              }
            } else {
              // Handle payment fetching failure
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Failed to fetch payment details.')),
              );
            }
          } else {
            // Handle case where no response from PhonePe transaction
            context.pushNamed('payment_failed');
          }
        }).catchError((error) {
          handleError(error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transaction failed: $error')),
          );
        });
      } catch (error) {
        handleError(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    }

    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: BackendAPIGroup.getCartForUserCall.call(
        userId: FFAppState().userId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
        final paymentpageGetCartForUserResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: true,
              leading: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
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
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Checkout',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: const Color(0xFF4D5458),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                  ),
                ],
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('couponCode');
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Apply Coupon',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                    Icon(
                                      Icons.play_arrow,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 20.0, 10.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Address',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          color: const Color(0xFF4A5458),
                                          fontSize: 13.0,
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
                                  10.0, 0.0, 10.0, 0.0),
                              child: FutureBuilder<ApiCallResponse>(
                                future: (_apiRequestCompleter ??= Completer<
                                        ApiCallResponse>()
                                      ..complete(
                                          BackendAPIGroup.getaddressCall.call(
                                        userId: FFAppState().userId,
                                      )))
                                    .future,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  final containerGetaddressResponse =
                                      snapshot.data!;
                                  final newbody = BackendAPIGroup.getaddressCall
                                          .body(
                                            containerGetaddressResponse
                                                .jsonBody,
                                          )
                                          ?.toList() ??
                                      [];

                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: ListView.builder(
                                      primary: false,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: newbody.length,
                                      itemBuilder: (context, newbodyIndex) {
                                        final newbodyItem =
                                            newbody[newbodyIndex];
                                        final isSelected =
                                            selectedIndex == newbodyIndex;

                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                getJsonField(
                                                  newbodyItem,
                                                  r'''$.nick_name''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeFamily),
                                                        ),
                                              ),
                                              subtitle: Text(
                                                getJsonField(
                                                  newbodyItem,
                                                  r'''$.street_details''',
                                                )
                                                    .toString()
                                                    .maybeHandleOverflow(
                                                      maxChars: 40,
                                                      replacement: '…',
                                                    ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                        ),
                                              ),
                                              trailing: isSelected
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 24.0,
                                                    )
                                                  : FaIcon(
                                                      FontAwesomeIcons
                                                          .solidAddressBook,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                              tileColor: isSelected
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                      .withOpacity(0.1)
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              dense: false,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  // Update the selected index
                                                  selectedIndex = newbodyIndex;

                                                  // Update the FFAppState with the selected values
                                                  FFAppState().state =
                                                      getJsonField(
                                                    newbodyItem,
                                                    r'''$.state''',
                                                  ).toString();
                                                  FFAppState().city =
                                                      getJsonField(
                                                    newbodyItem,
                                                    r'''$.city''',
                                                  ).toString();
                                                  FFAppState().address =
                                                      getJsonField(
                                                    newbodyItem,
                                                    r'''$.street_details''',
                                                  ).toString();
                                                  FFAppState().pincode =
                                                      getJsonField(
                                                    newbodyItem,
                                                    r'''$.pincode''',
                                                  ).toString();
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('editaddresspage');
                                    },
                                    child: Text(
                                      '+ Add New',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Select Payment',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF4A5458),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  ListTile(
                                    leading: Icon(
                                      Icons.monetization_on,
                                      color: selectedPaymentMethod ==
                                              "Cash on Delivery"
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    title: const Text('Cash on Delivery'),
                                    tileColor: selectedPaymentMethod ==
                                            "Cash on Delivery"
                                        ? Colors.blue.withOpacity(0.1)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedPaymentMethod =
                                            "Cash on Delivery";
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10.0),
                                  ListTile(
                                    leading: Icon(
                                      Icons.account_balance_wallet,
                                      color: selectedPaymentMethod == "PhonePe"
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    title: const Text('PhonePe'),
                                    tileColor:
                                        selectedPaymentMethod == "PhonePe"
                                            ? Colors.blue.withOpacity(0.1)
                                            : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedPaymentMethod = "PhonePe";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 20.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Cart Details',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Inter',
                                          color: const Color(0xFF4A5458),
                                          fontSize: 18.0,
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
                                  10.0, 0.0, 10.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Sub Total',
                                            style: FlutterFlowTheme.of(context)
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
                                          Text(
                                            '₹${valueOrDefault<String>(
                                              BackendAPIGroup.getCartForUserCall
                                                  .cartSubtotal(
                                                    paymentpageGetCartForUserResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toString(),
                                              'aaa',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tax(Gst)',
                                            style: FlutterFlowTheme.of(context)
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
                                          Text(
                                            '₹${valueOrDefault<String>(
                                              BackendAPIGroup.getCartForUserCall
                                                  .tax(
                                                    paymentpageGetCartForUserResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toString(),
                                              'aaa',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery Fees',
                                            style: FlutterFlowTheme.of(context)
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
                                          Text(
                                            '₹${valueOrDefault<String>(
                                              BackendAPIGroup.getCartForUserCall
                                                  .deliveryCost(
                                                    paymentpageGetCartForUserResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toString(),
                                              'aaa',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Coupon discount',
                                            style: FlutterFlowTheme.of(context)
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
                                          Text(
                                            '₹${valueOrDefault<String>(
                                              BackendAPIGroup.getCartForUserCall
                                                  .discountAmount1(
                                                    paymentpageGetCartForUserResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toString(),
                                              'aaa',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLargeFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLargeFamily),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 20.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Grand Total ',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMediumFamily),
                                                ),
                                          ),
                                          Text(
                                            '₹${valueOrDefault<String>(
                                              BackendAPIGroup.getCartForUserCall
                                                  .cartTotalAmount(
                                                    paymentpageGetCartForUserResponse
                                                        .jsonBody,
                                                  )
                                                  ?.toString(),
                                              'sss',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLargeFamily),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2.0,
                              indent: 10.0,
                              endIndent: 10.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 5.0, 10.0, 10.0),
                    child: FFButtonWidget(
                      onPressed: (selectedPaymentMethod != null &&
                              selectedIndex != null)
                          ? () async {
                              if (selectedPaymentMethod == 'Cash on Delivery') {
                                // Cash On Delivery API call
                                final apiResult =
                                    await BackendAPIGroup.createOrderCall.call(
                                  userId: FFAppState().userId,
                                  cartId: FFAppState().cartId,
                                  paymentmethod: 'Cash on Delivery',
                                  shippingMethod: 'Online',
                                  shippingcost: '10',
                                  notes: 'handle with care',
                                  address: FFAppState().address,
                                  city: FFAppState().city,
                                  state: FFAppState().state,
                                  postalcode: FFAppState().pincode,
                                );

                                if ((apiResult.succeeded ?? false)) {
                                  context.pushNamed('ordercompletedCopy');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Order Failed!'),
                                    ),
                                  );
                                }
                              } else if (selectedPaymentMethod == 'PhonePe') {
                                final grandTotal = BackendAPIGroup
                                    .getCartForUserCall
                                    .cartTotalAmount(
                                  paymentpageGetCartForUserResponse.jsonBody,
                                );

                                _model.apiResult7gm = await BackendAPIGroup
                                    .createPaymentCall
                                    .call(
                                  cartId: FFAppState().cartId,
                                  userId: FFAppState().userId,
                                  amount: grandTotal,
                                  paymentMethod: 'PhonePe',
                                );

                                if ((_model.apiResult7gm?.succeeded ?? true)) {
                                  FFAppState().paymentId = BackendAPIGroup
                                      .createPaymentCall
                                      .transactionId(
                                    (_model.apiResult7gm?.jsonBody ?? ''),
                                  )!;
                                  safeSetState(() {});
                                }
                                // PhonePe API call

                                if (grandTotal != null && grandTotal > 0) {
                                  // Initialize PhonePe SDK if not already initialized
                                  if (result == null) {
                                    initPhonePeSdk();
                                  }

                                  // Start PhonePe transaction with grand total
                                  startTransaction(grandTotal);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Invalid grand total amount.')),
                                  );
                                }
                              }
                            }
                          : () {
                              if (selectedIndex == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select an address before proceeding.'),
                                  ),
                                );
                              }
                            },
                      text: 'Continue to Payment',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.065,
                        color: selectedPaymentMethod != null
                            ? FlutterFlowTheme.of(context).primary
                            : Colors.grey, // Disabled color
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                            ),
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20.0),
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
  }
}
