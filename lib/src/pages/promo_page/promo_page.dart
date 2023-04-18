import 'package:cine_app/src/models/promo_model.dart';
import 'package:cine_app/src/pages/promo_page/promo_item.dart';
import 'package:flutter/material.dart';

import '../../providers/promo_provider.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  Widget build(BuildContext context) {
    final promoProvider = PromoProvider();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SliverGridPromosList(
          list: promoProvider.fetchPromos(),
        ),
      ),
    );
  }
}

class SliverGridPromosList extends StatelessWidget {
  SliverGridPromosList({Key? key, required this.list}) : super(key: key);
  Future<List<PromoModel>> list;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, AsyncSnapshot<List<PromoModel>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<PromoModel> promos = snapshot.data ?? [];
          return CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Text(
                  "Promociones",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.0,
                ),
              ),
              SliverGrid.count(
                crossAxisSpacing: 10.0,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                children: promos.map((promo) {
                  return PromoContainer(
                    id: promo.id,
                    name: promo.name,
                    imgURL: promo.imgURL,
                    desc: promo.desc,
                    price: promo.price,
                  );
                }).toList(),
              )
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class PromoContainer extends StatelessWidget {
  PromoContainer(
      {Key? key,
      required this.id,
      required this.name,
      required this.imgURL,
      required this.desc,
      this.price})
      : super(key: key);
  final String name;
  final String imgURL;
  final String id;
  final String desc;
  String? price;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PromoItem(id: id, name: name, desc: desc, imgURL: imgURL)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(239, 239, 239, 1),
            border: Border.all(color: Colors.black87),
            boxShadow: const [
              BoxShadow(
                  blurRadius: .7, offset: Offset(2, 3), color: Colors.black38)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Image.network(imgURL,
                width: 200,
                height: MediaQuery.of(context).size.height * 0.18,
                fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/no_image.jpg',
                height: 160,
                width: 120,
                fit: BoxFit.cover,
              );
            }),
          ),
          const SizedBox(height: 5.0),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:
                  const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
            ),
          ))
        ]),
      ),
    );
  }
}
