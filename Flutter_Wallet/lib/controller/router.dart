
import 'package:assignment2/view/pages/exchange_page.dart';
import 'package:assignment2/view/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../view/pages/error_page.dart';
import '../view/pages/wallet_page.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){

    //final args = settings.arguments;

    RouteSettings settingsNew = RouteSettings(name: settings.name);

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage(), settings: settingsNew);
      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletPage(), settings: settingsNew);
      case '/exchange':
        return MaterialPageRoute(builder: (_) => const ExchangePage(), settings: settingsNew);
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage(), settings: settingsNew);
    }
  }


}
