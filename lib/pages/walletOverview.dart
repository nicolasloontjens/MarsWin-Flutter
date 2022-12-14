import 'package:carbon_icons/carbon_icons.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marswin/data/network/datafetcher.dart';
import 'package:marswin/pages/generalElements.dart';

class WalletOverview extends StatefulWidget {
  const WalletOverview({Key? key}) : super(key: key);

  @override
  State<WalletOverview> createState() => _WalletOverviewState();
}

class _WalletOverviewState extends State<WalletOverview> {
  late Future<int> balance;
  int showOverview = 0;
  Key _key = UniqueKey();
  TextEditingController _amountController = TextEditingController();

  void showAddFunds() {
    setState(() {
      showOverview = 1;
    });
  }

  void showOverviewFunds() {
    setState(() {
      showOverview = 0;
    });
  }

  void showWithdrawFunds() {
    setState(() {
      showOverview = 2;
    });
  }

  @override
  void initState() {
    super.initState();
    GetStorage().write("walletOperationType", 0);
    balance = Datafetcher.getBalance();
  }

  Future editBalance(bool withdraw) async {
    int currBal = await Datafetcher.getBalance();
    int inputBalance = int.parse(_amountController.text);
    String operation = withdraw ? "withdraw" : "deposit";
    if (withdraw) {
      if (inputBalance > currBal) {
        showToast(
          "Insufficient balance",
          context: context,
          position: StyledToastPosition.top,
          animation: StyledToastAnimation.slideFromTopFade,
          reverseAnimation: StyledToastAnimation.fade,
          alignment: Alignment.bottomCenter,
          backgroundColor: Colors.redAccent,
          shapeBorder: ShapeBorder.lerp(
              Border(
                top: BorderSide(color: Colors.black, width: 2.0),
                left: BorderSide(color: Colors.black, width: 2.0),
                right: BorderSide(color: Colors.black, width: 3.0),
                bottom: BorderSide(color: Colors.black, width: 3.0),
              ),
              Border(
                top: BorderSide(color: Colors.black, width: 2.0),
                left: BorderSide(color: Colors.black, width: 2.0),
                right: BorderSide(color: Colors.black, width: 3.0),
                bottom: BorderSide(color: Colors.black, width: 3.0),
              ),
              0.5),
        );
        return;
      }
    }
    bool response = await Datafetcher.updateBalance(operation, inputBalance);
    String msg = response ? "Balance updated" : "Could not update balance";
    Color color = response ? Colors.greenAccent : Colors.redAccent;
    showToast(
      msg,
      context: context,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.bottomCenter,
      backgroundColor: color,
      duration: Duration(seconds: 3),
      shapeBorder: ShapeBorder.lerp(
          Border(
            top: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 3.0),
            bottom: BorderSide(color: Colors.black, width: 3.0),
          ),
          Border(
            top: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 3.0),
            bottom: BorderSide(color: Colors.black, width: 3.0),
          ),
          0.5),
    );
    setState(() {
      _amountController.clear();
      _key = UniqueKey();
      showOverview = 0;
      balance = Datafetcher.getBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          key: _key,
          decoration: BoxDecoration(color: Color(0xFFF1EBE6)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Wallet",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Nasalization")),
              FutureBuilder<int>(
                  future: balance,
                  builder: (((context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CarbonIcons.currency),
                            Text('  ${snapshot.data}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Nasalization'))
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            if (showOverview == 0) ...[
                              Container(
                                child: Column(
                                  children: [
                                    GeneralElements.getActionButton(
                                        "Add funds", showAddFunds, context),
                                    SizedBox(height: 20),
                                    GeneralElements.getActionButton(
                                        "Withdraw funds",
                                        showWithdrawFunds,
                                        context),
                                  ],
                                ),
                              ),
                            ] else if (showOverview == 1) ...[
                              Container(
                                  child: Column(
                                children: [
                                  Text(
                                    "Add amount:",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a valid amount";
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _amountController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 5.0),
                                          ),
                                          hintText: 'Amount'),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GeneralElements.getActionButton("Add",
                                      () async {
                                    await editBalance(false);
                                  }, context),
                                  SizedBox(height: 20),
                                  GeneralElements.getActionButton("Cancel",
                                      () async {
                                    setState(() {
                                      showOverview = 0;
                                    });
                                  }, context, color: Colors.grey),
                                ],
                              ))
                            ] else if (showOverview == 2) ...[
                              Container(
                                  child: Column(
                                children: [
                                  Text(
                                    "Withdrawal amount:",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a valid amount";
                                        } else if (int.parse(value) >
                                            snapshot.data!) {
                                          return "You don't have enough funds";
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _amountController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 5.0),
                                          ),
                                          hintText: 'Amount'),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GeneralElements.getActionButton("Withdraw",
                                      () async {
                                    await editBalance(true);
                                  }, context),
                                  SizedBox(height: 20),
                                  GeneralElements.getActionButton("Cancel",
                                      () async {
                                    setState(() {
                                      showOverview = 0;
                                    });
                                  }, context, color: Colors.grey),
                                ],
                              ))
                            ]
                          ],
                        ),
                      ]);
                    }
                    return Center(
                        child: SpinKitWave(
                      color: Colors.black,
                      size: 40,
                      itemCount: 6,
                    ));
                  }))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
