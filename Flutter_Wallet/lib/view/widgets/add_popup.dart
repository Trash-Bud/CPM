import 'package:assignment2/controller/exchange_provider.dart';
import 'package:assignment2/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPopUp extends AlertDialog {
  AddPopUp(this.context, this.setState, {super.key}) {
    _startPreferences();
  }

  final BuildContext context;

  final Function setState;

  late String currencyToTransfer = "EUR";
  late double amount = 0;
  final _formKey = GlobalKey<FormState>();

  late SharedPreferences _prefs;
  Future<void> _startPreferences() async{
    _prefs = await SharedPreferences.getInstance();
  }

  addAmount(String key, double amount) async{
    final currentAmount = _prefs.getDouble(key) ?? 0;
    await _prefs.setDouble(key, currentAmount + amount);
  }


  @override
  Color? get backgroundColor => Colors.white;

  @override
  EdgeInsetsGeometry? get titlePadding => EdgeInsets.zero;

  @override
  Widget? get title => Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      color: ColorPallet.darkPink,
      child: const Text(
        "Add To Wallet",
        style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ));


  @override
  Widget? get content => getForm();

  @override
  List<Widget>? get actions => [
        ElevatedButton(
            onPressed: () => {
                  if (_formKey.currentState!.validate())
                    {
                      _formKey.currentState?.save(),
                      context.read<ExchangeData>().updateWallet(currencyToTransfer, amount),
                      setState(()=>{}),
                      Navigator.of(context).pop()
                    }
                },
            child: const Text("Add", style: TextStyle(fontSize: 25))),
        TextButton(
            onPressed: () => {Navigator.of(context).pop()},
            child: const Text(
              "Cancel",
              style: TextStyle(fontSize: 25),
            ))
      ];

  @override
  MainAxisAlignment? get actionsAlignment => MainAxisAlignment.spaceEvenly;

  @override
  EdgeInsetsGeometry? get actionsPadding => const EdgeInsets.all(10);

  Widget getForm() {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onSaved: (String? value){amount= double.parse(value ?? "0");},
                key: const Key("amount"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter value in your wallet',
                ),
              ),
            ),
            const SizedBox(height: 10,),
            getDropDown(),
          ],
        ),
      ),
    );
  }

  Widget getDropDown() {
    return SizedBox(
      child: DropdownButtonFormField <String>(
        onSaved: (String? value){currencyToTransfer= value ?? "EUR";},
        key: const Key("currency"),
        isExpanded: true,
        value: currencyToTransfer,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
          size: 30,
        ),
        onChanged: (value) => {currencyToTransfer = value!},
        style: const TextStyle(color: Colors.black),
        items: codeToName.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              "${codeToName[value]} ($value)",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          );
        }).toList(),
      ),
    );
  }
}
