import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductEntryScreen extends StatefulWidget {
  final String? product;
  final Function(String)? onProductUpdated;

  ProductEntryScreen({this.product, this.onProductUpdated});

  @override
  _ProductEntryScreenState createState() => _ProductEntryScreenState();
}

class _ProductEntryScreenState extends State<ProductEntryScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final List<String> productDetails = widget.product!.split(',');
      _nextId = int.parse(productDetails[0]);
      _productNameController.text = productDetails[1];
      _quantityController.text = productDetails[2];
    }
  }

  Future<void> _saveProduct() async {
    final String productName = _productNameController.text;
    final int quantity = int.tryParse(_quantityController.text) ?? 0;

    if (productName.isNotEmpty && quantity > 0) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> products = prefs.getStringList('products') ?? [];

      final String product = '$_nextId,$productName,$quantity';
      if (widget.product != null) {
        final int index = products.indexOf(widget.product!);
        if (index != -1) {
          products[index] = product;
        }
      } else {
        products.add(product);
        _nextId++;
      }

      await prefs.setStringList('products', products);

      if (widget.onProductUpdated != null) {
        widget.onProductUpdated!(product);
      } else {
        _productNameController.clear();
        _quantityController.clear();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product saved!')),
      );

      // Log the action
      if (widget.product == null) {
        _addLog('Add', productName, quantity);
      } else {
        _addLog('Edit', productName, quantity);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid product details.')),
      );
    }
  }

  Future<void> _addLog(String action, String productName, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> logs = prefs.getStringList('logs') ?? [];

    final String log =
        '$action | $productName | $quantity | ${DateTime.now().toString()}';
    if (!logs.contains(log)) {
      logs.add(log);
      await prefs.setStringList('logs', logs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Entry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
