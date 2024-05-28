
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Models/User.dart';


class UserProfile extends StatefulWidget {

  final User user;
  const UserProfile({super.key, required this.user});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                //for App bar

                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                      Icon(Icons.arrow_back_outlined,size: 30,),
                      Expanded(flex:1,child: Text("Back",style: TextStyle(fontSize: 20,color: Colors.black),)),

                    ],
                      ),
                  ),
                ),


                //for profile image
                Container(
                  margin: EdgeInsets.all(10),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(75))),
                  child: Icon(Icons.person,color: Colors.black,size: 100,),
                ),

                //user name
                Container(
                    margin:EdgeInsets.all(10),
                    child: Text(widget.user.name,style: TextStyle(fontSize: 24,color: Colors.black, fontWeight: FontWeight.bold))),




                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),



                //all user data
                profileDataCustomWidget("Height :",widget.user.height),
                profileDataCustomWidget("Birth Year :",widget.user.birthYear),
                profileDataCustomWidget("Gender :",widget.user.gender),
              ],
            )),
      ),
    );
  }



  Widget profileDataCustomWidget(String attrName,String value){
    return  Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Text(attrName,style: TextStyle(fontSize: 16,color: Colors.black54),),
          Text(value,style: TextStyle(fontSize: 16,color: Colors.black),),

        ],
      ),
    );

  }



}
