import '/flutter_flow/flutter_flow_util.dart';
import 'homepage_widget.dart' show HomepageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomepageModel extends FlutterFlowModel<HomepageWidget> {
  ///  Local state fields for this page.

  String sha256 = '';

  int? indexnumbe = 0;

  String? productname;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
