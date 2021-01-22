import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips_app/User/model/user.dart' as Model;

class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();

  //Flujo de datos (Stream)
  //Stream de Firebase
  // Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  // ignore: deprecated_member_use
  Stream<User> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;

  // ignore: deprecated_member_use
  Stream<User> get authStatus => streamFirebase;

  Future<User> get currentUser => FirebaseAuth.instance.currentUser();
  

  //Casos de uso
  //1. Hacer SignIn a la aplicacion Google
  // ignore: deprecated_member_use
  Future<User> signIn() {
    return _auth_repository.signInFirebase();
  }
  
  Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);

  //2. Hacer signout
  signOut() {
    _auth_repository.signOut();
  }

  //3. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(Model.User user) async => _cloudFirestoreRepository.updateUserDataFirestore(user);
  //Futute<void> updatePlaceData(Model.User user) async => _cloudFirestoreRepository.updateUserDataFirestore(user);
  final _firebaseStorageRepository = FirebaseStorageRepository();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}