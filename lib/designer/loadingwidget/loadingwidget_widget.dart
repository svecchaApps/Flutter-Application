import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'loadingwidget_model.dart';
export 'loadingwidget_model.dart';

class LoadingwidgetWidget extends StatefulWidget {
  const LoadingwidgetWidget({super.key});

  @override
  State<LoadingwidgetWidget> createState() => _LoadingwidgetWidgetState();
}

class _LoadingwidgetWidgetState extends State<LoadingwidgetWidget>
    with TickerProviderStateMixin {
  late LoadingwidgetModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingwidgetModel());

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        loop: true,
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
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 100.0,
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      '',
                    ).image,
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: ClipRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 6.0,
                      sigmaY: 6.0,
                    ),
                    child: Transform.rotate(
                      angle: 110.0 * (math.pi / 180),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Image.network(
                          'https://img.freepik.com/free-photo/abstract-background-with-bokeh-lights_53876-120103.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696464000&semt=ais',
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation']!),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
