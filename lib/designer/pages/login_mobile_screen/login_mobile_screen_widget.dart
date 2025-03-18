import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: true,
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Login ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Let\'s login you for exploring',
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 60, 25, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Mobile Number ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Color(0xFF232323),
                            fontSize: 14,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: TextFormField(
                  controller: _model.emailTextController,
                  focusNode: _model.emailFocusNode,
                  autofocus: true,
                  obscureText: false,
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
                    hintText: '9876543210',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily:
                              FlutterFlowTheme.of(context).labelMediumFamily,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14,
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
                      color: Color(0xFF323FA4),
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 12,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(CreateAnAccountWidget.routeName);
                      },
                      child: Text(
                        'Sign up',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 30),
                child: FFButtonWidget(
                  onPressed: () async {
                    final phoneNumberVal =
                        '+91${_model.emailTextController.text}';
                    if (phoneNumberVal == null ||
                        phoneNumberVal.isEmpty ||
                        !phoneNumberVal.startsWith('+')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Incorrect Phone Number'),
                        ),
                      );
                      return;
                    }
                    await authManager.beginPhoneAuth(
                      context: context,
                      phoneNumber: phoneNumberVal,
                      onCodeSent: (context) async {
                        context.goNamedAuth(
                          OtpLoginWidget.routeName,
                          context.mounted,
                          queryParameters: {
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
                  text: 'Get Otp',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.065,
                    padding: EdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter',
                          color: Color(0xFFFDFDFD),
                          fontSize: 12,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ).animateOnPageLoad(
                    animationsMap['buttonOnPageLoadAnimation']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
