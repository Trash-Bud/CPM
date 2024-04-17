import 'package:assignment2/utils/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExchangeData extends ChangeNotifier {
  bool loading = false;
  Map<String, dynamic> rates = {};
  Map<String, double> wallet = {};
  String targetCurrency = "EUR";
  bool _internet = true;
  bool _fail = false;

  ExchangeData() {
    getWallet();
  }

  double get result => getConversion();
  String get target => targetCurrency;
  bool get internet => _internet;
  bool get fail => _fail;
  List<String> get currencies => getCurrencies();
  List<double> get values => getValues();
  List<double> get amounts => getAmounts();

  double getConversion() {
    double res = 0.0;

    log(rates.toString());

    for (String key in wallet.keys.toList()) {
      res += wallet[key]! / rates[key]!;
    }

    return res;
  }

  List<String> getCurrencies() {
    return wallet.keys.toList();
  }

  List<double> getValues() {
    List<double> values = [];

    for (String key in wallet.keys.toList()) {
      values.add(wallet[key]! / rates[key]);
    }

    return values;
  }

  List<double> getAmounts() {
    List<double> amounts = [];

    for (String key in wallet.keys.toList()) {
      amounts.add(wallet[key]!);
    }

    return amounts;
  }

  void updateTarget(String currency) async {
    targetCurrency = currency;
    await getRates();
    notifyListeners();
  }

  void updateWallet(String key, double value) async{
    double currentVal = wallet[key] ?? 0;
    wallet[key] = currentVal + value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (wallet[key] != null) {
      await prefs.setDouble(key, wallet[key]!);
    }
    notifyListeners();
  }

  void updateWalletRemove(String key) async{
    wallet.remove(key);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    notifyListeners();
  }

  Future<void> getWallet() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String currency in codeToName.keys){
      final amount = prefs.getDouble(currency);
      if(amount != null && amount > 0){
        wallet[currency] = amount;
      }
    }
    notifyListeners();
  }

  Future<void> getRates() async{
    await updateConnectivity();
    loading = true;
    if (_internet) {
      rates = await getRatesData(targetCurrency, wallet.keys.toList());
    }
    else {
      Map<String, dynamic>? check = await readPrefs(targetCurrency, wallet);
      if (check == null) {
        _fail = true;
      }
      else {
        _fail = false;
        rates = check;
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<void> updateConnectivity() async {
    var result = await (Connectivity().checkConnectivity());
    log(result.toString());
    if (result == ConnectivityResult.none) {
      _internet = false;
    }
    else {
      _internet = true;
      _fail = false;
    }
    notifyListeners();
  }
}

Future<Map<String, dynamic>?> readPrefs(String base, Map<String, double> wallet) async {
  Map<String, dynamic>? res = {};
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  for (String currency in wallet.keys.toList()) {
    final double? rate = await prefs.getDouble("$base-$currency");
    if (rate == null) {
      return null;
    }
    else {
      res[currency] = rate;
    }
  }
  return res;
}

Future<void> saveRates(String base, Map<String, dynamic> rates) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  for (String currency in rates.keys.toList()) {
    if (currency == base) {
      await prefs.setDouble("$base-$currency", 1.0);
    }
    else {
      await prefs.setDouble("$base-$currency", rates[currency]);
    }
  }
}

Future<Map<String, dynamic>> getRatesData(String base, List<String> symbols) async {
  Map<String, dynamic> rates = {};

  String symbolsString = "";
  for (String symbol in symbols) {
    symbolsString = "$symbolsString,$symbol";
  }
  symbolsString = symbolsString.substring(1);
  String apikey = "MewoN23jPEBV08GCnzsmB3eYmnakPR8F";
  try {
    final response = await http.get(
      Uri.parse("https://api.apilayer.com/fixer/latest?symbols=$symbolsString&base=$base&apikey=$apikey")
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      if (item["success"]) {
        rates = item["rates"];
        await saveRates(base, rates);
      }
      else {
        log("error");
      }
    } else {
      log("error code");
    }
  } catch (e) {
    log(e.toString());
  }
  return rates;
}