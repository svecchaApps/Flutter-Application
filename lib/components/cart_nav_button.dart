import 'package:flutter/material.dart';
import 'package:indigo_rhapsody_dupli/cart_pagenew_copy/cart_pagenew_copy_widget.dart';
import 'package:indigo_rhapsody_dupli/flutter_flow/flutter_flow_icon_button.dart';
import 'package:indigo_rhapsody_dupli/flutter_flow/flutter_flow_util.dart';

class CartNavButton extends StatelessWidget {
  const CartNavButton({super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 40,
          fillColor: const Color(0xFFE0E6ED),
          icon: const Icon(
            FFIcons.kshoppingBag,
            color: Color(0xFF263F96),
            size: 24,
          ),
          onPressed: () async {
            context.pushNamed(CartPagenewCopyWidget.routeName);
          },
        ),
        // if (response != null &&
        //     getJsonField(
        //           response.jsonBody,
        //           r'''$.*.products''',
        //         ) !=
        //         null)
        //   Container(
        //     decoration: const BoxDecoration(
        //       color: Colors.indigo,
        //       shape: BoxShape.circle,
        //     ),
        //     padding: const EdgeInsets.all(4),
        //     child: Text(
        //       '${BackendAPIGroup.getCartForUserCall.cartItems(
        //             response.jsonBody,
        //           )?.toList().length}',
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
