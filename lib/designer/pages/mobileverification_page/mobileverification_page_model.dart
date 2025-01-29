import '/flutter_flow/flutter_flow_util.dart';
import 'mobileverification_page_widget.dart' show MobileverificationPageWidget;
import 'package:flutter/material.dart';

class MobileverificationPageModel
    extends FlutterFlowModel<MobileverificationPageWidget> {
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
