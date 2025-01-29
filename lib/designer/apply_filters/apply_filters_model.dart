import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'apply_filters_widget.dart' show ApplyFiltersWidget;
import 'package:flutter/material.dart';

class ApplyFiltersModel extends FlutterFlowModel<ApplyFiltersWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController1;
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController2;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get radioButtonValue1 => radioButtonValueController1?.value;
  String? get radioButtonValue2 => radioButtonValueController2?.value;
  String? get radioButtonValue3 => radioButtonValueController3?.value;
}
