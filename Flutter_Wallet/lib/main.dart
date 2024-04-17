import 'package:assignment2/controller/exchange_provider.dart';
import 'package:assignment2/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/router.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ExchangeData())
          ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Currency Conversion App',
      theme: appTheme,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}