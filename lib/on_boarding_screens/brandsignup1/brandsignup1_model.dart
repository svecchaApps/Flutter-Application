import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'brandsignup1_widget.dart' show Brandsignup1Widget;
import 'package:flutter/material.dart';

class Brandsignup1Model extends FlutterFlowModel<Brandsignup1Widget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;

  TextEditingController? stateTextController;
  FocusNode? stateFocusNode;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter name';
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter email';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please provide a valid email';
    }
    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter password';
    }

    if (val.length < 6) {
      return 'Minimum 6 charectors required';
    }

    return null;
  }

  // State field(s) for conpass widget.
  FocusNode? conpassFocusNode;
  TextEditingController? conpassTextController;
  late bool conpassVisibility;
  String? Function(BuildContext, String?)? conpassTextControllerValidator;
  String? _conpassTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please confirm password ';
    }

    if (val.length < 6) {
      return 'Minimum 6 charectors required';
    }

    return null;
  }

  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter phone number';
    }

    if (val.length < 10) {
      return 'Please enter valid phone number';
    }

    return null;
  }

  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? streetTextController;
  String? Function(BuildContext, String?)? streetTextControllerValidator;
  String? _streetTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter street name';
    }

    if (val.length < 10) {
      return 'Requires at least 10 characters.';
    }

    return null;
  }

  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  FocusNode? pincodeFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  String? _cityTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter city name';
    }

    return null;
  }

  // State field(s) for pin widget.
  FocusNode? pinFocusNode;
  TextEditingController? pinTextController;
  String? Function(BuildContext, String?)? pinTextControllerValidator;
  String? _pinTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please enter pincode';
    }

    if (val.length < 6) {
      return 'Please enter valid pincode';
    }
    if (val.length > 6) {
      return 'Maximum 6 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for about widget.
  FocusNode? aboutFocusNode;
  TextEditingController? aboutTextController;
  String? Function(BuildContext, String?)? aboutTextControllerValidator;
  TextEditingController? pincodeTextController;
  String? _aboutTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'please fill the about field';
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please fill the description field';
    }

    return null;
  }

  String? _pincodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter pincode';
    }

    return null;
  }

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';
  String? Function(BuildContext, String?)? pincodeTextControllerValidator;

  // Stores action output result for [Backend Call - API (createDesigneranduser)] action in Button widget.
  ApiCallResponse? createDesigner;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    conpassVisibility = false;
    conpassTextControllerValidator = _conpassTextControllerValidator;
    pincodeTextControllerValidator = _pincodeTextControllerValidator;
    phoneTextControllerValidator = _phoneTextControllerValidator;
    streetTextControllerValidator = _streetTextControllerValidator;
    cityTextControllerValidator = _cityTextControllerValidator;
    pinTextControllerValidator = _pinTextControllerValidator;
    aboutTextControllerValidator = _aboutTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    conpassFocusNode?.dispose();
    conpassTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    streetFocusNode?.dispose();
    streetTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();

    pinFocusNode?.dispose();
    pinTextController?.dispose();

    aboutFocusNode?.dispose();
    aboutTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
