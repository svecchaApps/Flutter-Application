import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indigo_rhapsody_dupli/components/cart_nav_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'product_description_copy_model.dart';

export 'product_description_copy_model.dart';

class ProductDescriptionCopyWidget extends StatefulWidget {
  const ProductDescriptionCopyWidget({
    super.key,
    required this.productId,
    required this.colorId,
  });

  final String? productId;
  final String? colorId;

  @override
  State<ProductDescriptionCopyWidget> createState() =>
      _ProductDescriptionCopyWidgetState();
}

class _ProductDescriptionCopyWidgetState
    extends State<ProductDescriptionCopyWidget> {
  late ProductDescriptionCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDescriptionCopyModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(BackendAPIGroup.getProductBycolorCall.call(
              productId: widget.productId,
              color: widget.colorId,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final productDescriptionCopyGetProductBycolorResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.sizeOf(context).height * 0.07),
              child: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.safePop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: const [
                  CartNavButton(),
                  SizedBox(width: 16),
                ],
                centerTitle: false,
                elevation: 0,
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.78,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.52,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Builder(
                                  builder: (context) {
                                    final data =
                                        BackendAPIGroup.getProductBycolorCall
                                                .variantDataImage(
                                                  productDescriptionCopyGetProductBycolorResponse
                                                      .jsonBody,
                                                )
                                                ?.toList() ??
                                            [];

                                    return SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.52,
                                      child: Stack(
                                        children: [
                                          PageView.builder(
                                            controller: _model
                                                    .pageViewController ??=
                                                PageController(
                                                    initialPage: max(
                                                        0,
                                                        min(1,
                                                            data.length - 1))),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            itemBuilder: (context, dataIndex) {
                                              final dataItem = data[dataIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          FlutterFlowExpandedImageView(
                                                        image: Image.network(
                                                          dataItem,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: dataItem,
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: dataItem,
                                                  transitionOnUserGestures:
                                                      true,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      dataItem,
                                                      width: 300,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 1),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(16, 0, 0, 16),
                                              child: smooth_page_indicator
                                                  .SmoothPageIndicator(
                                                controller: _model
                                                        .pageViewController ??=
                                                    PageController(
                                                        initialPage: max(
                                                            0,
                                                            min(
                                                                1,
                                                                data.length -
                                                                    1))),
                                                count: data.length,
                                                axisDirection: Axis.horizontal,
                                                onDotClicked: (i) async {
                                                  await _model
                                                      .pageViewController!
                                                      .animateToPage(
                                                    i,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease,
                                                  );
                                                  safeSetState(() {});
                                                },
                                                effect: smooth_page_indicator
                                                    .ExpandingDotsEffect(
                                                  expansionFactor: 2,
                                                  spacing: 8,
                                                  radius: 16,
                                                  dotWidth: 8,
                                                  dotHeight: 8,
                                                  dotColor:
                                                      const Color(0xFFC6C7C7),
                                                  activeDotColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  paintStyle:
                                                      PaintingStyle.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 20, 0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      BackendAPIGroup.getProductBycolorCall
                                          .productName(
                                        productDescriptionCopyGetProductBycolorResponse
                                            .jsonBody,
                                      ),
                                      'productName',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: const Color(0xFF232323),
                                          fontSize: 16,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Inter'),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 15, 20, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 20, 20, 0),
                              child: Text(
                                'Select size',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: const Color(0xFF232323),
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Inter'),
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 0),
                              child: Builder(
                                builder: (context) {
                                  final sizes =
                                      BackendAPIGroup.getProductBycolorCall
                                              .variantsizesandprioces(
                                                productDescriptionCopyGetProductBycolorResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(sizes.length,
                                          (sizesIndex) {
                                        final sizesItem = sizes[sizesIndex];
                                        return Align(
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 8, 0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.pageindex = sizesIndex;
                                                _model.size = getJsonField(
                                                  sizesItem,
                                                  r'''$.size''',
                                                ).toString();
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.095,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.058,
                                                decoration: BoxDecoration(
                                                  color: _model.pageindex ==
                                                          sizesIndex
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primary
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .accent4,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0, 0),
                                                      child: Text(
                                                        getJsonField(
                                                          sizesItem,
                                                          r'''$.size''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: _model
                                                                              .pageindex ==
                                                                          sizesIndex
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  fontSize: 10,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          'Inter'),
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0, 5, 0, 0),
                                                      child: Text(
                                                        '₹${getJsonField(
                                                          sizesItem,
                                                          r'''$.price''',
                                                        ).toString()}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: _model
                                                                              .pageindex ==
                                                                          sizesIndex
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  fontSize: 12,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 20, 20, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                    child: Text(
                                      'Description',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: const Color(0xFF232323),
                                            fontSize: 16,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Inter'),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                                child: Text(
                                  valueOrDefault<String>(
                                    BackendAPIGroup.getProductBycolorCall
                                        .description(
                                      productDescriptionCopyGetProductBycolorResponse
                                          .jsonBody,
                                    ),
                                    'product Description',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Fabric:',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Poppins'),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                                child: Text(
                                  valueOrDefault<String>(
                                    BackendAPIGroup.getProductBycolorCall
                                        .fabric(
                                      productDescriptionCopyGetProductBycolorResponse
                                          .jsonBody,
                                    ),
                                    'Product fabric',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 20, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Size and Fit',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Poppins'),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                                child: Text(
                                  valueOrDefault<String>(
                                    BackendAPIGroup.getProductBycolorCall.fit(
                                      productDescriptionCopyGetProductBycolorResponse
                                          .jsonBody,
                                    ),
                                    'product Fit',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 20, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Material & Care',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Poppins'),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      BackendAPIGroup.getProductBycolorCall
                                          .material(
                                        productDescriptionCopyGetProductBycolorResponse
                                            .jsonBody,
                                      ),
                                      'Material',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 12,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 5, 10, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: const BoxDecoration(),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: const BoxDecoration(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.13,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                if (!functions.newCustomFunction4(
                                    BackendAPIGroup.getProductBycolorCall
                                        .wishListedBy(
                                          productDescriptionCopyGetProductBycolorResponse
                                              .jsonBody,
                                        )
                                        ?.toList(),
                                    FFAppState().userId)!)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 10, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _model.colorWishlist =
                                            await BackendAPIGroup
                                                .createWishListCall
                                                .call(
                                          userId: FFAppState().userId,
                                          productId: BackendAPIGroup
                                              .getProductBycolorCall
                                              .productId(
                                            productDescriptionCopyGetProductBycolorResponse
                                                .jsonBody,
                                          ),
                                        );

                                        if ((_model.colorWishlist?.succeeded ??
                                            true)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.colorWishlist
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.message''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.colorWishlist
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.message''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        }

                                        safeSetState(() {});
                                      },
                                      text: 'Wishlist Item',
                                      options: FFButtonOptions(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.45,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.06,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(24, 0, 24, 0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily),
                                            ),
                                        elevation: 3,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                if (functions.newCustomFunction4(
                                        BackendAPIGroup.getProductBycolorCall
                                            .wishListedBy(
                                              productDescriptionCopyGetProductBycolorResponse
                                                  .jsonBody,
                                            )
                                            ?.toList(),
                                        FFAppState().userId) ??
                                    true)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 10, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (currentPhoneNumber != '') {
                                          _model.apiResultdshcopy =
                                              await BackendAPIGroup
                                                  .createWishListCall
                                                  .call(
                                            userId: FFAppState().userId,
                                            productId: widget.productId,
                                          );

                                          if ((_model.apiResultdshcopy
                                                  ?.succeeded ??
                                              true)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultdshcopy
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.message''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                            safeSetState(() => _model
                                                .apiRequestCompleter = null);
                                            await _model
                                                .waitForApiRequestCompleted();
                                            HapticFeedback.mediumImpact();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.apiResultdshcopy
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.message''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                        } else {
                                          context
                                              .pushNamed('LoginMobileScreen');
                                        }

                                        safeSetState(() {});
                                      },
                                      text: 'Added To Wishlist',
                                      options: FFButtonOptions(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.45,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.06,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(24, 0, 24, 0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily),
                                            ),
                                        elevation: 3,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 9, 10, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (currentPhoneNumber != '') {
                                    HapticFeedback.mediumImpact();
                                    _model.apiResult2t4new = await BackendAPIGroup
                                        .createCartandUpdateCartOneFunctionCall
                                        .call(
                                      userId: FFAppState().userId,
                                      productId: BackendAPIGroup
                                          .getProductBycolorCall
                                          .productId(
                                        productDescriptionCopyGetProductBycolorResponse
                                            .jsonBody,
                                      ),
                                      quantity: 1,
                                      size: _model.size,
                                      color: BackendAPIGroup
                                          .getProductBycolorCall
                                          .variantColor(
                                        productDescriptionCopyGetProductBycolorResponse
                                            .jsonBody,
                                      ),
                                      customizations: 'Na',
                                    );

                                    if ((_model.apiResult2t4new?.succeeded ??
                                        true)) {
                                      FFAppState().cartId = BackendAPIGroup
                                          .createCartandUpdateCartOneFunctionCall
                                          .cartId(
                                        (_model.apiResult2t4new?.jsonBody ??
                                            ''),
                                      )!;
                                      safeSetState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            getJsonField(
                                              (_model.apiResult2t4new
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.message''',
                                            ).toString(),
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration: const Duration(
                                              milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else {
                                      // await actions.snackbar(
                                      //   context,
                                      //   getJsonField(
                                      //     (_model.apiResult2t4new?.jsonBody ??
                                      //         ''),
                                      //     r'''$.message''',
                                      //   ).toString(),
                                      // );
                                    }
                                  } else {
                                    context.pushNamed('LoginMobileScreen');
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Add to cart',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.45,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.06,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
