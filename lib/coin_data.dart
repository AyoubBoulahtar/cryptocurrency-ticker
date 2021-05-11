import 'package:bitcoin_ticker/coin_service.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apiKey = 'DB601350-351A-43DC-B15E-62FCB24EBF9C';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      CoinService coinService = CoinService(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey');
      var coinData = await coinService.getData();
      double price = coinData['rate'];
      cryptoPrices[crypto] = price.toStringAsFixed(0);
    }
    return cryptoPrices;
  }
}
