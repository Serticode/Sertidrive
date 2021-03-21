import 'package:firebase_storage/firebase_storage.dart' as _storage;
import 'package:firebase_storage/firebase_storage.dart';

class Folders {
  //!GET LIST OF DIRECTORIES IN USERS ROOT DIRECTORY
  Future<List<Reference>> listRootFolders({String email}) async {
    _storage.ListResult rootDirectoryResult =
        await _storage.FirebaseStorage.instance.ref(email).listAll();
    return rootDirectoryResult.prefixes;
  }

  //!GET LIST OF FILES IN EACH NAMED DIRECTORY FOUND IN ROOT DIRECTORY
  Future<List<Reference>> listImagesFolderContent({String email}) async {
    //!IMAGES DIRECTORY
    _storage.ListResult imagesDirectoryResult =
        await _storage.FirebaseStorage.instance.ref("$email/Images").listAll();
    return imagesDirectoryResult.items;
  }

  Future<List<Reference>> listVideosFolderContent({String email}) async {
    //!VIDEOS DIRECTORY
    _storage.ListResult videosDirectoryResult =
        await _storage.FirebaseStorage.instance.ref("$email/Videos").listAll();
    return videosDirectoryResult.items;
  }

  Future<List<Reference>> listAudiosFolderContent({String email}) async {
    //!AUDIOS DIRECTORY
    _storage.ListResult audiosDirectoryResult =
        await _storage.FirebaseStorage.instance.ref("$email/Audios").listAll();
    return audiosDirectoryResult.items;
  }

  Future<List<Reference>> listDocumentsFolderContent({String email}) async {
    //!DOCUMENTS DIRECTORY
    _storage.ListResult filesDirectoryResult = await _storage
        .FirebaseStorage.instance
        .ref("$email/Documents")
        .listAll();
    return filesDirectoryResult.items;
  }
}
