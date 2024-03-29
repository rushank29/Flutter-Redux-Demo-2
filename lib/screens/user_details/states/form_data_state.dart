import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';

class FormDataState {
  final UserDetailsModel userDetailsModel;

  FormDataState({required this.userDetailsModel});

  factory FormDataState.initial() {
    return FormDataState(
      userDetailsModel: UserDetailsModel.initial(),
    );
  }

  static FormDataState? fromJson(dynamic json) {
    return json != null
        ? FormDataState(
            userDetailsModel: UserDetailsModel.fromJson(json['user_model'])!,
          )
        : null;
  }

  dynamic toJson() {
    return {
      'user_model': userDetailsModel.toJson(),
    };
  }

  FormDataState copyWith(UserDetailsModel userDetailsModel) {
    return FormDataState(userDetailsModel: userDetailsModel);
  }
}
