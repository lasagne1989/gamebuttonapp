import 'package:flutter/material.dart';
import '../page/forfeits_list.dart';
import '../page/games_list.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.videogame_asset),
            title: Text('Games'),
            onTap: () => {
            Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
            return GamesList();
            })),
          },
          ),
          ListTile(
            leading: Icon(Icons.wine_bar),
            title: Text('Forfeits'),
            onTap: () =>
            {Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
            return ForfeitList();})),
            },
          ),
        ],
      ),
    );
  }
}