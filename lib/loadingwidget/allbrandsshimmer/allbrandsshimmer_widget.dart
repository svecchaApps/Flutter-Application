import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'allbrandsshimmer_model.dart';
export 'allbrandsshimmer_model.dart';

class AllbrandsshimmerWidget extends StatefulWidget {
  const AllbrandsshimmerWidget({super.key});

  @override
  State<AllbrandsshimmerWidget> createState() => _AllbrandsshimmerWidgetState();
}

class _AllbrandsshimmerWidgetState extends State<AllbrandsshimmerWidget> {
  late AllbrandsshimmerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllbrandsshimmerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
