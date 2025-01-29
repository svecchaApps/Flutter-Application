import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'otp_login_widget.dart' show OtpLoginWidget;
import 'package:flutter/material.dart';

class OtpLoginModel extends FlutterFlowModel<OtpLoginWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  UsersRecord? readDocument123;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
  }
}
