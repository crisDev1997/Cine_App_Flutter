import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageService {
  Future<String?> getImageFromURL(String ref, String imageName) async {
    try {
      String? imageURL = await getImageFromStorage(ref, imageName);
      if (imageURL != null) {
        return imageURL;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  Future<String?> getImageFromStorage(String ref, String imageName) async {
    return await FirebaseStorage.instance
        .ref(ref)
        .child(imageName)
        .getDownloadURL();
  }

  Future downloadImageFileByRef(String reference) async {
    try {
      var permissionRequest = Permission.storage.request();
      var ref = FirebaseStorage.instance.ref(reference);
      final url = await ref.getDownloadURL();
      if (url.isNotEmpty) {
        final dir = await getApplicationDocumentsDirectory();
        final path = '${dir.path}/${ref.name}';
        final url = await ref.getDownloadURL();
        await Dio()
            .download(url, path)
            .catchError((error) {})
            .then((value) => print(value.statusCode));
        await GallerySaver.saveImage(path, toDcim: true)
            .whenComplete(() => print("Descarga completa!"));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  Future<String> setImageFile() async {
    var permissionRequest = Permission.storage.request();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image!.path);
    return image.path;
  }
}
