import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'client_fav_widget.dart' show ClientFavWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class ClientFavModel extends FlutterFlowModel<ClientFavWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (createWishList)] action in Icon widget.
  ApiCallResponse? wishlist;
  Completer<ApiCallResponse>? apiRequestCompleter;

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
