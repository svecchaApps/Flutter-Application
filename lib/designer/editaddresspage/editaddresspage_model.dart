import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'editaddresspage_widget.dart' show EditaddresspageWidget;
import 'package:flutter/material.dart';

class EditaddresspageModel extends FlutterFlowModel<EditaddresspageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for city widget.
  FocusNode? cityFocusNode1;
  TextEditingController? cityTextController;
  FocusNode? cityFocusNode;

  String? stateValue;
  FormFieldController<String>? stateValueController;
  String? Function(BuildContext, String?)? streetTextControllerValidator;
  TextEditingController? stateTextController;

  TextEditingController? cityTextController1;
  String? Function(BuildContext, String?)? cityTextController1Validator;
  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? streetTextController;
  FocusNode? stateFocusNode;

  String? _streetTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for city widget.
  FocusNode? cityFocusNode2;
  TextEditingController? cityTextController2;
  String? Function(BuildContext, String?)? cityTextController2Validator;
  String? _cityTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for pincode widget.
  FocusNode? pincodeFocusNode;
  TextEditingController? pincodeTextController;
  String? Function(BuildContext, String?)? pincodeTextControllerValidator;
  String? _pincodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for DropDownState widget.
  String? dropDownStateValue;
  FormFieldController<String>? dropDownStateValueController;
  // Stores action output result for [Backend Call - API (updateUserr)] action in Button widget.
  ApiCallResponse? addAddress;

  @override
  void initState(BuildContext context) {
    streetTextControllerValidator = _streetTextControllerValidator;
    cityTextController2Validator = _cityTextController2Validator;
    pincodeTextControllerValidator = _pincodeTextControllerValidator;
  }

  @override
  void dispose() {
    cityFocusNode1?.dispose();
    cityTextController1?.dispose();

    streetFocusNode?.dispose();
    streetTextController?.dispose();

    cityFocusNode2?.dispose();
    cityTextController2?.dispose();

    pincodeFocusNode?.dispose();
    pincodeTextController?.dispose();
  }
}
