import 'package:flutter/material.dart';
import 'package:mirror_wall/providers/networkProvider.dart';
import 'package:mirror_wall/views/homePage.dart';
import 'package:mirror_wall/views/wed_View.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NetworkProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        // home: const homePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => homePage(),
          'Web_View_Page': (context) => Web_View_Page(),
        },
      ),
    ),
  );
}
