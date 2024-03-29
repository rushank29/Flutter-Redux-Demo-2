import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';

class AddUserDataAction {
  final UserDetailsModel userDetailsModel;

  AddUserDataAction({required this.userDetailsModel});
}

class UpdateUserDataAction {
  final UserDetailsModel userDetailsModel;

  UpdateUserDataAction({required this.userDetailsModel});
}

class DeleteUserDataAction {
  final int index;

  DeleteUserDataAction({required this.index});
}
