import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'upload_video_widget.dart' show UploadVideoWidget;
import 'package:flutter/material.dart';

class UploadVideoModel extends FlutterFlowModel<UploadVideoWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (createOrUpdateVideo)] action in Button widget.
  ApiCallResponse? apiResult3l1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
