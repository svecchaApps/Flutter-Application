import '/flutter_flow/flutter_flow_util.dart';
import 'login_mobile_screen_widget.dart' show LoginMobileScreenWidget;
import 'package:flutter/material.dart';

class LoginMobileScreenModel extends FlutterFlowModel<LoginMobileScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
