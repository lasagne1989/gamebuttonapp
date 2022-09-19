import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../page/home_page.dart';
import '../provider/players.dart';

void main()  { runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayersProvider())
      ],
    child:MyApp(),),);}

class MyApp extends StatelessWidget {
  static final String title = 'Game Button App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => PlayersProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Color(0xFF616161),
          ),
          home: HomePage(),
        ),
      );
}
