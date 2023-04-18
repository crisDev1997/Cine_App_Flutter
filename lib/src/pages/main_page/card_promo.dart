import 'package:flutter/material.dart';

class CardPromo extends StatelessWidget {
  CardPromo(
      {Key? key, this.imgURL, this.title, this.description, this.width = 180})
      : super(key: key);
  String? imgURL;
  String? title;
  String? description;
  double width;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: const Color.fromARGB(255, 245, 238, 238),
        width: width,
        height: 100,
        child: Column(children: [
          imgURL != null
              ? Image.network(
                  imgURL!,
                  width: width,
                  height: 100,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/no_image.jpg',
                      height: 100,
                      width: width,
                      fit: BoxFit.fill,
                    );
                  },
                )
              : Image.asset(
                  'assets/images/no_image.jpg',
                  height: 100,
                  width: width,
                  fit: BoxFit.fill,
                ),
        ]),
      ),
    );
  }
}
