import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/pages/home_page.dart';

import 'providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shoe Shopping App',
          theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromRGBO(254, 206, 1, 1),
                  primary: const Color.fromRGBO(254, 206, 1, 1)),
              inputDecorationTheme: const InputDecorationTheme(
                contentPadding: EdgeInsets.all(12.5),
                hintStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                prefixIconColor: Color.fromARGB(255, 114, 114, 114),
              ),
              textTheme: const TextTheme(
                titleMedium:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              useMaterial3: true),
          home: const HomePage()),
    );
  }
}
