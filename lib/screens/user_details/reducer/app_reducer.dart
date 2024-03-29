import 'package:flutter_redux_demo_2/screens/user_details/actions/actions.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/app_state.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/form_data_state.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    formDataState: formReducer(state.formDataState, action),
  );
}

final formReducer = combineReducers<FormDataState>([
  TypedReducer<FormDataState, UpdateUserDataAction>(_updateUserDataAction),
]);

FormDataState _updateUserDataAction(FormDataState state, UpdateUserDataAction action) {
  return state.copyWith(action.userDetailsModel);
}
