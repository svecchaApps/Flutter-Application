import 'dart:async';

import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'product_description_widget.dart' show ProductDescriptionWidget;

class ProductDescriptionModel
    extends FlutterFlowModel<ProductDescriptionWidget> {
  ///  Local state fields for this page.

  int? pageindex;

  String? size;

  String? price;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (createWishList)] action in Button widget.
  ApiCallResponse? apiResultdshcopyCopy;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (createWishList)] action in Button widget.
  ApiCallResponse? apiResultdshcopyCopy1;
  // Stores action output result for [Backend Call - API (createCartandUpdateCartOneFunction)] action in Button widget.
  ApiCallResponse? apiResult2t4new;

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
