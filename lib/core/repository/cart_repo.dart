import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/core/models/restaurant_model.dart';
import 'package:food_app/widgets/custom_snackBar.dart';
import 'package:get_storage/get_storage.dart';

class CartRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFoodToCart(CategoryDishes foodItem) async {
    final box = GetStorage();
    String userId = box.read('user');
    print('UerID====${userId.toString()}');
    try {
      await _firestore
          .collection('myCart')
          .doc(userId)
          .collection('cart')
          .doc(foodItem.dishId)
          .set(foodItem.toJson());
      customSnackBar(title: 'Success', message: 'Food added to cart');
    } catch (e) {
      customSnackBar(title: 'Error', message: 'Something went wrong');
      print('Error: $e');
    }
  }

  Future<void> removeFoodFromCart(String FoodId) async {
    final box = GetStorage();
    String userId = box.read('user');
    try {
      await _firestore
          .collection('myCart')
          .doc(userId)
          .collection('cart')
          .doc(FoodId)
          .delete();
      customSnackBar(title: 'Success', message: 'Food removed from cart');
    } catch (e) {
      customSnackBar(title: 'Error', message: 'Something went wrong');
      print('Error: $e');
    }
  }

  Future<List<CategoryDishes>> getCarts() async {
    final box = GetStorage();
    String uid = box.read('user');
    List<CategoryDishes> cartDishes = [];
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('myCart')
          .doc(uid)
          .collection('cart')
          .get();
      cartDishes = snapshot.docs
          .map((doc) =>
              CategoryDishes.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return cartDishes;
    } catch (e) {
      customSnackBar(title: 'Error', message: 'Something went wrong');
      print('Error: $e');
      return [];
    }
  }
}
