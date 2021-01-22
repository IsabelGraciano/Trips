import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageAPI{
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref();
}