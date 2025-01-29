import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'commenttext_widget.dart' show CommenttextWidget;
import 'package:flutter/material.dart';

class CommenttextModel extends FlutterFlowModel<CommenttextWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (getComment)] action in commenttext widget.
  ApiCallResponse? apiResultwyf;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (createComment)] action in Icon widget.
  ApiCallResponse? apiResultd4a;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
