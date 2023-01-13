import 'package:flutter/material.dart';
import '../provider/games.dart';
import 'package:provider/provider.dart';
import '../page/home_page.dart';
import '../provider/players.dart';

void main()  { runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayersProvider()),
        ChangeNotifierProvider(create: (_) => GamesProvider())
      ],
    child:MyApp(),),);}

class MyApp extends StatelessWidget {
  static final String title = 'Game Button App';

  @override
  Widget build(BuildContext context) {
        return MultiProvider(
        providers:[
            ChangeNotifierProvider(
            create: (context) => PlayersProvider(),
            ),
            ChangeNotifierProvider(
            create: (context) => GamesProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Color(0xFF616161),
          ),
          home: HomePage(),
        ),);
  }
}
