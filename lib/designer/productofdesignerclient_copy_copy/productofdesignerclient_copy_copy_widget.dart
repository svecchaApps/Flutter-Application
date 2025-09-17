import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'productofdesignerclient_copy_copy_model.dart';

export 'productofdesignerclient_copy_copy_model.dart';

class ProductofdesignerclientCopyCopyWidget extends StatefulWidget {
  const ProductofdesignerclientCopyCopyWidget({
    super.key,
    this.subcategoryid,
  });

  final String? subcategoryid;

  static String routeName = 'ProductofdesignerclientCopyCopy';
  static String routePath = '/productofdesignerclientCopyCopy';

  @override
  State<ProductofdesignerclientCopyCopyWidget> createState() =>
      _ProductofdesignerclientCopyCopyWidgetState();
}

class _ProductofdesignerclientCopyCopyWidgetState
    extends State<ProductofdesignerclientCopyCopyWidget>
    with TickerProviderStateMixin {
  late ProductofdesignerclientCopyCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  // Filter state variables
  String _selectedSort = '';
  String _selectedColor = '';
  List<String> _availableColors = [];
  List<dynamic> _originalProducts = [];
  List<dynamic> _filteredProducts = [];

  // Wishlist state management
  final Set<String> _wishlistedProducts = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductofdesignerclientCopyCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FlipEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 2.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  // Filter methods
  void _applyFilters() {
    _filteredProducts = List.from(_originalProducts);

    // Apply color filter
    if (_selectedColor.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        final productColor =
            getJsonField(product, r'''$.color''')?.toString().toLowerCase() ??
                '';
        return productColor.contains(_selectedColor.toLowerCase());
      }).toList();
    }

    // Apply sort filter
    if (_selectedSort.isNotEmpty) {
      switch (_selectedSort) {
        case 'price_low_to_high':
          _filteredProducts.sort((a, b) {
            final priceA = double.tryParse(
                    getJsonField(a, r'''$.price''')?.toString() ?? '0') ??
                0;
            final priceB = double.tryParse(
                    getJsonField(b, r'''$.price''')?.toString() ?? '0') ??
                0;
            return priceA.compareTo(priceB);
          });
          break;
        case 'price_high_to_low':
          _filteredProducts.sort((a, b) {
            final priceA = double.tryParse(
                    getJsonField(a, r'''$.price''')?.toString() ?? '0') ??
                0;
            final priceB = double.tryParse(
                    getJsonField(b, r'''$.price''')?.toString() ?? '0') ??
                0;
            return priceB.compareTo(priceA);
          });
          break;
        case 'name_a_to_z':
          _filteredProducts.sort((a, b) {
            final nameA =
                getJsonField(a, r'''$.productName''')?.toString() ?? '';
            final nameB =
                getJsonField(b, r'''$.productName''')?.toString() ?? '';
            return nameA.compareTo(nameB);
          });
          break;
        case 'name_z_to_a':
          _filteredProducts.sort((a, b) {
            final nameA =
                getJsonField(a, r'''$.productName''')?.toString() ?? '';
            final nameB =
                getJsonField(b, r'''$.productName''')?.toString() ?? '';
            return nameB.compareTo(nameA);
          });
          break;
      }
    }

    setState(() {});
  }

  void _extractColors(List<dynamic> products) {
    final colorSet = <String>{};
    for (final product in products) {
      final color = getJsonField(product, r'''$.color''')?.toString();
      if (color != null && color.isNotEmpty) {
        colorSet.add(color);
      }
    }
    _availableColors = colorSet.toList()..sort();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(
                'Filter Products',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
                    ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sort Section
                    Text(
                      'Sort By',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildFilterChip(
                          'Price: Low to High',
                          'price_low_to_high',
                          _selectedSort,
                          (value) {
                            setDialogState(() {
                              _selectedSort = value;
                            });
                          },
                        ),
                        _buildFilterChip(
                          'Price: High to Low',
                          'price_high_to_low',
                          _selectedSort,
                          (value) {
                            setDialogState(() {
                              _selectedSort = value;
                            });
                          },
                        ),
                        _buildFilterChip(
                          'Name: A to Z',
                          'name_a_to_z',
                          _selectedSort,
                          (value) {
                            setDialogState(() {
                              _selectedSort = value;
                            });
                          },
                        ),
                        _buildFilterChip(
                          'Name: Z to A',
                          'name_z_to_a',
                          _selectedSort,
                          (value) {
                            setDialogState(() {
                              _selectedSort = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Color Section
                    Text(
                      'Filter by Color',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildFilterChip(
                          'All Colors',
                          '',
                          _selectedColor,
                          (value) {
                            setDialogState(() {
                              _selectedColor = value;
                            });
                          },
                        ),
                        ..._availableColors.map((color) => _buildFilterChip(
                              color,
                              color,
                              _selectedColor,
                              (value) {
                                setDialogState(() {
                                  _selectedColor = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: Colors.grey.shade600,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setDialogState(() {
                      _selectedSort = '';
                      _selectedColor = '';
                    });
                  },
                  child: Text(
                    'Clear All',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: Colors.red.shade600,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _applyFilters();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Inter'),
                        ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue,
      Function(String) onTap) {
    final isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? FlutterFlowTheme.of(context).primary
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Inter',
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                useGoogleFonts: GoogleFonts.asMap().containsKey('Inter'),
              ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // Responsive helper methods
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 3; // Large tablets and desktops
    if (width > 600) return 2; // Tablets and phones
    return 2; // Small phones - always 2 columns
  }

  double _getSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 12.0; // Large screens
    if (width > 600) return 8.0; // Tablets
    return 6.0; // Small phones
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 0.65; // Large screens - shorter cards
    if (width > 600) return 0.7; // Tablets
    return 0.75; // Small phones - compact cards
  }

  double _getImageHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (width > 900) return height * 0.18; // Large screens
    if (width > 600) return height * 0.20; // Tablets
    return height * 0.22; // Small phones
  }

  double _getProductNameFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 13.0; // Large screens
    if (width > 600) return 12.0; // Tablets
    return 11.0; // Small phones
  }

  double _getPriceFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 15.0; // Large screens
    if (width > 600) return 14.0; // Tablets
    return 13.0; // Small phones
  }

  double _getContentPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 10.0; // Large screens
    if (width > 600) return 8.0; // Tablets
    return 6.0; // Small phones
  }

  double _getCardBorderRadius(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 10.0; // Large screens
    if (width > 600) return 8.0; // Tablets
    return 6.0; // Small phones
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    bool isProductWishlisted(dynamic product, String userId) {
      final productId = getJsonField(product, r'''$._id''')?.toString() ?? '';
      // Check local state first, then fall back to API data
      if (_wishlistedProducts.contains(productId)) {
        return true;
      }
      final wishlistedBy =
          getJsonField(product, r'''$.wishlistedBy''') as List?;
      return wishlistedBy?.contains(userId) ?? false;
    }

    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(BackendAPIGroup.getProductsBySubcategoryCall.call(
              subcategoryId: widget.subcategoryid,
              color: FFAppState().color,
              minPrice: FFAppState().min,
              maxPrice: FFAppState().max,
              fit: FFAppState().fit,
              sort: FFAppState().sort,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        final productofdesignerclientCopyCopyGetProductsBySubcategoryResponse =
            snapshot.data!;

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
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Icons.chevron_left,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24,
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      height: MediaQuery.sizeOf(context).width * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _showFilterDialog();
                        },
                        child: const Icon(
                          FFIcons.kparams,
                          color: Color(0xFF263F96),
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().max = '';
                        FFAppState().fit = '';
                        FFAppState().color = '';
                        FFAppState().sort = '';
                        safeSetState(() {});
                        safeSetState(() => _model.apiRequestCompleter = null);
                        await _model.waitForApiRequestCompleted();
                      },
                      child: const Icon(
                        Icons.close_sharp,
                        color: Color(0x6D04137B),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0,
            ),
            body: SafeArea(
                top: true,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    MediaQuery.sizeOf(context).width > 600 ? 20 : 10,
                    15,
                    MediaQuery.sizeOf(context).width > 600 ? 20 : 10,
                    50,
                  ),
                  child: FutureBuilder<ApiCallResponse>(
                      future: BackendAPIGroup.wishlistCall.call(
                        userId: FFAppState().userId,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final gridViewWishlistResponse = snapshot.data!;

                        return Builder(builder: (context) {
                          final productBody =
                              BackendAPIGroup.getProductsBySubcategoryCall
                                      .pRODUCTbODY(
                                        productofdesignerclientCopyCopyGetProductsBySubcategoryResponse
                                            .jsonBody,
                                      )
                                      ?.toList() ??
                                  [];

                          // Initialize original products and extract colors on first load
                          if (_originalProducts.isEmpty &&
                              productBody.isNotEmpty) {
                            _originalProducts = List.from(productBody);
                            _filteredProducts = List.from(productBody);
                            _extractColors(productBody);

                            // Initialize wishlist state from API data
                            _wishlistedProducts.clear();
                            for (final product in productBody) {
                              final productId =
                                  getJsonField(product, r'''$._id''')
                                          ?.toString() ??
                                      '';
                              final wishlistedBy =
                                  getJsonField(product, r'''$.wishlistedBy''')
                                      as List?;
                              if (wishlistedBy?.contains(FFAppState().userId) ==
                                  true) {
                                _wishlistedProducts.add(productId);
                              }
                            }
                          }

                          // Use filtered products if available, otherwise use original
                          final displayProducts = _filteredProducts.isNotEmpty
                              ? _filteredProducts
                              : productBody;

                          return SingleChildScrollView(
                            child: Column(children: [
                              // Filter indicator
                              if (_selectedSort.isNotEmpty ||
                                  _selectedColor.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primary
                                          .withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.filter_list,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '${displayProducts.length} products found',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey('Inter'),
                                              ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedSort = '';
                                            _selectedColor = '';
                                            _filteredProducts =
                                                List.from(_originalProducts);
                                          });
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              RefreshIndicator(
                                onRefresh: () async {},
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _getCrossAxisCount(context),
                                    crossAxisSpacing: _getSpacing(context),
                                    mainAxisSpacing: _getSpacing(context),
                                    childAspectRatio:
                                        _getChildAspectRatio(context),
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: displayProducts.length,
                                  itemBuilder: (context, productBodyIndex) {
                                    final productBodyItem =
                                        displayProducts[productBodyIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescriptionColorWidget(
                                              productId: productBodyItem['_id']
                                                  .toString(),
                                              price: productBodyItem['price']
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                        // context.pushNamed(
                                        //   ProductDescriptionColorWidget
                                        //       .routeName,
                                        //   queryParameters: {
                                        //     'productId': serializeParam(
                                        //       getJsonField(
                                        //         productBodyItem,
                                        //         r'''$._id''',
                                        //       ).toString(),
                                        //       ParamType.String,
                                        //     ),
                                        //     'price': serializeParam(
                                        //       getJsonField(
                                        //         productBodyItem,
                                        //         r'''$.price''',
                                        //       ).toString,
                                        //       ParamType.String,
                                        //     ),
                                        //   }.withoutNulls,
                                        // );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.grey.shade100,
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Image Container with Badges
                                            Container(
                                              width: double.infinity,
                                              height: _getImageHeight(context),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade50,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                    ),
                                                    child: Image.network(
                                                      getJsonField(
                                                        productBodyItem,
                                                        r'''$.coverImage''',
                                                      ).toString(),
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          color: Colors
                                                              .grey.shade100,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              color: Colors.grey
                                                                  .shade400,
                                                              size: 32,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Wishlist Button
                                                  Positioned(
                                                    top: 8,
                                                    right: 8,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 4,
                                                            offset:
                                                                const Offset(
                                                                    0, 1),
                                                          ),
                                                        ],
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          final userId =
                                                              FFAppState()
                                                                  .userId;
                                                          final productId =
                                                              getJsonField(
                                                                      productBodyItem,
                                                                      r'''$._id''')
                                                                  .toString();
                                                          final isWishlisted =
                                                              isProductWishlisted(
                                                                  productBodyItem,
                                                                  userId);

                                                          final response =
                                                              await BackendAPIGroup
                                                                  .createWishListCall
                                                                  .call(
                                                            userId: userId,
                                                            productId:
                                                                productId,
                                                          );

                                                          if ((response
                                                                  .succeeded ??
                                                              false)) {
                                                            final message =
                                                                getJsonField(
                                                                        response.jsonBody ??
                                                                            {},
                                                                        r'''$.message''')
                                                                    .toString();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content:
                                                                  Text(message),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          4000),
                                                            ));

                                                            // Update local wishlist state
                                                            setState(() {
                                                              if (isWishlisted) {
                                                                _wishlistedProducts
                                                                    .remove(
                                                                        productId);
                                                              } else {
                                                                _wishlistedProducts
                                                                    .add(
                                                                        productId);
                                                              }
                                                            });

                                                            if (animationsMap[
                                                                    'iconOnActionTriggerAnimation'] !=
                                                                null) {
                                                              await animationsMap[
                                                                      'iconOnActionTriggerAnimation']!
                                                                  .controller
                                                                  .forward(
                                                                      from:
                                                                          0.0);
                                                            }
                                                            HapticFeedback
                                                                .mediumImpact();
                                                          } else {
                                                            // Show error message if API call fails
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: const Text(
                                                                  'Failed to update wishlist. Please try again.'),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          4000),
                                                            ));
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Icon(
                                                            Icons.favorite,
                                                            color: isProductWishlisted(
                                                                    productBodyItem,
                                                                    FFAppState()
                                                                        .userId)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .error
                                                                : Colors.grey
                                                                    .shade400,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ).animateOnActionTrigger(
                                                        animationsMap[
                                                            'iconOnActionTriggerAnimation']!,
                                                      ),
                                                    ),
                                                  ),
                                                  // Product Badge (if available)
                                                  if (getJsonField(
                                                          productBodyItem,
                                                          r'''$.badge''') !=
                                                      null)
                                                    Positioned(
                                                      top: 8,
                                                      left: 8,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 6,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          getJsonField(
                                                                  productBodyItem,
                                                                  r'''$.badge''')
                                                              .toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Inter'),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            // Product Content Section
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    _getContentPadding(
                                                        context)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Rating and Reviews

                                                    const SizedBox(height: 4),
                                                    // Product Name
                                                    Expanded(
                                                      child: Text(
                                                        getJsonField(
                                                          productBodyItem,
                                                          r'''$.productName''',
                                                        )
                                                            .toString()
                                                            .maybeHandleOverflow(
                                                              maxChars: 25,
                                                              replacement: '…',
                                                            ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: const Color(
                                                                      0xFF1A1A1A),
                                                                  fontSize:
                                                                      _getProductNameFontSize(
                                                                          context),
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
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    // Pricing Section
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '₹${getJsonField(
                                                                productBodyItem,
                                                                r'''$.price''',
                                                              ).toString()}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: const Color(
                                                                        0xFF263F96),
                                                                    fontSize:
                                                                        16,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            'Inter'),
                                                                  ),
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          1),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red
                                                                    .shade50,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    // Add to Bag Button
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ]),
                          );
                        });
                      }),
                )),
          ),
        );
      },
    );
  }
}
