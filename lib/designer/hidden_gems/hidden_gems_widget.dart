import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hidden_gems_model.dart';
export 'hidden_gems_model.dart';

class HiddenGemsWidget extends StatefulWidget {
  const HiddenGemsWidget({
    super.key,
    required this.designerId,
  });

  final String? designerId;

  @override
  State<HiddenGemsWidget> createState() => _HiddenGemsWidgetState();
}

class _HiddenGemsWidgetState extends State<HiddenGemsWidget> {
  late HiddenGemsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HiddenGemsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: BackendAPIGroup.getDesignerByidCall.call(
        designerId: widget.designerId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final hiddenGemsGetDesignerByidResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(
                    BackendAPIGroup.getDesignerByidCall.backGroundImage(
                      hiddenGemsGetDesignerByidResponse.jsonBody,
                    )!,
                  ).image,
                ),
                gradient: const LinearGradient(
                  colors: [Color(0x0D1634AF), Color(0x263F961A), Colors.black],
                  stops: [0.1, 0.68, 1.0],
                  begin: AlignmentDirectional(-1.0, -1.0),
                  end: AlignmentDirectional(1.0, 1.0),
                ),
              ),
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x263F961A),
                      Color(0x0D1634AF),
                      Colors.black
                    ],
                    stops: [0.1, 0.3, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0x2214181B),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 60.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                icon: const Icon(
                                  Icons.chevron_left_rounded,
                                  color: Color(0xFF263F96),
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  context.safePop();
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 25.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.14,
                                height: MediaQuery.sizeOf(context).width * 0.14,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.network(
                                    BackendAPIGroup.getDesignerByidCall.logo(
                                      hiddenGemsGetDesignerByidResponse
                                          .jsonBody,
                                    )!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    BackendAPIGroup.getDesignerByidCall
                                        .displayName(
                                      hiddenGemsGetDesignerByidResponse
                                          .jsonBody,
                                    ),
                                    'display name',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 30.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey('Inter'),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 20.0, 40.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            decoration: const BoxDecoration(),
                            child: Text(
                              valueOrDefault<String>(
                                BackendAPIGroup.getDesignerByidCall.description(
                                  hiddenGemsGetDesignerByidResponse.jsonBody,
                                ),
                                'description',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 22.0,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Inter'),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 10.0, 20.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                'DesignerStorePage',
                                queryParameters: {
                                  'designerref': serializeParam(
                                    widget.designerId,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );

                              FFAppState().categoryFilter = '';
                              safeSetState(() {});
                            },
                            text: 'Go to Collection',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.065,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0xFF323FA4),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Inter'),
                                  ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
