import 'package:flutter/material.dart';
import 'package:platzi_trips_app/Place/model/place.dart';

class User{
  final String name;
  final String email;
  final String photoURL;
  final String uid;
  final List<Place> myPlaces;
  final List<Place> myFavoritePlaces;

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    this.myPlaces,
    this.myFavoritePlaces
  });
}