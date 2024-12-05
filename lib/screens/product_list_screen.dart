import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screens/product_entry_screen.dart';
import 'package:flutter_application_1/screens/log_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> _products = [];

  Future<void> _loadProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> products = prefs.getStringList('products') ?? [];

    setState(() {
      _products = products;
    });
  }

  Future<void> _editProduct(int index) async {
    // Implement the logic to edit a product
    // For example, navigate to a product entry screen with the current product details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductEntryScreen(
          product: _products[index],
          onProductUpdated: (updatedProduct) {
            setState(() {
              _products[index] = updatedProduct;
            });
            _addLog('Edit', _products[index].split(',')[0]);
          },
        ),
      ),
    );
  }

  Future<void> _deleteProduct(int index) async {
    // Implement the logic to delete a product
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> products = prefs.getStringList('products') ?? [];

    setState(() {
      products.removeAt(index);
      prefs.setStringList('products', products);
      _products = products;
    });
    _addLog('Delete', _products[index].split(',')[0]);
  }

  Future<void> _addLog(String action, String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> logs = prefs.getStringList('logs') ?? [];

    final String log = '${DateTime.now().toString()} | $action | $id';
    logs.add(log);
    await prefs.setStringList('logs', logs);
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: _products.isEmpty
          ? Center(child: Text('No products found.'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final List<String> productDetails = _products[index].split(',');
                final int id = int.parse(productDetails[0]);
                final String productName = productDetails[1];
                final int quantity = int.parse(productDetails[2]);

                return ListTile(
                  title: Text(productName),
                  subtitle: Text('Quantity: $quantity'),
                  trailing: Text('ID: $id'),
                  // Add a PopupMenuButton for Edit and Delete actions
                  leading: PopupMenuButton<String>(
                    onSelected: (String result) {
                      if (result == 'Edit') {
                        _editProduct(index);
                      } else if (result == 'Delete') {
                        _deleteProduct(index);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ],
                    icon: Icon(Icons.more_vert),
                  ),
                );
              },
            ),
    );
  }
}
