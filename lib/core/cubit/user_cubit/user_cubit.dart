import 'package:bloc/bloc.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/core/repository/user_repo.dart';
import 'package:food_app/widgets/custom_snackBar.dart';
import 'package:get/get.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  UserCubit({required this.userRepo}) : super(UserInitial());
  getAllUsers(String mobile, bool isLogin, UserModel data) async {
    emit(AllUsersLoadingState());
    List<String> numbers = [];
    try {
      await userRepo.getAllUsers().then(
        (value) {
          for (var element in value) {
            print('numbers=${element.mobile}');
            numbers.add(element.mobile!);
          }
        },
      );
      if (numbers.contains(mobile) && isLogin == true) {
        Get.toNamed("/otpScreen", arguments: {
          'isLogin': true,
          'data':
              UserModel(email: '', mobile: data.mobile, name: '', password: '')
        });
      } else if (numbers.contains(mobile) && isLogin == false) {
      } else {
        Get.back();
        customSnackBar(title: 'Failed', message: 'MObile Number Already Used');
      }

      emit(AllUsersSuccessState());
    } catch (e) {
      print('Error=====${e.toString()}');
      emit(AllUsersErrorState());
    }
  }

  getUser() async {
    emit(SingleUsersLoadingState());
    try {
      final singleUsers = await userRepo.getUser();
      emit(SingleUsersSuccessState(user: singleUsers!));
    } catch (e) {
      emit(SingleUsersErrorState());
    }
  }
}
