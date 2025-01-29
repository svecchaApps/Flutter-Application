import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'returnexchange_page_widget.dart' show ReturnexchangePageWidget;
import 'package:flutter/material.dart';

class ReturnexchangePageModel
    extends FlutterFlowModel<ReturnexchangePageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // State field(s) for problem widget.
  FocusNode? problemFocusNode;
  TextEditingController? problemTextController;
  String? Function(BuildContext, String?)? problemTextControllerValidator;
  String? _problemTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please explain the problem';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (createReturnRequest)] action in Button widget.
  ApiCallResponse? createRequest;

  @override
  void initState(BuildContext context) {
    problemTextControllerValidator = _problemTextControllerValidator;
  }

  @override
  void dispose() {
    problemFocusNode?.dispose();
    problemTextController?.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
