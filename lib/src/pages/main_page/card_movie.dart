import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  CardMovie(
      {Key? key,
      this.name,
      this.imgURL,
      this.genre,
      this.visualization,
      this.audio,
      this.times,
      this.releaseDate})
      : super(key: key);
  String? name;
  String? imgURL;
  String? releaseDate;

  String? genre;
  String? visualization;
  String? audio;

  List<String>? times;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 238, 238),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imgURL != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    child: Image.network(
                      imgURL!,
                      height: 150,
                      width: 120,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/no_image.jpg',
                          height: 160,
                          width: 120,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )
                : Image.asset(
                    'assets/images/no_image.jpg',
                    height: 160,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(
              height: 5.0,
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  name!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 9.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            releaseDate != null
                ? Flexible(
                    child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Text(
                      releaseDate!,
                      style: const TextStyle(fontSize: 10.0),
                    ),
                  ))
                : Container(),
            audio != null || genre != null || visualization != null
                ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        '${genre!} ${visualization!} ${audio!}',
                        style: const TextStyle(fontSize: 8.0),
                      ),
                    ),
                  )
                : Container(),
            times != null
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ListView.separated(
                        itemCount: times!.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 0.2,
                        ),
                        itemBuilder: (context, index) {
                          var text = "${times![index]} - ";
                          if (index == times!.length - 1) {
                            text = times![index];
                          }
                          return Text(
                            text,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 8.0, overflow: TextOverflow.fade),
                          );
                        },
                      ),
                    ),
                  )
                : Container()
          ]),
    );
  }

  _getRelease(List<String>? times) {
    return times!.map((e) => <Widget>[
          Text(e),
          const SizedBox(
            width: 2,
          )
        ]);
  }
}
//Icon(Icons.timer_3_select),