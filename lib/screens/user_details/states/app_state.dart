import 'form_data_state.dart';

class AppState {
  final FormDataState formDataState;

  AppState({required this.formDataState});

  factory AppState.initial() {
    return AppState(
      formDataState: FormDataState.initial(),
    );
  }

  static AppState? fromJson(dynamic json) {
    return json != null
        ? AppState(
            formDataState: FormDataState.fromJson(json['form_data_state'])!,
          )
        : null;
  }

  dynamic toJson() {
    return {
      'form_data_state': formDataState.toJson(),
    };
  }

  AppState copyWith(FormDataState formDataState) {
    return AppState(formDataState: formDataState);
  }
}
