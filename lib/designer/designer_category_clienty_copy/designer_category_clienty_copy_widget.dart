import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indigo_rhapsody_dupli/components/cart_nav_button.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'designer_category_clienty_copy_model.dart';

export 'designer_category_clienty_copy_model.dart';

class DesignerCategoryClientyCopyWidget extends StatefulWidget {
  const DesignerCategoryClientyCopyWidget({
    super.key,
    required this.categoryref,
  });

  final String? categoryref;

  static String routeName = 'DesignerCategoryClientyCopy';
  static String routePath = '/designerCategoryClientyCopy';

  @override
  State<DesignerCategoryClientyCopyWidget> createState() =>
      _DesignerCategoryClientyCopyWidgetState();
}

class _DesignerCategoryClientyCopyWidgetState
    extends State<DesignerCategoryClientyCopyWidget> {
  late DesignerCategoryClientyCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DesignerCategoryClientyCopyModel());
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              size: 24,
            ),
          ),
          title: Text(
            'Designed For You',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  fontSize: 18,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).bodyMediumFamily),
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(Searchpage1Widget.routeName);
                },
                child: const Icon(
                  FFIcons.ksearch,
                  color: Color(0xFF263F96),
                  size: 24,
                ),
              ),
            ),
            const CartNavButton(),
            const SizedBox(width: 16),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: FutureBuilder<ApiCallResponse>(
              future: BackendAPIGroup.subcategoryByidCall.call(
                categoryId: widget.categoryref,
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                final gridViewSubcategoryByidResponse = snapshot.data!;

                return Builder(
                  builder: (context) {
                    final subcategoryResponse =
                        BackendAPIGroup.subcategoryByidCall
                                .mainBody(
                                  gridViewSubcategoryByidResponse.jsonBody,
                                )
                                ?.toList() ??
                            [];

                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: subcategoryResponse.length,
                      itemBuilder: (context, subcategoryResponseIndex) {
                        final subcategoryResponseItem =
                            subcategoryResponse[subcategoryResponseIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              ProductofdesignerclientCopyCopyWidget.routeName,
                              queryParameters: {
                                'subcategoryid': serializeParam(
                                  getJsonField(
                                    subcategoryResponseItem,
                                    r'''$._id''',
                                  ).toString(),
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.3,
                                  decoration: const BoxDecoration(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 500),
                                      fadeOutDuration:
                                          const Duration(milliseconds: 500),
                                      imageUrl: getJsonField(
                                        subcategoryResponseItem,
                                        r'''$.image''',
                                      ).toString(),
                                      width: MediaQuery.sizeOf(context).width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getJsonField(
                                          subcategoryResponseItem,
                                          r'''$.name''',
                                        ).toString().maybeHandleOverflow(
                                              maxChars: 12,
                                              replacement: '…',
                                            ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              color: Colors.black,
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0, 1),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
