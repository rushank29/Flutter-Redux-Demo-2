import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';

class UserState {
  final List<UserDetailsModel> usersList;

  UserState({required this.usersList});

  factory UserState.initial() {
    return UserState(
      usersList: [],
    );
  }

  static UserState? fromJson(dynamic json) {
    return json != null
        ? UserState(
      usersList: parseList(json),
    )
        : null;
  }

  dynamic toJson() {
    return {
      'user_list': usersList.map((item) =>item.toJson()).toList(),
    };
  }


  UserState copyWith(List<UserDetailsModel> usersList) {
    return UserState(usersList: usersList);
  }
}

List<UserDetailsModel> parseList(dynamic json) {
  List<UserDetailsModel> list = <UserDetailsModel>[];
  json["user_list"].forEach((item) => list.add(UserDetailsModel.fromJson(item)!));
  return list;
}
