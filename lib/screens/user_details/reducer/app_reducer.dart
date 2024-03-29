import 'package:flutter_redux_demo_2/screens/user_details/actions/actions.dart';
import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/app_state.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/user_state.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: formReducer(state.userState, action),
  );
}

final formReducer = combineReducers<UserState>([
  TypedReducer<UserState, AddUserDataAction>(_addUserDataAction),
  TypedReducer<UserState, UpdateUserDataAction>(_updateUserDataAction),
  TypedReducer<UserState, DeleteUserDataAction>(_deleteUserDataAction),
]);

UserState _addUserDataAction(UserState state, AddUserDataAction action) {
  List<UserDetailsModel> listOfUsers = state.usersList;
  listOfUsers.add(action.userDetailsModel);
  return state.copyWith(listOfUsers);
}

UserState _updateUserDataAction(UserState state, UpdateUserDataAction action) {
  List<UserDetailsModel> listOfUsers = state.usersList;
  // return state.copyWith(action.userDetailsModel);
  for (int i = 0; i < listOfUsers.length; i++) {
    if (listOfUsers[i].contactNo == action.userDetailsModel.contactNo) {
      print("Element ========> ${listOfUsers[i].contactNo}");
      print("action.userDetailsModel ==========> ${action.userDetailsModel.firstName}");
      listOfUsers[i] = action.userDetailsModel;
    } else {
      continue;
    }
  }
  return state.copyWith(listOfUsers);
}

UserState _deleteUserDataAction(UserState state, DeleteUserDataAction action) {
  List<UserDetailsModel> listOfUsers = state.usersList;
  listOfUsers.removeAt(action.index); //  index from screen to delete that particular user from list of models
  return state.copyWith(listOfUsers);
}
