import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'approval_copy_model.dart';
export 'approval_copy_model.dart';

class ApprovalCopyWidget extends StatefulWidget {
  const ApprovalCopyWidget({super.key});

  @override
  State<ApprovalCopyWidget> createState() => _ApprovalCopyWidgetState();
}

class _ApprovalCopyWidgetState extends State<ApprovalCopyWidget> {
  late ApprovalCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApprovalCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: const Text('Welcome'),
            content: const Text('Scroll down and agree to terms'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: true,
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
              color: FlutterFlowTheme.of(context).primary,
              size: 24.0,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0, 10.0, 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 10.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Agree to Our Terms',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 10.0, 10.0, 10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Text(
                        '1. Introduction\n\n1.1 Welcome to Sveccha.in (\"the Website\"). These Terms and Conditions (\"Terms\") govern your use of the Website and the services offered by Sveccha.\n\n1.2 By accessing and using the Website, you agree to be bound by these Terms. \n\n1.3 Except where additional terms and conditions are provided, which are product specific, these Terms shall supersede all previous representations, understandings, arrangements or agreements.\n\n1.4 If you have any queries about the Terms, various policies or have any comments, suggestions or grievances on or about our Website, please mail us your query at contact@sveccha.in\n\n2. Account Registration\n\n2.1 To use certain features of the Website, you may be required to create an account. You must provide accurate and complete information during the registration process.\n\n2.2 You are responsible for maintaining the confidentiality of your account and password. Any actions taken using your account will be your responsibility.\n\n3. Product Listings\n\n3.1 Sveccha provides a platform for artisans and designers to list their products in the fashion, accessories, jewelry, and decor categories.\n\n3.2 Sveccha reserves the right to modify or update these Terms including any policy at any time without prior notice. Access to Website after any modification or revision of these Terms or any policy/policies shall also constitute your acceptance to be bound by such modified Terms or any policy/policies. If required by any Indian laws, the modified or revised Terms or any policy/policies shall be applicable to any products purchased prior to such modification or revision becoming effective.\n\n4. Ordering and Payments\n\n4.1 When you place an order through the Website or mobile application, all payments will be processed by Sveccha.\n\n4.2 The Financial Information collected from the Users is transacted through secure digital platforms of approved payment gateways that are under encryption, thereby complying with reasonably expected technology standards. While the Platform shall make reasonable endeavors to ensure that the User’s personal information and the Financial Information are duly protected by security measures prescribed under applicable laws, the User is strongly advised to exercise discretion while providing personal information or Financial Information while using the Services given that the Internet is susceptible to security breaches.\n\n4.2 Sveccha may charge a service fee for processing transactions. The fees are clearly outlined during the checkout process.\n\n4.4 The products listed on this platform may have human errors and Sveccha reserves the right to making corrective action at any point in time, without prior notice. Errors may be subject to product details, availability, pricing, available variations, etc. and we shall have the right to terminate any orders involving pricing errors or inaccuracies.\n\n5. User Conduct\n\n5.1 You agree to use the Website for lawful and non-commercial purposes only. You must not violate any applicable laws, rules, or regulations.\n\n5.2 You must not engage in any activity that may harm the integrity and security of the Website.\n\n6. Intellectual Property\n\n6.1 All content on the Website, including text, images, logos, and trademarks, is the intellectual property of Sveccha or its sellers and is protected by copyright and trademark laws. You shall not use any intellectual property of Sveccha or Svecha’s licensor/seller in any manner without prior written permission from Sveccha or from the respective licensor.\n\n6.2 You may not use or reproduce any content from the Website without explicit permission from Sveccha.\n\n\n7. Order Cancellation\n\n7.1 If you wish to cancel your order, write to us within 24 hours of placing the order at contact@sveccha.in\n\n8. Limitation of Liability\n\n8.1 Sveccha is not responsible for any direct, indirect, or consequential damages, including loss of profits, arising from the use of the Website or the products listed on it.\n\n9. Termination\n\n9.1 Sveccha reserves the right to terminate or suspend your account or access to the Website at its discretion.\n\n10. Changes to Terms\n\n10.1 Sveccha may modify these Terms from time to time. Any changes will be effective upon posting on the Website.\n\n11. Contact\n\n11.1 If you have any questions or concerns regarding these Terms or the Website, please contact us at contact@sveccha.in\n\nBy using Sveccha.in or any of its mobile apps or computer resources, you acknowledge that you have read, understood, and agree to these Terms and Conditions.\n\nShipping, Returns, and Refund\n\n1. Shipping and delivery terms are determined by the individual sellers. Check each product listing for shipping information and return policies.\n\n2. Sveccha will assist in connecting (through electronic medium/telephone) the user and seller in case of any issues related to shipping, returns, or product quality.\n\n3. At the time of delivery, in case the outer packaging of your shipment is tampered/damaged/torn/pressed/disturbed, please refuse to accept the shipment. In case you have not received the your shipment but your tracking status says delivered, please raise a delivery dispute by using the email contact@sveccha.in within 24hours from the time of delivery.\n\n4. Returns/exchanges are accepted only if they are initiated within 3 days from the date of delivery. To initiate a return email us your concern at contact@sveccha.in. Once the email is received, we review the issue and guide you accordingly. \n\nPlease note, products sent to us without a prior email will not be accepted. If the products are received in a condition that is not sellable, used or physically damaged, has missing parts or accessories, they will not be accepted. The cost of any exchange is to be borne by the customer.\n\n5. If eligible, a refund is processed to the original payment source within 7-9 working days after we receive the product. In the case of COD payments, your amount will be credited to you in the form of store credit within 3-5 working days after we receive the product.\n\nPrivacy\n\n1. Sveccha\'s Privacy Policy governs the collection and use of personal information on the Website. By using the Website, you agree to the terms of the Privacy Policy.\n\n2. By accessing the Website or sharing information on the Website, you permit Sveccha to use your information including personal or sensitive personal data/information (“Information”) as provided or may be provided to Sveccha and stored by the Website in electronic medium in connection with your visiting the Website or ordering products made available on the Website, etc. It is further clarified that the term “Information” shall also include any information made available to us by you at the time of registration, buying or listing process, in the feedback area, blog area or through any email feature or a written letter or form mailed or submitted to any of our Stores and/or Offices. We will protect your Information in accordance with our Privacy Policy.\n\n3. By accessing the Website or purchasing products from the Website through any computer resource including but not limited to mobile or tablet devices, you agree that you have read and understood the Privacy Policy. You further consent that the terms and contents of such Privacy Policy are entirely acceptable to you.\n\n4. Sveccha may be required to disclose personal information or Financial Information to governmental institutions or authorities when such disclosure is requisitioned under any law or judicial decree or when the platform, in its sole discretion, deems it necessary in order to protect its rights or the rights of others, to prevent harm to persons or property, to fight fraud and credit risk, or to enforce or apply the Terms of Use.\n',
                        textAlign: TextAlign.justify,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Raleway',
                              color: Colors.black,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Raleway'),
                            ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(width: 8),
                      Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          unselectedWidgetColor:
                              FlutterFlowTheme.of(context).secondaryText,
                        ),
                        child: Checkbox(
                          value: _model.checkboxValue ??= false,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue = newValue!);
                          },
                          side: BorderSide(
                            width: 2,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          activeColor: FlutterFlowTheme.of(context).primary,
                          checkColor: FlutterFlowTheme.of(context).info,
                        ),
                      ),
                      Text(
                        'Agree to terms and Conditions',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 12.0, 10.0, 20.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_model.checkboxValue == true) {
                          context.pushNamed('Brandsignup1');
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Alert'),
                                content: const Text('Please confirm Approval'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      text: 'Let\'s Start',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
