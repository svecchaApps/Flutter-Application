import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'designer_store_page_widget.dart' show DesignerStorePageWidget;
import 'package:flutter/material.dart';

class DesignerStorePageModel extends FlutterFlowModel<DesignerStorePageWidget> {
  ///  Local state fields for this page.

  String? productname;

  ///  State fields for stateful widgets in this page.

  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (createWishList)] action in Icon widget.
  ApiCallResponse? apiResultdsh;
  // Stores action output result for [Backend Call - API (createWishList)] action in Icon widget.
  ApiCallResponse? apiResultdshcopy;

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
