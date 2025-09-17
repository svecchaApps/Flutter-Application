import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/auth/jwt_auth_manager.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otp_login_model.dart';
export 'otp_login_model.dart';

class OtpLoginWidget extends StatefulWidget {
  const OtpLoginWidget({
    super.key,
    required this.phoneNumber,
    this.email,
    this.username,
  });

  final String phoneNumber;
  final String? email;
  final String? username;
  static String routeName = 'OtpLogin';
  static String routePath = '/otpLogin';

  @override
  State<OtpLoginWidget> createState() => _OtpLoginWidgetState();
}

class _OtpLoginWidgetState extends State<OtpLoginWidget>
    with TickerProviderStateMixin {
  late OtpLoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtpLoginModel());

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
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (canPop, result) {
          context.pushReplacementNamed('LoginMobileScreen');
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Verify OTP',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 25.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Enter the OTP sent to your Mobile Number',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                  const SizedBox(height: 48),
                  PinCodeTextField(
                    autoDisposeControllers: false,
                    appContext: context,
                    length: 6,
                    textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyLargeFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyLargeFamily),
                        ),
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    enableActiveFill: false,
                    autoFocus: true,
                    enablePinAutofill: false,
                    errorTextSpace: 16.0,
                    showCursor: true,
                    cursorColor: FlutterFlowTheme.of(context).primary,
                    obscureText: false,
                    hintCharacter: '●',
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      fieldHeight: screenSize.width * 0.13,
                      fieldWidth: screenSize.width * 0.13,
                      borderWidth: 2.0,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      shape: PinCodeFieldShape.box,
                      activeColor: FlutterFlowTheme.of(context).primaryText,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      selectedColor: FlutterFlowTheme.of(context).primary,
                    ),
                    controller: _model.pinCodeController,
                    onChanged: (_) {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:
                        _model.pinCodeControllerValidator.asValidator(context),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Not received OTP yet?  ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Inter'),
                            ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print('🔄 [RESEND_OTP] Resend OTP button pressed');
                          final phoneNumberVal = widget.phoneNumber;
                          print(
                              '🔄 [RESEND_OTP] Phone number: $phoneNumberVal');

                          if (phoneNumberVal.isEmpty ||
                              !phoneNumberVal.startsWith('+')) {
                            print(
                                '🔄 [RESEND_OTP] Invalid phone number format');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Incorrect Phone Number'),
                              ),
                            );
                            return;
                          }

                          // First try JWT authentication
                          print('🔄 [RESEND_OTP] Attempting JWT OTP resend...');
                          final jwtAuthManager = JwtAuthManager.instance;
                          final jwtResult = await jwtAuthManager.sendPhoneOtp(
                            phoneNumber: phoneNumberVal,
                          );

                          if (jwtResult != null) {
                            // JWT OTP sent successfully
                            print(
                                '🔄 [RESEND_OTP] JWT OTP resent successfully!');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'OTP resent successfully!',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 2000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            return;
                          }

                          // Fallback to Firebase authentication if JWT fails
                          await authManager
                              .beginPhoneAuth(
                            context: context,
                            phoneNumber: phoneNumberVal,
                            onCodeSent: (context) async {
                              context.goNamedAuth(
                                'OtpLogin',
                                context.mounted,
                                queryParameters: {
                                  'phoneNumber': serializeParam(
                                    widget.phoneNumber,
                                    ParamType.String,
                                  ),
                                  'email': serializeParam(
                                    widget.email,
                                    ParamType.String,
                                  ),
                                  'username': serializeParam(
                                    widget.username,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                                ignoreRedirect: true,
                              );
                            },
                          )
                              .then((_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('OTP resent successfully'),
                            ));
                          });
                        },
                        child: Text(
                          'Resend OTP',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 12.0,
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
                  const Spacer(),
                  FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      final smsCodeVal = _model.pinCodeController!.text;
                      if (smsCodeVal.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter a valid OTP')),
                        );
                        return;
                      }

                      try {
                        print('🔍 [OTP_VERIFY] Verify button pressed');
                        print(
                            '🔍 [OTP_VERIFY] Phone number: ${widget.phoneNumber}');
                        print('🔍 [OTP_VERIFY] OTP entered: $smsCodeVal');

                        // Use Firebase OTP verification to get Firebase token
                        print(
                            '🔍 [OTP_VERIFY] Using Firebase OTP verification...');
                        final phoneVerifiedUser =
                            await authManager.verifySmsCode(
                          context: context,
                          smsCode: smsCodeVal,
                        );

                        if (phoneVerifiedUser == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('OTP verification failed')),
                          );
                          return;
                        }

                        // Get Firebase ID token from the verified user
                        print('🔍 [OTP_VERIFY] Getting Firebase ID token...');
                        print(
                            '🔍 [OTP_VERIFY] Phone verified user: ${phoneVerifiedUser.uid}');
                        print(
                            '🔍 [OTP_VERIFY] Phone verified user email: ${phoneVerifiedUser.email}');
                        print(
                            '🔍 [OTP_VERIFY] Phone verified user phone: ${phoneVerifiedUser.phoneNumber}');

                        // Use the correct method to get Firebase ID token
                        String? firebaseToken;
                        try {
                          // Try different methods to get the token
                          if (phoneVerifiedUser is User) {
                            firebaseToken =
                                await phoneVerifiedUser.getIdToken();
                            print(
                                '🔍 [OTP_VERIFY] Token obtained from phoneVerifiedUser (User)');
                          } else {
                            // If it's not a User object, try to get current user
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            if (currentUser != null) {
                              firebaseToken = await currentUser.getIdToken();
                              print(
                                  '🔍 [OTP_VERIFY] Token obtained from currentUser');
                            } else {
                              print(
                                  '🔍 [OTP_VERIFY] No current user found, trying auth state...');
                              // Try to get from auth state
                              final authState =
                                  FirebaseAuth.instance.authStateChanges();
                              final user = await authState.first;
                              if (user != null) {
                                firebaseToken = await user.getIdToken();
                                print(
                                    '🔍 [OTP_VERIFY] Token obtained from auth state');
                              }
                            }
                          }
                        } catch (e) {
                          print('🔍 [OTP_VERIFY] Error getting token: $e');
                          // Try alternative method - force refresh
                          try {
                            await FirebaseAuth.instance.currentUser?.reload();
                            final refreshedUser =
                                FirebaseAuth.instance.currentUser;
                            if (refreshedUser != null) {
                              firebaseToken = await refreshedUser
                                  .getIdToken(true); // Force refresh
                              print(
                                  '🔍 [OTP_VERIFY] Token obtained after reload');
                            }
                          } catch (e2) {
                            print(
                                '🔍 [OTP_VERIFY] Alternative method also failed: $e2');
                          }
                        }

                        print(
                            '🔍 [OTP_VERIFY] Firebase token received: ${firebaseToken != null ? 'YES' : 'NO'}');

                        if (firebaseToken != null) {
                          print(
                              '🔍 [OTP_VERIFY] Firebase token length: ${firebaseToken.length}');
                          print(
                              '🔍 [OTP_VERIFY] Firebase token preview: ${firebaseToken.substring(0, 50)}...');
                          print(
                              '🔍 [OTP_VERIFY] Full Firebase token: $firebaseToken');
                        } else {
                          print(
                              '🔍 [OTP_VERIFY] ERROR: Firebase token is NULL!');
                        }

                        if (firebaseToken == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Failed to get authentication token')),
                          );
                          return;
                        }

                        // Ensure Firebase authentication state is properly maintained
                        print(
                            '🔍 [OTP_VERIFY] Ensuring Firebase auth state is maintained...');
                        try {
                          // Small delay to ensure Firebase state is updated
                          await Future.delayed(
                              const Duration(milliseconds: 500));

                          // Verify the token is still valid
                          final currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser != null) {
                            final verifiedToken =
                                await currentUser.getIdToken();
                            if (verifiedToken != null) {
                              firebaseToken =
                                  verifiedToken; // Update with fresh token
                              print(
                                  '🔍 [OTP_VERIFY] Firebase auth state verified and token refreshed');
                            }
                          }
                        } catch (e) {
                          print(
                              '🔍 [OTP_VERIFY] Error verifying Firebase auth state: $e');
                        }

                        // Send Firebase token to backend for JWT authentication
                        print(
                            '🔍 [OTP_VERIFY] Sending Firebase token to backend...');

                        if (firebaseToken == null || firebaseToken.isEmpty) {
                          print(
                              '🔍 [OTP_VERIFY] ERROR: Firebase token is null or empty, cannot proceed');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Authentication failed. Please try again.')),
                          );
                          return;
                        }

                        final jwtAuthManager = JwtAuthManager.instance;
                        final jwtResult =
                            await jwtAuthManager.verifyPhoneWithFirebaseToken(
                          phoneNumber: widget.phoneNumber,
                          firebaseToken: firebaseToken,
                        );

                        if (jwtResult != null) {
                          // Check if this is a new user
                          final isNewUser = jwtResult['isNewUser'] ?? false;
                          print('🔍 [OTP_VERIFY] Is new user: $isNewUser');
                          print('🔍 [OTP_VERIFY] Full JWT result: $jwtResult');

                          // Validate required fields for new user
                          if (isNewUser) {
                            final firebaseUid = jwtResult['firebaseUid'];
                            final phoneNumber = jwtResult['phoneNumber'];

                            if (firebaseUid == null || phoneNumber == null) {
                              print(
                                  '🔍 [OTP_VERIFY] ERROR: Missing required fields for new user');
                              print(
                                  '🔍 [OTP_VERIFY] firebaseUid: $firebaseUid');
                              print(
                                  '🔍 [OTP_VERIFY] phoneNumber: $phoneNumber');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Error: Missing user data. Please try again.'),
                                ),
                              );
                              return;
                            }
                          }

                          if (isNewUser) {
                            // New user - navigate to create account with Firebase UID
                            print(
                                '🔍 [OTP_VERIFY] New user detected, navigating to create account');
                            final firebaseUid = jwtResult['firebaseUid'];
                            final phoneNumber = jwtResult['phoneNumber'];

                            print('🔍 [OTP_VERIFY] Firebase UID: $firebaseUid');
                            print('🔍 [OTP_VERIFY] Phone Number: $phoneNumber');
                            print(
                                '🔍 [OTP_VERIFY] Context mounted: ${context.mounted}');

                            // Remove +91 prefix for create account page (should be clean 10 digits)
                            String formattedPhoneNumber =
                                phoneNumber.toString();
                            if (formattedPhoneNumber.startsWith('+91')) {
                              formattedPhoneNumber =
                                  formattedPhoneNumber.substring(3);
                            }
                            print(
                                '🔍 [OTP_VERIFY] Formatted phone number: $formattedPhoneNumber');

                            // For new users, we'll let them be logged in but mark profile as incomplete
                            // This allows them to complete their profile setup
                            print(
                                '🔍 [OTP_VERIFY] New user detected, will mark profile as incomplete after account creation');

                            if (context.mounted) {
                              print(
                                  '🔍 [OTP_VERIFY] Navigating to CreateAnAccount with phone: $formattedPhoneNumber');
                              print(
                                  '🔍 [OTP_VERIFY] Firebase token available: ${firebaseToken != null ? 'YES' : 'NO'}');

                              // Ensure Firebase authentication state is maintained
                              print(
                                  '🔍 [OTP_VERIFY] Firebase token length: ${firebaseToken.length}');
                              print(
                                  '🔍 [OTP_VERIFY] Firebase token preview: ${firebaseToken.substring(0, 50)}...');

                              try {
                                print(
                                    '🔍 [OTP_VERIFY] Attempting navigation with pushNamed...');
                                context.pushNamed(
                                  'CreateAnAccount',
                                  queryParameters: {
                                    'phoneNumber': formattedPhoneNumber,
                                    'firebaseIdToken': firebaseToken,
                                  }.withoutNulls,
                                );
                                print(
                                    '🔍 [OTP_VERIFY] Navigation to CreateAnAccount completed');
                              } catch (e) {
                                print('🔍 [OTP_VERIFY] Navigation error: $e');
                                // Try alternative navigation method
                                try {
                                  print(
                                      '🔍 [OTP_VERIFY] Trying alternative navigation with goNamed...');
                                  context.goNamed(
                                    'CreateAnAccount',
                                    queryParameters: {
                                      'phoneNumber': formattedPhoneNumber,
                                      'firebaseIdToken': firebaseToken,
                                    }.withoutNulls,
                                  );
                                  print(
                                      '🔍 [OTP_VERIFY] Alternative navigation completed');
                                } catch (e2) {
                                  print(
                                      '🔍 [OTP_VERIFY] Alternative navigation also failed: $e2');
                                }
                              }
                            } else {
                              print(
                                  '🔍 [OTP_VERIFY] Context not mounted, cannot navigate');
                            }
                            return;
                          } else {
                            // Existing user - JWT authentication successful (tokens already stored)
                            print(
                                '🔍 [OTP_VERIFY] JWT authentication successful for existing user!');
                            final user = jwtResult['user'];
                            final userId = user?['_id'] ?? '';
                            print('🔍 [OTP_VERIFY] JWT User ID: $userId');

                            FFAppState().userId = userId;
                            FFAppState().update(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Welcome!',
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

                            if (context.mounted) {
                              print(
                                  '🔍 [OTP_VERIFY] Navigating to Homepage after JWT success');
                              context.goNamedAuth('Homepage', context.mounted);
                            }
                            return;
                          }
                        }

                        // If JWT authentication fails, fallback to Firebase-only flow
                        print(
                            '🔍 [OTP_VERIFY] JWT authentication failed, using Firebase fallback...');

                        // Remove +91 prefix for API call (should be clean 10 digits)
                        String rawPhoneNumber = widget.phoneNumber;
                        if (rawPhoneNumber.startsWith('+91')) {
                          rawPhoneNumber = rawPhoneNumber.substring(3);
                        }

                        // Check if user exists in backend
                        final response = await http.post(
                          Uri.parse(
                              'https://indigo-rhapsody-backend-ten.vercel.app/user/check-user-exists'),
                          headers: {'Content-Type': 'application/json'},
                          body: jsonEncode({'phoneNumber': rawPhoneNumber}),
                        );

                        final responseData = jsonDecode(response.body);

                        if (response.statusCode == 200) {
                          final userExists = responseData['success'] == true &&
                              responseData['userId'] != null;

                          if (userExists) {
                            // User exists - proceed with Firebase login
                            _model.readDocument123 =
                                await UsersRecord.getDocumentOnce(
                                    currentUserReference!);
                            FFAppState().userId =
                                valueOrDefault(currentUserDocument?.userId, '');
                            FFAppState().cartId =
                                valueOrDefault(currentUserDocument?.cartId, '');
                            FFAppState().update(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Welcome!',
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

                            if (context.mounted) {
                              context.goNamedAuth('Homepage', context.mounted);
                            }
                          } else {
                            // User doesn't exist - navigate to create account
                            print(
                                '🔍 [OTP_VERIFY] User does not exist, signing out and navigating to create account');
                            await authManager.signOut();
                            if (context.mounted) {
                              context.pushNamed(
                                'CreateAnAccount',
                                queryParameters: {
                                  'phoneNumber': rawPhoneNumber,
                                }.withoutNulls,
                              );
                            }
                          }
                        } else {
                          // Handle non-200 responses
                          await authManager.signOut();
                          if (context.mounted) {
                            context.goNamedAuth(
                              'CreateAnAccount',
                              context.mounted,
                              queryParameters: {
                                'phoneNumber': rawPhoneNumber,
                              }.withoutNulls,
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Error: ${responseData['message'] ?? 'Unknown error'}')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }

                      safeSetState(() {});
                    },
                    text: 'Verify',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: screenSize.height * 0.065,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        21.0,
                        0.0,
                        21.0,
                        0.0,
                      ),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: const Color(0xFFFDFDFD),
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  'Inter',
                                ),
                              ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ).animateOnPageLoad(
                    animationsMap['buttonOnPageLoadAnimation']!,
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
