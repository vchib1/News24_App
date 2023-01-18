import 'package:flutter/material.dart';
import 'package:newsapp/Providers/IntNewsProvider.dart';
import 'package:newsapp/Providers/CategoryProvider.dart';
import 'package:newsapp/Providers/SearchedNewsProvider.dart';
import 'package:newsapp/pages/Home_page.dart';
import 'package:provider/provider.dart';

import 'Providers/IndicatorProvider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InternationalProvider>(create: (context) => InternationalProvider()),
        ChangeNotifierProvider<CategoryProvider>(create: (context) => CategoryProvider()),
        ChangeNotifierProvider<SearchedNewsProvider>(create: (context) => SearchedNewsProvider()),
        ChangeNotifierProvider<IndicatorProvider>(create: (context) => IndicatorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'PublicSans'
        ),
      ),
    );
  }
}


