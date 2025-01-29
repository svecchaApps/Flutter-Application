import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'cart_pagenew_copy_widget.dart' show CartPagenewCopyWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class CartPagenewCopyModel extends FlutterFlowModel<CartPagenewCopyWidget> {
  ///  Local state fields for this page.

  double? totallvalueee;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (updateQuantityForCartItems)] action in Container widget.
  ApiCallResponse? apiResulta4w;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (updateQuantityForCartItems)] action in Container widget.
  ApiCallResponse? apiResulta4wCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
