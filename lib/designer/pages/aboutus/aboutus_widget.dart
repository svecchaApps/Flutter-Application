import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aboutus_model.dart';
export 'aboutus_model.dart';

class AboutusWidget extends StatefulWidget {
  const AboutusWidget({super.key});

  @override
  State<AboutusWidget> createState() => _AboutusWidgetState();
}

class _AboutusWidgetState extends State<AboutusWidget> {
  late AboutusModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutusModel());
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
            'About Us',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Raleway',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey('Raleway'),
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 20.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          'In the vibrant heart of Bangalore, the Sveccha team embarked on a mission to establish a thriving platform that celebrated the artistry of fashion designers and skilled artisans. However, as they delved deeper into the fashion world and engaged in candid conversations with industry experts, designers, and artisans, an awakening occurred. They realized that their initial vision wasn\'t effectively addressing the profound challenges looming over the fashion industry.\n\nThis pivotal moment triggered a paradigm shift, steering them towards a more significant and urgent goal: sustainability. Acknowledging the pressing environmental issues, Sveccha made a conscientious pivot. They transformed from being a mere marketplace into a discerning curator of both fashion designer apparel and sustainable products, masterfully striking a balance between the two.\n\nThey recognize that perfection may be a distant horizon, but their commitment is resolute. Sveccha has seamlessly integrated fashion designer apparel with sustainable goods, creating an oasis for conscious consumers. Sveccha is not just a place to shop; it\'s a movement that promotes responsible consumerism and supports fashion innovation that doesn\'t harm the planet. We believe that the future of fashion is sustainable, and we\'re here to lead the way. In an industry where achieving 100% sustainability remains an elusive aspiration, Sveccha stands as a shining example of taking one step at a time towards the ultimate goal of sustainability.\n',
                          textAlign: TextAlign.justify,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Raleway',
                                color: Colors.black,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Raleway'),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
