import 'package:assignment2/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.darkPink,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.currency_exchange,
                color: Colors.white,
                size: 250,
              ),
              const SizedBox(height:10,),
              const Text(
                "Wallet Currency Convertor",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height:30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/wallet');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(ColorPallet.darkPink),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 30),
                ),)
              )
            ],
          ),
        )
    );
  }
}
