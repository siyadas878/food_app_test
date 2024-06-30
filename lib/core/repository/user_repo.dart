import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<UserModel?> getUser() async {
    print('hello==================');
    final box = GetStorage();
    String uid = box.read('user');
    print('UID======${uid}');
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
