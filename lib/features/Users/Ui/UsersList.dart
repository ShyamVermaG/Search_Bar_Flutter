import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/User.dart';
import '../../UserProfile/UserProfile.dart';
import '../Bloc/Users/user_block.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>  with AutomaticKeepAliveClientMixin{
  UserBloc userBloc = UserBloc();
  TextEditingController _searchController = TextEditingController();


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    // TODO: implement initState

    userBloc.add(UserInitialEvent());
    super.initState();
  }
  //for implementing search
  applySearch(String value) {
    userBloc.add(UserSearchUserEvent(value));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 500
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                //app Bar
                Text(
                  "Users",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),

                //for custom search Bar
                SearchBarCustom(),


                Expanded(
                  flex: 1,
                  child: BlocBuilder<UserBloc, UserState>(
                    bloc: userBloc,
                    builder: (context, state) {
                      switch (state.runtimeType) {


                        //if sucess show data
                        case UserLoadedSuccessState:
                          final sucessState = state as UserLoadedSuccessState;

                          return ListView.builder(
                            itemCount: sucessState.tampUsers.length,
                            itemBuilder: (context, index) {
                              return partnerDataWidget(
                                  sucessState.tampUsers[index]);
                            },
                          );


                          //for loading show
                        case UserLoadingState:
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    )),
                                Text(
                                  "Loading...",
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ]);




                          //if item not found show the screen
                        case UserNotFoundState:
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "No User Found",
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ]);


                          //for not matching state found
                        default:
                          return Text(
                            "nothing",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          );
                      }
                    },
                  ),
                ),

                //for all  text profile data
              ],
            ),
          ),
        ),
      ),
    );
  }



  //all widget parts here
  Widget partnerDataWidget(User partner) {
    return GestureDetector(
      onTap: () {
        // partnerBloc.add(PartnerViewedEvent(partner.id));

        Navigator.push( context, MaterialPageRoute( builder: (context) => UserProfile(user:partner)), ).then((value) => setState(() {}));
        // go to person widget
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => UserProfile(user: partner)),
        // );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),


        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Icon(Icons.image),
            ),

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partner.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    partner.gender,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ],
              ),
            ) // Button text
          ],
        ),
      ),
    );
  }



  Widget SearchBarCustom() {
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: TextField(
          controller: _searchController,
          onChanged: (value) => applySearch(value),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: Icon(Icons.search, color: Colors.black),
          ),
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    );

  }

}
