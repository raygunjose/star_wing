import 'package:flutter/material.dart';
import 'package:star_wing/wing_drawer.dart';
import 'graphql_service.dart';

class MenuListPage extends StatefulWidget {
  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final GraphQLService _graphqlService = GraphQLService();
  List<dynamic> _menus = [];

  @override
  void initState() {
    super.initState();
    _fetchMenus();
  }

  void _fetchMenus() async {
    final String query = '''
      query {
        getOrders {
          _id
          customerName
          mainDish
          sideDish
        }
      }
    ''';

    try {
      final result = await _graphqlService.postQuery(query);
      setState(() {
        _menus = result['data']['getOrders'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch menus: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu List')),
      drawer: WingDrawer(),
      body: ListView.builder(
        itemCount: _menus.length,
        itemBuilder: (context, index) {
          final menu = _menus[index];
          return ListTile(
            title: Text(menu['mainDish']),
            subtitle: Text(menu['sideDish']),
            trailing: Text(menu['customerName']),
          );
        },
      ),
    );
  }
}
