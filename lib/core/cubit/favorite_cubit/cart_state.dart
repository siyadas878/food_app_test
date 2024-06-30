part of 'cart_cubit.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

class CartFetchingState extends CartState {}

class CartLoadingState extends CartFetchingState {}

class CartSuccessState extends CartFetchingState {
  final List<CategoryDishes> allCarts;
  final double totalPrice;

  CartSuccessState({required this.allCarts, required this.totalPrice});
}

class CartErrorState extends CartFetchingState {}

class AddCartInitialState extends CartState {}

class AddCartLoadingState extends AddCartInitialState {}

class AddCartSuccessState extends AddCartInitialState {}

class AddCartErrorState extends AddCartInitialState {}

class RemoveCartInitialState extends CartState {}

class RemoveCartLoadingState extends RemoveCartInitialState {}

class RemoveCartSuccessState extends RemoveCartInitialState {}

class RemoveCartErrorState extends RemoveCartInitialState {}
