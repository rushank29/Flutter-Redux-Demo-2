import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_demo_2/constants/borders_and_constants.dart';
import 'package:flutter_redux_demo_2/constants/dimens.dart';
import 'package:flutter_redux_demo_2/constants/lists_and_enums.dart';
import 'package:flutter_redux_demo_2/screens/user_details/actions/actions.dart';
import 'package:flutter_redux_demo_2/screens/user_details/model/selection_model.dart';
import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';
import 'package:flutter_redux_demo_2/screens/user_details/screen/update_user/edit_user_bloc.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/app_state.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({
    super.key,
    required this.title,
    required this.userDetailsModel,
  });

  final String title;
  final UserDetailsModel userDetailsModel;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late UpdateUserBloc _updateUserBloc;

  @override
  void dispose() {
    _updateUserBloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _updateUserBloc = UpdateUserBloc(context: context, userDetailsModel: widget.userDetailsModel);
    _updateUserBloc.getInitializedValue();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.title == 'Update User'
                          ? "*Contact numbers are read only and are non-editable."
                          : "",
                      style: TextStyle(color: Colors.red[300]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _updateUserBloc.firstNameController,
                      // onChanged: (val) => validation.sinkEmail.add(val),
                      decoration: InputDecoration(
                        hintText: 'Firstname',
                        labelText: 'Firstname',
                        labelStyle: const TextStyle(color: Colors.black54),
                        border: kNonFocusBorder,
                        focusedBorder: kFocusedBorder,
                        errorBorder: kErrorBorder,
                      ),
                      cursorColor: Colors.black87,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: TextFormField(
                      controller: _updateUserBloc.lastNameController,
                      // onChanged: (val) => validation.sinkEmail.add(val),
                      decoration: InputDecoration(
                        hintText: 'Lastname',
                        labelText: 'Lastname',
                        labelStyle: const TextStyle(color: Colors.black54),
                        border: kNonFocusBorder,
                        focusedBorder: kFocusedBorder,
                        errorBorder: kErrorBorder,
                      ),
                      cursorColor: Colors.black87,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _updateUserBloc.ageController,
                      // onChanged: (val) => validation.sinkEmail.add(val),
                      decoration: InputDecoration(
                        hintText: 'Age',
                        labelText: 'Age',
                        labelStyle: const TextStyle(color: Colors.black54),
                        border: kNonFocusBorder,
                        focusedBorder: kFocusedBorder,
                        errorBorder: kErrorBorder,
                      ),
                      cursorColor: Colors.black87,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      controller: _updateUserBloc.contactController,
                      // onChanged: (val) => validation.sinkEmail.add(val),
                      decoration: InputDecoration(
                        hintText: 'Contact no',
                        labelText: widget.title == 'Add User' ? "Contact no" : "*Contact no",
                        labelStyle: const TextStyle(color: Colors.black54),
                        border: kNonFocusBorder,
                        focusedBorder: kFocusedBorder,
                        errorBorder: kErrorBorder,
                      ),
                      readOnly: widget.title == 'Update User' ? true : false,
                      cursorColor: Colors.black87,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Gender:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    StreamBuilder<String>(
                      stream: _updateUserBloc.genderStream,
                      builder: (context, snapshot) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 50,
                          ),
                          itemCount: genderList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTileTheme(
                              horizontalTitleGap: 2.0,
                              child: RadioListTile<String>(
                                title: Text(genderList[index].selectedName),
                                value: genderList[index].selectedName,
                                groupValue: _updateUserBloc.selectedGender,
                                onChanged: (String? value) {
                                  _updateUserBloc.selectedGender = value!;
                                  _updateUserBloc.genderSink.add(_updateUserBloc.selectedGender);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _updateUserBloc.cityController,
                      // onChanged: (val) => validation.sinkEmail.add(val),
                      decoration: InputDecoration(
                        hintText: 'City',
                        labelText: 'City',
                        labelStyle: const TextStyle(color: Colors.black54),
                        border: kNonFocusBorder,
                        focusedBorder: kFocusedBorder,
                        errorBorder: kErrorBorder,
                      ),
                      cursorColor: Colors.black87,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: kNonFocusBorder,
                        focusedBorder: kFocusedBorder,
                        label: const Text(
                          "Country",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      value: _updateUserBloc.countryDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      borderRadius: BorderRadius.circular(4),
                      menuMaxHeight: screenHeight * 0.3,
                      isExpanded: true,
                      isDense: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        _updateUserBloc.countryDropdownValue = value!;
                        _updateUserBloc.countryDropDownSink.add(_updateUserBloc.countryDropdownValue);
                      },
                      items: countryList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            maxLines: 2,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          'Please select your country';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Languages known:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    StreamBuilder<List<SelectionModel>>(
                      stream: _updateUserBloc.languageStream,
                      builder: (context, snapList) {
                        List<SelectionModel> list = snapList.data ?? [];
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            crossAxisSpacing: 30,
                            mainAxisExtent: 50,
                          ),
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            SelectionModel language = list[index];
                            return ListTileTheme(
                              horizontalTitleGap: 5.0,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                tristate: true,
                                controlAffinity: ListTileControlAffinity.leading,
                                value: language.value,
                                onChanged: (value) {
                                  _updateUserBloc.changeLanguageList(language, value ?? false);
                                },
                                title: Text(language.selectedName),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.deepPurple[100],
                  ),
                ),
                onPressed: () {
                  if (widget.title == 'Add User') {
                    StoreProvider.of<AppState>(context).dispatch(
                      AddUserDataAction(
                        userDetailsModel: _updateUserBloc.storeUserValuesInModel(),
                      ),
                    );
                    Navigator.pop(context);
                  } else if (widget.title == 'Update User') {
                    StoreProvider.of<AppState>(context).dispatch(
                      UpdateUserDataAction(
                        userDetailsModel: _updateUserBloc.storeUserValuesInModel(),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black87),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
