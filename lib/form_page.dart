import 'package:flutter/material.dart';
import 'package:star_wing/menu_list_page.dart';
import 'package:star_wing/wing_drawer.dart';
import 'graphql_service.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final GraphQLService _graphqlService = GraphQLService();

  String? _selectedMainDish;
  String? _selectedSideDish;
  final List<String> _mainDishes = ['Pizza', 'Pasta', 'Burger'];
  final List<String> _sideDishes = ['Salad', 'Fries', 'Garlic Bread'];

  void _submitOrder() async {
    if (_customerNameController.text.isEmpty ||
        _selectedMainDish == null ||
        _selectedSideDish == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    final String query = '''
      mutation {
        createOrder(input: {
          customerName: "${_customerNameController.text}",
          mainDish: "$_selectedMainDish",
          sideDish: "$_selectedSideDish",
          mainDishPrice: 10.0,
          sideDishPrice: 5.0
        }) {
          _id
          customerName
        }
      }
    ''';

    try {
      final result = await _graphqlService.postQuery(query);
      print('Order created: ${result['data']['createOrder']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order created successfully!')),
      );
      _customerNameController.clear();
      setState(() {
        _selectedMainDish = null;
        _selectedSideDish = null;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>MenuListPage())
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Order')),
      drawer: WingDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedMainDish,
              items: _mainDishes.map((dish) {
                return DropdownMenuItem(value: dish, child: Text(dish));
              }).toList(),
              onChanged: (value) => setState(() => _selectedMainDish = value),
              decoration: InputDecoration(labelText: 'Main Dish'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedSideDish,
              items: _sideDishes.map((dish) {
                return DropdownMenuItem(value: dish, child: Text(dish));
              }).toList(),
              onChanged: (value) => setState(() => _selectedSideDish = value),
              decoration: InputDecoration(labelText: 'Side Dish'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitOrder,
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}
