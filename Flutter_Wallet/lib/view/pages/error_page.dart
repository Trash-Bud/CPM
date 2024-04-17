
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallet.darkPink,
        body: Container(
          alignment: Alignment.center,
          child: const Text("404\n Page Not Found", style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ));
  }
}