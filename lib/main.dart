import 'package:app_spinning_wheel/firebase_options.dart';
import 'package:app_spinning_wheel/main_bottom.dart';
import 'package:app_spinning_wheel/models/cart_provider.dart'; // นำเข้า CartProvider
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/menu_provider.dart'; // นำเข้า Provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          const MainBottom(), // ให้แน่ใจว่า MainBottom สามารถเข้าถึง Provider ได้
    );
  }
}
