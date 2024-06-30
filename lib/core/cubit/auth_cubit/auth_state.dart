part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

// SignUp states

class UserSignUpFetchState extends AuthState {}

class UserSignUpLoadingState extends UserSignUpFetchState {}

class UserSignUpSuccessState extends UserSignUpFetchState {}

class UserSignUpErrorState extends UserSignUpFetchState {}

// SignIn states

class UserSignIpFetchState extends AuthState {}

class UserSigInLoadingState extends UserSignIpFetchState {}

class UserSignInSuccessState extends UserSignIpFetchState {}

class UserSignInErrorState extends UserSignIpFetchState {}
