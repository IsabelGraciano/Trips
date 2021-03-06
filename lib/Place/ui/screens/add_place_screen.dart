import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/Place/ui/widgets/title_input_location.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/widgets/button_purple.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/text_input.dart';
import 'package:platzi_trips_app/widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  File image;
  AddPlaceScreen({Key key, this.image});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      body: Stack(
        children: <Widget> [
          GradientBack(height: 300.0),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 45,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
               Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                  child: TitleHeader(title: "Add a new place"),
                ),
               ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom:20.0),
            child: ListView(
              children: <Widget> [
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    pathImage: widget.image.path,
                    iconData: Icons.camera_alt,
                    width: 300.0,
                    height: 200.0,
                    left: 0,
                  ),
                ), //foto
                Container(
                  margin: EdgeInsets.only(bottom:20.0, top: 20.0),
                  child: TextInput(
                    hintText: "Title",
                    inputType: null,
                    maxLines: 1,
                    controller: _controllerTitlePlace,
                  ),
                ),
                TextInput( //description
                    hintText: "Description",
                    inputType: TextInputType.multiline,
                    maxLines: 4,
                    controller: _controllerDescriptionPlace
                ),
                Container(
                  margin: EdgeInsets.only(top:20.0),

                  child: TextInputLocation(
                    hintText: "Add location",
                    iconData: Icons.location_on,
                  ),
                ),
                Container(
                  width: 70,
                  child: ButtonPurple(
                    buttonText: "Add place",
                    onPressed: (){
                      //firebase storage. nos devuelve una url de la img
                      //id del usuario logueado
                      userBloc.currentUser.then((auth.User user){
                        if(user != null){
                          //firebase storage. subir el archivo

                        }
                      });
                      //cuando la tengamos insertamos en cloud firestore los datos de la img, place, title, description...
                      userBloc.updatePlaceData(Place (
                        name: _controllerTitlePlace.text,
                        description: _controllerDescriptionPlace.text,
                        likes:0,
                      )).whenComplete(() {
                        print("terminó");
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
