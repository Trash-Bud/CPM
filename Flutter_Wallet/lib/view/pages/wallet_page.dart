import 'package:assignment2/controller/exchange_provider.dart';
import 'package:assignment2/utils/constants.dart';
import 'package:assignment2/view/widgets/add_popup.dart';
import 'package:assignment2/view/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/header.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header("Wallet"),
      body: pageBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed("/exchange");
          }
        },
        backgroundColor: ColorPallet.lightPink,
        selectedItemColor: ColorPallet.darkPink,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet, color: Colors.black),
              activeIcon: Icon(
                Icons.account_balance_wallet,
                color: ColorPallet.darkPink,
              ),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange, color: Colors.black),
              activeIcon: Icon(
                Icons.currency_exchange,
                color: ColorPallet.darkPink,
              ),
              label: "Exchange")
        ],
      ),
    );
  }

  Widget pageBody() {
    return Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox( height: MediaQuery.of(context).size.height/4 *2, child: getListView()),

            getAddButton()
          ],
        ));
  }

  Widget getAddButton() {
    return SizedBox(

      width: MediaQuery.of(context).size.height/4,
      child: ElevatedButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context)  => AddPopUp(context, setState),
              )
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Add",
                style: TextStyle(fontSize: 30),
              ),
              Icon(
                Icons.wallet,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getListView(){

    if (context.watch<ExchangeData>().currencies.isEmpty) {
      return const Text(
        "Your wallet is empty.",
        style: TextStyle(color: ColorPallet.darkPink, fontSize: 50),
        textAlign: TextAlign.center,
      );
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: context.watch<ExchangeData>().currencies.length,
      itemBuilder: (BuildContext context, int index) {
        return WalletCard(
          currency: context.watch<ExchangeData>().currencies[index],
          value: context.watch<ExchangeData>().amounts[index],
          setState: setState, context: context,
        );
      },
    );
  }
}
