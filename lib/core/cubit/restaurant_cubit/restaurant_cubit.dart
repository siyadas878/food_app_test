import 'package:bloc/bloc.dart';
import 'package:food_app/core/models/restaurant_model.dart';
import 'package:food_app/core/repository/restaurant_repo.dart';
part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepo restaurantRepo;
  RestaurantCubit({required this.restaurantRepo}) : super(RestaurantInitial());
  getAllRestaurant() async {
    emit(RestaurantListingLoadingState());
    try {
      final allRestaurant = await restaurantRepo.getAllRestaurant();
      emit(RestaurantListingSuccessState(allRestaurants: allRestaurant!));
    } catch (e) {
      emit(RestaurantListingErrorState());
    }
  }
}
