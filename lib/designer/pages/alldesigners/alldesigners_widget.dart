import '/backend/api_requests/api_calls.dart';
import '/designer/pages/shimmerproducts/shimmerproducts_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alldesigners_model.dart';
export 'alldesigners_model.dart';

class AlldesignersWidget extends StatefulWidget {
  const AlldesignersWidget({super.key});

  @override
  State<AlldesignersWidget> createState() => _AlldesignersWidgetState();
}

class _AlldesignersWidgetState extends State<AlldesignersWidget> {
  late AlldesignersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlldesignersModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: true,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primary,
              size: 24.0,
            ),
          ),
          title: Text(
            'All Designers',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey('Poppins'),
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 1.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
            child: FutureBuilder<ApiCallResponse>(
              future: BackendAPIGroup.getDesignersCall.call(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return const ShimmerproductsWidget();
                }
                final staggeredViewGetDesignersResponse = snapshot.data!;

                return Builder(
                  builder: (context) {
                    final designer = BackendAPIGroup.getDesignersCall
                            .designerBody(
                              staggeredViewGetDesignersResponse.jsonBody,
                            )
                            ?.toList() ??
                        [];

                    return RefreshIndicator(
                      onRefresh: () async {},
                      child: MasonryGridView.builder(
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 10.0,
                        itemCount: designer.length,
                        itemBuilder: (context, designerIndex) {
                          final designerItem = designer[designerIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'HiddenGems',
                                queryParameters: {
                                  'designerId': serializeParam(
                                    getJsonField(
                                      designerItem,
                                      r'''$._id''',
                                    ).toString(),
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: 100.0,
                              height: 250.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  getJsonField(
                                    designerItem,
                                    r'''$.logoUrl''',
                                  ).toString(),
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
