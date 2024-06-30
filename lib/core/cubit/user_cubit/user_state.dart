part of 'user_cubit.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

//get all users states

class AllUsersState extends UserState {}

class AllUsersLoadingState extends AllUsersState {}

class AllUsersSuccessState extends AllUsersState {}

class AllUsersErrorState extends AllUsersState {}

//get a singe users states

class SingleUsersState extends UserState {}

class SingleUsersLoadingState extends SingleUsersState {}

class SingleUsersSuccessState extends SingleUsersState {
  final UserModel user;
  SingleUsersSuccessState({required this.user});
}

class SingleUsersErrorState extends SingleUsersState {}
