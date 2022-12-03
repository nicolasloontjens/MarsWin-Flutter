import 'package:carbon_icons/carbon_icons.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marswin/data/network/datafetcher.dart';

class WalletOverview extends StatefulWidget {
  const WalletOverview({Key? key}) : super(key: key);

  @override
  State<WalletOverview> createState() => _WalletOverviewState();
}

class _WalletOverviewState extends State<WalletOverview> {
  late Future<int> balance;
  int showOverview = 0;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetStorage().write("walletOperationType", 0);
    balance = Datafetcher.getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                                    Container(
                                      padding: EdgeInsets.only(top: 25),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showOverview = 1;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFE87470),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            'Add funds',
                                            style: TextStyle(
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 25),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showOverview = 2;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFE87470),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            'Withdraw funds',
                                            style: TextStyle(
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                        ),
                                      ),
                                    ),
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
                                  Container(
                                    padding: EdgeInsets.only(top: 25),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE87470),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          'Add',
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showOverview = 0;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                      ),
                                    ),
                                  ),
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
                                  Container(
                                    padding: EdgeInsets.only(top: 25),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE87470),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          'Withdraw',
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showOverview = 0;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                      ),
                                    ),
                                  ),
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
