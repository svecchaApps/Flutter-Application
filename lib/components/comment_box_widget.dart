import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'comment_box_model.dart';
export 'comment_box_model.dart';

class CommentBoxWidget extends StatefulWidget {
  const CommentBoxWidget({
    super.key,
    this.videoId,
  });

  final String? videoId;

  @override
  State<CommentBoxWidget> createState() => _CommentBoxWidgetState();
}

class _CommentBoxWidgetState extends State<CommentBoxWidget> {
  late CommentBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentBoxModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: BackendAPIGroup.getCommentCall.call(
        videoId: widget.videoId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        final containerGetCommentResponse = snapshot.data!;

        return Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 8.0,
                color: Color(0x33000000),
                offset: Offset(
                  0.0,
                  -4.0,
                ),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(1.0, -1.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 26.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        8.0, 0.0, 8.0, 0.0),
                    child: Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        8.0, 0.0, 8.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join the conversation',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ].divide(const SizedBox(height: 8.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        8.0, 0.0, 8.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final bodyy = BackendAPIGroup.getCommentCall
                                .body(
                                  containerGetCommentResponse.jsonBody,
                                )
                                ?.toList() ??
                            [];

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: bodyy.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16.0),
                          itemBuilder: (context, bodyyIndex) {
                            final bodyyItem = bodyy[bodyyIndex];
                            final userName = getJsonField(
                              bodyyItem,
                              r'''$.*.displayName''',
                            ).toString();
                            final commentDateTime =
                                DateTime.tryParse(bodyyItem['createdAt'])
                                    ?.toLocal();

                            final timestamp = (commentDateTime != null)
                                ? DateFormat(((commentDateTime
                                                .difference(DateTime.now())
                                                .inDays) >
                                            1)
                                        ? "hh:mma 'on' dd-MM-yyyy"
                                        : "hh:mma")
                                    .format(commentDateTime)
                                : '';

                            return Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .accent2,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          userName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 10.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                        ),
                                      ),
                                      Text(
                                        '  •  $timestamp',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 10.0,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    getJsonField(
                                      bodyyItem,
                                      r'''$.commentText''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ].divide(const SizedBox(height: 16.0)),
              ),
            ),
          ),
        );
      },
    );
  }
}
