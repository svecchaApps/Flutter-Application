import '/backend/backend.dart';
import '/designer/pages/shimmerproducts/shimmerproducts_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'allbrands_model.dart';
export 'allbrands_model.dart';

class AllbrandsWidget extends StatefulWidget {
  const AllbrandsWidget({super.key});

  @override
  State<AllbrandsWidget> createState() => _AllbrandsWidgetState();
}

class _AllbrandsWidgetState extends State<AllbrandsWidget> {
  late AllbrandsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllbrandsModel());
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
              size: 24.0,
            ),
          ),
          title: Text(
            'All Brands',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey('Poppins'),
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
            child: StreamBuilder<List<DesignerRecord>>(
              stream: queryDesignerRecord(
                queryBuilder: (designerRecord) => designerRecord.where(
                  'isBrand',
                  isEqualTo: true,
                ),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return const ShimmerproductsWidget();
                }
                List<DesignerRecord> staggeredViewDesignerRecordList =
                    snapshot.data!;

                return MasonryGridView.builder(
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 10.0,
                  itemCount: staggeredViewDesignerRecordList.length,
                  itemBuilder: (context, staggeredViewIndex) {
                    final staggeredViewDesignerRecord =
                        staggeredViewDesignerRecordList[staggeredViewIndex];
                    return Container(
                      width: 100.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeOutDuration: const Duration(milliseconds: 500),
                          imageUrl: staggeredViewDesignerRecord.logoUrl,
                          width: 300.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
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
