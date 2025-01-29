import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'newproductcomponent_model.dart';
export 'newproductcomponent_model.dart';

class NewproductcomponentWidget extends StatefulWidget {
  const NewproductcomponentWidget({super.key});

  @override
  State<NewproductcomponentWidget> createState() =>
      _NewproductcomponentWidgetState();
}

class _NewproductcomponentWidgetState extends State<NewproductcomponentWidget> {
  late NewproductcomponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewproductcomponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsRow>>(
      future: ProductsTable().queryRows(
        queryFn: (q) => q,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        List<ProductsRow> containerProductsRowList = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
