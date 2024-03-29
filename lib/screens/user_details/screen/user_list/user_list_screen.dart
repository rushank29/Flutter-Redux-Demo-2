import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_demo_2/screens/user_details/actions/actions.dart';
import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';
import 'package:flutter_redux_demo_2/screens/user_details/screen/update_user/edit_user_screen.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/app_state.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StoreConnector<AppState, List<UserDetailsModel>>(
          converter: (store) => store.state.userState.usersList,
          builder: (BuildContext context, List<UserDetailsModel> usersList) {
            return ListView.separated(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text("${index + 1}")),
                  title: Text("${usersList[index].firstName} ${usersList[index].lastName}"),
                  subtitle: Text("${usersList[index].country}"),
                  trailing: Icon(usersList[index].gender == 'Male' ? Icons.male : Icons.female),
                  onLongPress: () {
                    deleteUser(index, "${usersList[index].firstName} ${usersList[index].lastName}");
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserScreen(
                          title: 'Update User',
                          userDetailsModel: usersList[index],
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateUserScreen(
                title: 'Add User',
                userDetailsModel: UserDetailsModel(
                  firstName: '',
                  lastName: '',
                  age: '',
                  contactNo: '',
                  gender: '',
                  city: '',
                  country: '',
                  knownLanguages: '',
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteUser(int index, String username) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          // content: const Text('Are you sure you want to delete this user from the list?'),
          content: RichText(
            text: TextSpan(
              text: "Are you sure you want to delete ",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              children: <TextSpan>[
                TextSpan(
                    text:
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: ' from the list?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                StoreProvider.of<AppState>(context).dispatch(DeleteUserDataAction(index: index));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
