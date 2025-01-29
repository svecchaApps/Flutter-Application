import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'subcategory_shimmer_model.dart';
export 'subcategory_shimmer_model.dart';

class SubcategoryShimmerWidget extends StatefulWidget {
  const SubcategoryShimmerWidget({super.key});

  @override
  State<SubcategoryShimmerWidget> createState() =>
      _SubcategoryShimmerWidgetState();
}

class _SubcategoryShimmerWidgetState extends State<SubcategoryShimmerWidget>
    with TickerProviderStateMixin {
  late SubcategoryShimmerModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubcategoryShimmerModel());

    animationsMap.addAll({
      'circleImageOnPageLoadAnimation1': AnimationInfo(
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
      'circleImageOnPageLoadAnimation2': AnimationInfo(
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
      'circleImageOnPageLoadAnimation3': AnimationInfo(
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
      'circleImageOnPageLoadAnimation4': AnimationInfo(
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
      'circleImageOnPageLoadAnimation5': AnimationInfo(
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
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 110.0 * (math.pi / 180),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).width * 0.2,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['circleImageOnPageLoadAnimation1']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 110.0 * (math.pi / 180),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).width * 0.2,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['circleImageOnPageLoadAnimation2']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 110.0 * (math.pi / 180),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).width * 0.2,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['circleImageOnPageLoadAnimation3']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 110.0 * (math.pi / 180),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).width * 0.2,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['circleImageOnPageLoadAnimation4']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 110.0 * (math.pi / 180),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).width * 0.2,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                            fit: BoxFit.cover,
                          ),
                        ).animateOnPageLoad(
                            animationsMap['circleImageOnPageLoadAnimation5']!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
