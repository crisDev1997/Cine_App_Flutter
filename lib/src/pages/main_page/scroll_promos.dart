import 'package:cine_app/src/pages/main_page/card_promo.dart';
import 'package:flutter/material.dart';

class ScrollPromos extends StatelessWidget {
  ScrollPromos({Key? key, this.height, required this.promoList})
      : super(key: key);
  double? height;
  final List<dynamic> promoList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 210.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, _) => const SizedBox(
          width: 6.0,
        ),
        itemCount: promoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: CardPromo(
              imgURL: promoList[index]["imgURL"],
            ),
          );
        },
      ),
    );
  }
}
