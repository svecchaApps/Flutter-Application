import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'otpscreen_widget.dart' show OtpscreenWidget;
import 'package:flutter/material.dart';

class OtpscreenModel extends FlutterFlowModel<OtpscreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Backend Call - API (createUserSigin)] action in Button widget.
  ApiCallResponse? accountcreatedSuccessfully;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
  }
}
