part of 'restaurant_cubit.dart';

abstract class RestaurantState {}

final class RestaurantInitial extends RestaurantState {}

// for fetching all the items

class RestaurantListingFetchingState extends RestaurantState {}

class RestaurantListingLoadingState extends RestaurantListingFetchingState {}

class RestaurantListingSuccessState extends RestaurantListingFetchingState {
  final RestaurantModel allRestaurants;

  RestaurantListingSuccessState({required this.allRestaurants});
}

class RestaurantListingErrorState extends RestaurantListingFetchingState {}
