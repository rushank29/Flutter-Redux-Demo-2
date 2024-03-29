import 'user_state.dart';

class AppState {
  final UserState userState;

  AppState({required this.userState});

  factory AppState.initial() {
    return AppState(
      userState: UserState.initial(),
    );
  }

  static AppState? fromJson(dynamic json) {
    return json != null
        ? AppState(
            userState: UserState.fromJson(json['user_state'])!,
          )
        : null;
  }

  dynamic toJson() {
    return {
      'user_state': userState.toJson(),
    };
  }

  AppState copyWith(UserState formDataState) {
    return AppState(userState: formDataState);
  }
}
