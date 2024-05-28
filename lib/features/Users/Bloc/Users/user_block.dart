import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../API/FetchUsers.dart';
import '../../../../Models/User.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  //for default passing eanbility
  UserBloc() : super(UserInitialState()) {
    on<UserInitialEvent>(ItemInitialMethod);
    on<UserViewedEvent>(UserViewedMethod);
    on<UserSearchUserEvent>(UserSearchUserMethod);
  }

  User user = User("id", "name", "height", "img","height");
  bool dataFound = true;
  String userId = "sdf";

  List<User> loadedUsers = [];
  List<User> tampUsers = [];

  Future<FutureOr<void>> ItemInitialMethod(
      UserEvent event, Emitter<UserState> emit) async {

    user=User("id","name","mail","12Aug","height");

    // tampPartners.add(partner);
    // tampPartners.add(partner);
    // tampPartners.add(partner);



    emit(UserLoadingState());
    
    //fetch data from data base
    try{
      loadedUsers=await fetchUsers();
      tampUsers=loadedUsers;

    }catch(e){
      print("Error");
      emit(UserNotFoundState());
    }

    // await Future.delayed(Duration(seconds: 3));
    emit(UserLoadedSuccessState(tampUsers));
    // emit(PartnerNotFoundState());


  }

  FutureOr<void> UserViewedMethod(
      UserViewedEvent event, Emitter<UserState> emit) {

    print("ItemClicked Event");
  }

  Future<FutureOr<void>> UserSearchUserMethod(
      UserSearchUserEvent event, Emitter<UserState> emit) async {
    print("AddUser Event" + event.userName);

    emit(UserLoadingState());

    tampUsers=[];
    tampUsers=loadedUsers.where((user) => user.name.toLowerCase().contains(event.userName)).toList();

    //calculate searching


    if(tampUsers.isNotEmpty)
      emit(UserLoadedSuccessState(tampUsers));
    else
      emit(UserNotFoundState());




  }

  @override
  void onChange(Change<UserState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change.currentState);
    print("to");
    print(change.nextState);
  }

}

//all events

@immutable
abstract class UserEvent {}

//to take argument from event
class UserInitialEvent extends UserEvent {}

class UserViewedEvent extends UserEvent {
  final String UserId;

  UserViewedEvent(this.UserId);
}

class UserSearchUserEvent extends UserEvent {
  final String userName;

  UserSearchUserEvent(this.userName);
}


//all the states
@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

//for initial show,error showed and sucess data show
class UserLoadedSuccessState extends UserState {

  final List<User> tampUsers;

  // final Partner partner;

  UserLoadedSuccessState(this.tampUsers);
}

class UserNotFoundState extends UserState {}
