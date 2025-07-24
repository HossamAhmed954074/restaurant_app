import 'package:flutter/material.dart';
import 'package:resturant_app/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routerConfig: AppRouter.router,
    );
  }
}

