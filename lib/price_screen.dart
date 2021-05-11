import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';
  Map<String, String> cryptoValues = {};
  bool isWaitingForData = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    CoinData coinData = CoinData();
    var coin = await coinData.getCoinData(_selectedCurrency);
    setState(() {
      isWaitingForData = false;
      cryptoValues = coin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              for (String crypto in cryptoList) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        isWaitingForData
                            ? 'Wait for it'
                            : '1 $crypto = ${cryptoValues[crypto]} $_selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: _selectedCurrency,
              items: [
                for (String currency in currenciesList) ...[
                  DropdownMenuItem(
                    child: Text(currency),
                    value: currency,
                  ),
                ],
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCurrency = value;
                  getData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
