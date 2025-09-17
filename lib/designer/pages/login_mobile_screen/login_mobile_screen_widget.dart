import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'login_mobile_screen_model.dart';

export 'login_mobile_screen_model.dart';

class LoginMobileScreenWidget extends StatefulWidget {
  const LoginMobileScreenWidget({super.key});

  static String routeName = 'LoginMobileScreen';
  static String routePath = '/loginMobileScreen';

  @override
  State<LoginMobileScreenWidget> createState() =>
      _LoginMobileScreenWidgetState();
}

class _LoginMobileScreenWidgetState extends State<LoginMobileScreenWidget>
    with TickerProviderStateMixin {
  late LoginMobileScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginMobileScreenModel());

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    authManager.handlePhoneAuthStateChanges(context);
    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 180.0.ms,
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.0, 1.0),
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: true,
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 1, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(8),
                      //   child: Image.asset(
                      //     'assets/images/Asset_4.webp',
                      //     width: screenSize.width * 0.2,
                      //     height: screenSize.height * 0.13,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(8),
                      //   child: Image.asset(
                      //     'assets/images/Asset_3.webp',
                      //     width: screenSize.width * 0.493,
                      //     height: screenSize.height * 0.1,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  'What is your mobile number?',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Inter'),
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tap "Continue" to receive an OTP on your mobile number.',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Inter'),
                      ),
                ),
                const SizedBox(height: 36),
                // Text(
                //   'Mobile Number ',
                //   style: FlutterFlowTheme.of(context).bodyMedium.override(
                //         fontFamily: 'Inter',
                //         color: const Color(0xFF232323),
                //         fontSize: 14,
                //         letterSpacing: 0.0,
                //         fontWeight: FontWeight.w500,
                //         useGoogleFonts:
                //             GoogleFonts.asMap().containsKey('Inter'),
                //       ),
                // ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _model.emailTextController,
                  focusNode: _model.emailFocusNode,
                  autofocus: true,
                  maxLength: 10,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          required maxLength}) =>
                      const SizedBox.shrink(),
                  onChanged: (val) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelMediumFamily),
                        ),
                    hintText: 'Enter 10 digit mobile number',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: FlutterFlowTheme.of(context)
                              .secondaryText
                              .withOpacity(0.65),
                          fontSize: 12,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).labelMediumFamily),
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(
                      Icons.phone_sharp,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 20,
                    ),
                    suffixIcon: Icon(
                      Icons.check_circle_sharp,
                      color: (_model.emailTextController.text.length == 10)
                          ? const Color(0xFF323FA4)
                          : Colors.grey,
                      size: 20,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                  keyboardType: TextInputType.number,
                  validator:
                      _model.emailTextControllerValidator.asValidator(context),
                ),
                const SizedBox(height: 20),
                // const Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     // Text(
                //     //   'Don\'t have an account?  ',
                //     //   style: FlutterFlowTheme.of(context).bodyMedium.override(
                //     //         fontFamily:
                //     //             FlutterFlowTheme.of(context).bodyMediumFamily,
                //     //         fontSize: 12,
                //     //         letterSpacing: 0.0,
                //     //         useGoogleFonts: GoogleFonts.asMap().containsKey(
                //     //             FlutterFlowTheme.of(context).bodyMediumFamily),
                //     //       ),
                //     // ),
                //     // InkWell(
                //     //   splashColor: Colors.transparent,
                //     //   focusColor: Colors.transparent,
                //     //   hoverColor: Colors.transparent,
                //     //   highlightColor: Colors.transparent,
                //     //   onTap: () async {
                //     //     context.pushNamed(CreateAnAccountWidget.routeName);
                //     //   },
                //     //   child: Text(
                //     //     'Sign Up',
                //     //     style: FlutterFlowTheme.of(context).bodyMedium.override(
                //     //           fontFamily: 'Inter',
                //     //           color: const Color(0xFF323FA4),
                //     //           letterSpacing: 0.0,
                //     //           fontWeight: FontWeight.w600,
                //     //           useGoogleFonts:
                //     //               GoogleFonts.asMap().containsKey('Inter'),
                //     //         ),
                //     //   ),
                //     // ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: FFButtonWidget(
            onPressed: () async {
              final phoneNumber = _model.emailTextController.text;

              if (phoneNumber.length != 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Please enter a valid 10 digit mobile number'),
                  ),
                );
                return;
              }

              final phoneNumberVal = '+91${_model.emailTextController.text}';

              await authManager.beginPhoneAuth(
                context: context,
                phoneNumber: phoneNumberVal,
                onCodeSent: (context) async {
                  context.goNamedAuth(
                    OtpLoginWidget.routeName,
                    context.mounted,
                    queryParameters: {
                      'phoneNumber': phoneNumberVal,
                      'email': serializeParam(
                        '',
                        ParamType.String,
                      ),
                    }.withoutNulls,
                    ignoreRedirect: true,
                  );
                },
              );
            },
            text: 'Continue',
            options: FFButtonOptions(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.065,
              padding: const EdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Inter',
                    color: const Color(0xFFFDFDFD),
                    fontSize: 15,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                  ),
              elevation: 3,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
