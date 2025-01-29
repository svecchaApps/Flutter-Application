import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'emaillogin_widget.dart' show EmailloginWidget;
import 'package:flutter/material.dart';

class EmailloginModel extends FlutterFlowModel<EmailloginWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  UsersRecord? readDocument;

  @override
  void initState(BuildContext context) {
    emailTextControllerValidator = _emailTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
  }

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    textFieldFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
