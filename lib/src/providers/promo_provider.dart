import 'package:cine_app/src/models/promo_model.dart';
import 'package:cine_app/src/services/promo_service.dart';
import 'package:flutter/material.dart';

class PromoProvider extends ChangeNotifier {
  List<PromoModel> _promos = [];
  List<PromoModel> get promos => _promos;
  Future<List<PromoModel>> fetchPromos() async {
    // ignore: prefer_is_empty
    try {
      if (_promos.isNotEmpty) {
        return _promos;
      }
      final PromoService promoService = PromoService();
      List<PromoModel>? list = await promoService.getPromos();
      _promos = list ?? [];
      notifyListeners();
      return _promos;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
