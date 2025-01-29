import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'product_description_copy_widget.dart' show ProductDescriptionCopyWidget;
import 'package:flutter/material.dart';

class ProductDescriptionCopyModel
    extends FlutterFlowModel<ProductDescriptionCopyWidget> {
  ///  Local state fields for this page.

  int? pageindex;

  String? size;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (createWishList)] action in Icon widget.
  ApiCallResponse? colorWishlist;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (createWishList)] action in Icon widget.
  ApiCallResponse? apiResultdshcopy;
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
