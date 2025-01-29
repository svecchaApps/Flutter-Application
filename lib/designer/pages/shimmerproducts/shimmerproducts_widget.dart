import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'shimmerproducts_model.dart';
export 'shimmerproducts_model.dart';

class ShimmerproductsWidget extends StatefulWidget {
  const ShimmerproductsWidget({super.key});

  @override
  State<ShimmerproductsWidget> createState() => _ShimmerproductsWidgetState();
}

class _ShimmerproductsWidgetState extends State<ShimmerproductsWidget> {
  late ShimmerproductsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShimmerproductsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://lottie.host/a7457564-698f-4348-a245-dc2a12411c80/NxST2Ts6NG.json',
            width: 150.0,
            height: 130.0,
            fit: BoxFit.contain,
            animate: true,
          ),
        ],
      ),
    );
  }
}
