import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product1_model.dart';
export 'product1_model.dart';

class Product1Widget extends StatefulWidget {
  const Product1Widget({super.key});

  @override
  State<Product1Widget> createState() => _Product1WidgetState();
}

class _Product1WidgetState extends State<Product1Widget> {
  late Product1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Product1Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 3.0,
            color: Color(0x32000000),
            offset: Offset(
              0.0,
              1.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(0.0),
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1620917669788-be691b2db72a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDh8fHByb2R1Y3RzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Lora',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey('Lora'),
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        'Size',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w300,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Nunito'),
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 0.0, 0.0),
                      child: Text(
                        'subtext',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
