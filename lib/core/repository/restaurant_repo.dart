import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:food_app/core/models/restaurant_model.dart';
import 'package:food_app/widgets/custom_snackBar.dart';
import 'package:http/http.dart' as http;

class RestaurantRepo {
  Future<RestaurantModel?> getAllRestaurant() async {
    try {
      final response = await http.get(Uri.parse(
          'https://run.mocky.io/v3/7e05b7d7-5391-4a61-b47c-c30b3fdcfcff'));
      if (response.statusCode == 200) {
        final RestaurantModel restaurantList =
            RestaurantModel.fromJson(jsonDecode(response.body)[0]);

        return restaurantList;
      } else {
        customSnackBar(title: 'Error', message: 'Somthing went wrong');
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
      }
    } catch (e) {
      customSnackBar(title: 'Error', message: 'Somthing went wrong');
      log(e.toString());
    }
    return null;
  }
}
