import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'login_or_guest_model.dart';

export 'login_or_guest_model.dart';

class LoginOrGuestWidget extends StatefulWidget {
  const LoginOrGuestWidget({super.key});

  @override
  State<LoginOrGuestWidget> createState() => _LoginOrGuestWidgetState();
}

class _LoginOrGuestWidgetState extends State<LoginOrGuestWidget> {
  late LoginOrGuestModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginOrGuestModel());
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
      child: PopScope(
        onPopInvokedWithResult: (res, obj) async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 64, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/Asset_4.webp',
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).height * 0.13,
                          fit: BoxFit.contain,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/Asset_3.webp',
                          width: MediaQuery.sizeOf(context).width * 0.493,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('LoginMobileScreen');
                    },
                    text: 'Log In with Phone Number',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.065,
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Inter'),
                              ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 36, 20, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.goNamed('Homepage');
                    },
                    text: 'Continue As a Guest',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.065,
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Inter'),
                              ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Don\'t Have An Account?',
                //         style: FlutterFlowTheme.of(context).bodyMedium.override(
                //               fontFamily: 'Inter',
                //               letterSpacing: 0.0,
                //               useGoogleFonts:
                //                   GoogleFonts.asMap().containsKey('Inter'),
                //             ),
                //       ),
                //       Padding(
                //         padding:
                //             const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                //         child: InkWell(
                //           splashColor: Colors.transparent,
                //           focusColor: Colors.transparent,
                //           hoverColor: Colors.transparent,
                //           highlightColor: Colors.transparent,
                //           onTap: () async {
                //             context.pushNamed('CreateAnAccount');
                //           },
                //           child: Text(
                //           'Sign Up',
                //             style: FlutterFlowTheme.of(context)
                //                 .bodyMedium
                //                 .override(
                //                   fontFamily: 'Inter',
                //                   color: const Color(0xFFC9A54B),
                //                   letterSpacing: 0.0,
                //                   useGoogleFonts:
                //                       GoogleFonts.asMap().containsKey('Inter'),
                //                 ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 36),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('approvalCopy');
                    },
                    text: 'Want To Join As A Business?',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.065,
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: const Color(0xFF232323),
                                fontSize: 16,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Inter'),
                              ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
