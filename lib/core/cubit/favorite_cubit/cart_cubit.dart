import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/models/restaurant_model.dart';
import 'package:food_app/core/repository/cart_repo.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  CartCubit({required this.cartRepo}) : super(CartInitial());
  getCarts() async {
    emit(CartLoadingState());
    try {
      final allCarts = await cartRepo.getCarts();
      double totalPrice = allCarts.fold(0, (sum, item) => sum + item.dishPrice);
      emit(CartSuccessState(allCarts: allCarts, totalPrice: totalPrice));
    } catch (e) {
      emit(CartErrorState());
    }
  }

  getCartsWithoutLoading() async {
    emit(CartLoadingState());
    try {
      final allCarts = await cartRepo.getCarts();
      double totalPrice = allCarts.fold(0, (sum, item) => sum + item.dishPrice);
      emit(CartSuccessState(allCarts: allCarts, totalPrice: totalPrice));
    } catch (e) {
      emit(CartErrorState());
    }
  }

  addCarts(CategoryDishes foodItem) async {
    try {
      await cartRepo.addFoodToCart(foodItem).then(
        (value) {
          cartRepo.getCarts();
        },
      );
      emit(AddCartSuccessState());
    } catch (e) {
      emit(AddCartErrorState());
    }
  }

  removeCarts(String foodId, BuildContext context) async {
    emit(RemoveCartLoadingState());
    try {
      await cartRepo.removeFoodFromCart(foodId).then(
        (value) {
          BlocProvider.of<CartCubit>(context).getCartsWithoutLoading();
        },
      );
      emit(RemoveCartSuccessState());
    } catch (e) {
      emit(RemoveCartErrorState());
    }
  }
}
