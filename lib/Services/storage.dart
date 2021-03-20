import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  //!STORAGE REFERENCE
  final _storage = FirebaseStorage.instance;

  //!STORAGE FOR IMAGES
  Future uploadImage(
      {String email, List<File> files, int noOfFilesInCloud}) async {
    files.forEach((element) async {
      return await _storage
          .ref()
          .child('$email/Images/${element.path.split("/").last}')
          .putFile(element);
    });
  }

  //!STORAGE FOR VIDEOS
  Future uploadVideos({String email, List<File> files}) async {
    files.forEach((element) async {
      return await _storage
          .ref()
          .child('$email/Videos/${element.path.split("/").last}')
          .putFile(element);
    });
  }

  //!STORAGE FOR AUDIOS
  Future uploadAudios({String email, List<File> files}) async {
    files.forEach((element) async {
      return await _storage
          .ref()
          .child('$email/Audios/${element.path.split("/").last}')
          .putFile(element);
    });
  }

  //!STORAGE FOR DOCUMENTS
  Future uploadDocuments({String email, List<File> files}) async {
    files.forEach((element) async {
      return await _storage
          .ref()
          .child('$email/Documents/${element.path.split("/").last}')
          .putFile(element);
    });
  }
}
