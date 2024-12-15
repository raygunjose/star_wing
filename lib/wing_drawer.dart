import 'package:flutter/material.dart';
import 'package:star_wing/form_page.dart';
import 'package:star_wing/menu_list_page.dart';

class WingDrawer extends StatefulWidget {

  const WingDrawer({super.key});

  @override
  _WingDrawerState createState() => _WingDrawerState();
}
class _WingDrawerState extends State<WingDrawer> {
  
   @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text('Drawer Header')
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.list),
                title: const Text('Orders'),
                onTap: () => {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                )}
              ),
              ListTile(
                leading: Icon(Icons.fastfood_outlined),
                title: const Text('More'),
                onTap: () => {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuListPage()),
                )}
              ),
            ],
          ),
        ],
      ),
    );
  }
}

