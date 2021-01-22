import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class CloudFirestoreAPI {
  final String USERS = 'users';
  final String PLACES = 'places';
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }


  Future<void> updatePlaceData(Place place) async {
    // accediendo a la data para subir un place
    CollectionReference refPlaces = _db.collection(PLACES);
    auth.User user = _auth.currentUser;
    // consultando el user logueado
    await
    refPlaces.add({
      // definiendo los keys de la data (que es lo que queremos)
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      // tipo de dato User
      'userOwner': "${USERS}/${user.uid}", // reference..
    });
  }
}