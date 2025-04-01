import 'package:flutter/material.dart';

// State field(s) for TextField widget.
final textFieldKey = GlobalKey();
FocusNode? textFieldFocusNode;
TextEditingController? textController;
String? textFieldSelectedOption;
String? Function(BuildContext, String?)? textControllerValidator;

@override
void initState(BuildContext context) {}

@override
void dispose() {
  textFieldFocusNode?.dispose();
}
