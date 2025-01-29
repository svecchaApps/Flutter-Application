import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'products_shimmer_model.dart';
export 'products_shimmer_model.dart';

class ProductsShimmerWidget extends StatefulWidget {
  const ProductsShimmerWidget({super.key});

  @override
  State<ProductsShimmerWidget> createState() => _ProductsShimmerWidgetState();
}

class _ProductsShimmerWidgetState extends State<ProductsShimmerWidget>
    with TickerProviderStateMixin {
  late ProductsShimmerModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductsShimmerModel());

    animationsMap.addAll({
      'imageOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: const Offset(0.0, 200.0),
            end: const Offset(0.0, -200.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 1000.0.ms,
            begin: 0.765,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: const Offset(0.0, 200.0),
            end: const Offset(0.0, -200.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 1000.0.ms,
            begin: 0.765,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: const Offset(0.0, 200.0),
            end: const Offset(0.0, -200.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 1000.0.ms,
            begin: 0.765,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: const Offset(0.0, 200.0),
            end: const Offset(0.0, -200.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 1000.0.ms,
            duration: 1000.0.ms,
            begin: 0.765,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 50.0),
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.63,
        ),
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 2.5,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Transform.rotate(
                  angle: 110.0 * (math.pi / 180),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 10.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            width: 250.0,
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation1']!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 2.5,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Transform.rotate(
                  angle: 110.0 * (math.pi / 180),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 10.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            width: 250.0,
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation2']!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 2.5,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Transform.rotate(
                  angle: 110.0 * (math.pi / 180),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 10.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            width: 250.0,
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation3']!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 2.5,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Transform.rotate(
                  angle: 110.0 * (math.pi / 180),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 10.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            width: 250.0,
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['imageOnPageLoadAnimation4']!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
