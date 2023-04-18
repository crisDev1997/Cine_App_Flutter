import 'package:flutter/material.dart';

class PromoItem extends StatelessWidget {
  PromoItem(
      {Key? key,
      required this.id,
      required this.name,
      required this.desc,
      required this.imgURL,
      this.expireDate,
      this.price})
      : super(key: key);

  String id;
  String name;
  String desc;
  String imgURL;
  String? expireDate;
  String? items;
  String? price;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 45,
                child: Stack(
                  children: [
                    Image.network(
                      imgURL,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/no_image.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Container(
                              color: Colors.black,
                              child: Center(
                                child: ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 55,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black54)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toUpperCase(),
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        desc,
                        maxLines: 10,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      price != null
                          ? const Text(
                              '\$99.99',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
