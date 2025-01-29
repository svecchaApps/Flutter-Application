import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'addaddress_page_widget.dart' show AddaddressPageWidget;
import 'package:flutter/material.dart';

class AddaddressPageModel extends FlutterFlowModel<AddaddressPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? cityTextController;
  TextEditingController? streetTextController;

  String? Function(BuildContext, String?)? streetTextControllerValidator;
  FormFieldController<String>? stateValueController;
  String? _streetTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for city widget.
  FocusNode? cityFocusNode1;

  // State field(s) for city widget.
  FocusNode? cityFocusNode2;

  // State field(s) for pincode widget.
  FocusNode? pincodeFocusNode;
  FocusNode? nickNameFocusNode;
  TextEditingController? nickNameTextController;
  TextEditingController? pincodeTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  TextEditingController? stateTextController;
  FocusNode? stateFocusNode;

  String? Function(BuildContext, String?)? pincodeTextControllerValidator;
  String? _pincodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter pincode';
    }

    return null;
  }

  // State field(s) for state widget.
  String? stateValue;
  FocusNode? cityFocusNode;

  // Stores action output result for [Backend Call - API (updateUserr)] action in Button widget.
  ApiCallResponse? addAddress;

  @override
  void initState(BuildContext context) {
    streetTextControllerValidator = _streetTextControllerValidator;

    cityTextControllerValidator = _cityTextControllerValidator;
    pincodeTextControllerValidator = _pincodeTextControllerValidator;
  }

  String? _cityTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter city';
    }

    return null;
  }

  @override
  void dispose() {
    streetFocusNode?.dispose();
    streetTextController?.dispose();

    cityFocusNode1?.dispose();

    cityFocusNode2?.dispose();

    pincodeFocusNode?.dispose();
    pincodeTextController?.dispose();
  }
}
