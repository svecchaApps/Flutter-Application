import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:indigo_rhapsody_dupli/designer/product_description_color/product_description_color_widget.dart';
import 'package:indigo_rhapsody_dupli/flutter_flow/flutter_flow_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchpageWidget extends StatefulWidget {
  const SearchpageWidget({
    super.key,
  });

  @override
  State<SearchpageWidget> createState() => _SearchpageWidgetState();
}

class _SearchpageWidgetState extends State<SearchpageWidget> {
  final TextEditingController _typeAheadController = TextEditingController();
  final ProductService _productService = ProductService();
  List<Map<String, dynamic>> _recentlySearchedItems = [];
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _typeAheadController.addListener(_onSearchChanged);
    _loadRecentlySearchedItems();
  }

  @override
  void dispose() {
    _typeAheadController.removeListener(_onSearchChanged);
    _typeAheadController.dispose();
    super.dispose();
  }

  Future<void> _loadRecentlySearchedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? items = prefs.getString('recentlySearchedItems');
    if (items != null) {
      setState(() {
        _recentlySearchedItems =
            List<Map<String, dynamic>>.from(json.decode(items));
      });
    }
  }

  Future<void> _saveRecentlySearchedItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'recentlySearchedItems', json.encode(_recentlySearchedItems));
  }

  void _onSearchChanged() async {
    if (_typeAheadController.text.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _hasError = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final results =
          await _productService.searchProducts(_typeAheadController.text);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _onProductSelected(Map<String, dynamic> product) {
    setState(() {
      _recentlySearchedItems
          .removeWhere((item) => item['_id'] == product['_id']);
      _recentlySearchedItems.insert(0, product);
      _saveRecentlySearchedItems();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDescriptionColorWidget(
          productId: product['_id'].toString(),
          price: product['price'].toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: const Text('Search'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _typeAheadController,
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _typeAheadController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _typeAheadController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                ),
                autofocus: true,
              ),
              if (_typeAheadController.text.isEmpty ||
                  (_searchResults.isEmpty && !_isLoading))
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Recently Searched",
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                            ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: _typeAheadController.text.isEmpty
                    ? ListView.builder(
                        itemCount: _recentlySearchedItems.length,
                        itemBuilder: (context, index) {
                          final product = _recentlySearchedItems[index];
                          return ListTile(
                            leading: product['coverImage'] != null
                                ? Image.network(
                                    product['coverImage'],
                                    width: 50,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image, size: 50),
                            title: Text(product['productName'] ?? 'No Name',
                                style: const TextStyle(fontSize: 16)),
                            subtitle: Text('₹${product['price'] ?? 0}',
                                style: const TextStyle(color: Colors.green)),
                            onTap: () => _onProductSelected(product),
                          );
                        },
                      )
                    : _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _hasError
                            ? const Center(
                                child: Text('Product Does Not Exist'))
                            : _searchResults.isEmpty
                                ? const Center(child: Text('No Products Found'))
                                : ListView.builder(
                                    itemCount: _searchResults.length,
                                    itemBuilder: (context, index) {
                                      final product = _searchResults[index];
                                      final coverImage =
                                          product['coverImage'] ?? '';
                                      final productName =
                                          product['productName'] ?? 'No Name';
                                      final price = product['price'] ?? 0;

                                      return ListTile(
                                        leading: coverImage.isNotEmpty
                                            ? Image.network(
                                                coverImage,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(
                                                        Icons.broken_image,
                                                        size: 50),
                                              )
                                            : const Icon(Icons.image, size: 50),
                                        title: Text(productName,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        subtitle: Text('₹$price',
                                            style: const TextStyle(
                                                color: Colors.green)),
                                        onTap: () =>
                                            _onProductSelected(product),
                                      );
                                    },
                                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductService {
  static const String baseUrl =
      'https://indigo-rhapsody-backend-ten.vercel.app/products/products';

  Future<List<dynamic>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?productName=$query'),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['products']; // Access the 'products' field properly
    } else {
      throw Exception('Failed to load products');
    }
  }
}
