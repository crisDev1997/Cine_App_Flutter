import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';

class BuyProvider extends ChangeNotifier {
  String _nitCI = "";
  String _invoiceName = "";
  int _numberSeats = 0;
  double _total = 0;
  String _proofPay = '';
  final List<String> _seatsSelected = [];
  String get proofPay => _proofPay;
  String get nitCI => _nitCI;
  String get invoiceName => _invoiceName;
  int get numberSeats => _numberSeats;
  double get total => _total;
  List<String> get seatsSelected => _seatsSelected;
  void setTotal(double total) {
    _total = total;
    notifyListeners();
  }

  void setNitCI(String nitCI) {
    _nitCI = nitCI;
    notifyListeners();
  }

  void setInvoiceName(String invoiceName) {
    _invoiceName = invoiceName;
    notifyListeners();
  }

  void setNumberSeats(int numberSeats) {
    _numberSeats = numberSeats;
    notifyListeners();
  }

  void setProofPay(String proofPay) {
    _proofPay = proofPay;
    notifyListeners();
  }
}
