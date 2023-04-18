// ignore_for_file: unnecessary_null_comparison

import 'package:cine_app/src/models/promo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PromoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PromoModel>?> getPromos() async {
    try {
      CollectionReference movieRef = _firestore.collection('promos');
      QuerySnapshot snapshot =
          //await movieRef.where("recentlyReleased", isEqualTo: true).get();
          await movieRef.get();
      if (snapshot.size > 0) {
        List<PromoModel>? promos = [];
        promos = snapshot.docs
            .map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              if (data.keys.contains("id") &&
                  data.keys.contains("imgURL") &&
                  data.keys.contains("name") &&
                  data.keys.contains("desc")) {
                return PromoModel.fromJson(data);
              }
              return null;
            })
            .whereType<PromoModel>()
            .toList();
        return promos;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
