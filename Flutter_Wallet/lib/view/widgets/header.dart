
import 'package:assignment2/utils/constants.dart';
import 'package:flutter/material.dart';

class Header extends AppBar{
  Header(this.titleText, {super.key});

  final String titleText;

  @override
  Color? get backgroundColor => ColorPallet.darkPink;

  @override
  Widget? get title => Text(titleText, style: const TextStyle(color: Colors.white, fontSize:40));



  @override
  bool get automaticallyImplyLeading => false;

}