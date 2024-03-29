import 'dart:async';
import 'package:flutter_redux_demo_2/constants/lists_and_enums.dart';
import 'package:flutter_redux_demo_2/screens/user_details/model/user_details_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_demo_2/screens/user_details/model/selection_model.dart';

class UpdateUserBloc {
  final BuildContext context;

  UpdateUserBloc({required this.context}) {
    languageSink.add(languageList);
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  String selectedLanguage = "";
  String countryDropdownValue = countryList.first;
  String selectedGender = genderList.last.selectedName;

  //  Gender
  final _genderSubject = BehaviorSubject<String>();

  StreamSink<String> get genderSink => _genderSubject.sink;

  Stream<String> get genderStream => _genderSubject.stream;

  //  Country
  final _countryDropDownSubject = BehaviorSubject<String>();

  StreamSink<String> get countryDropDownSink => _countryDropDownSubject.sink;

  Stream<String> get countryDropDownStream => _countryDropDownSubject.stream;

  // Language
  final _languageSubject = BehaviorSubject<List<SelectionModel>>();

  Stream<List<SelectionModel>> get languageStream => _languageSubject.stream;

  StreamSink<List<SelectionModel>> get languageSink => _languageSubject.sink;

  changeLanguageList(SelectionModel languageModel, bool value) {
    List<SelectionModel> newLanguageList = _languageSubject.valueOrNull ?? [];
    for (var element in newLanguageList) {
      if (element.selectedName == languageModel.selectedName) {
        element.value = value;
      }
    }
    languageSink.add(newLanguageList);
  }

  //  get Languages from the list
  String getLanguages() {
    List<SelectionModel> updatedLanguageList = _languageSubject.valueOrNull ?? [];
    for (var element in updatedLanguageList) {
      if (element.value) {
        selectedLanguage = '$selectedLanguage' '${element.selectedName},';
      }
    }
    return selectedLanguage;
  }

  // get selected language and set into languageList, when screen data come from listview
  setInitialSelectedLanguage(String selectedLanguage) {
    List<SelectionModel> list = _languageSubject.valueOrNull ?? [];
    List<String> langList = selectedLanguage.split(',');
    for (var element in list) {
      if (langList.contains(element.selectedName)) {
        element.value = true;
      }
    }
    languageSink.add(list);
  }

  // get the selected country when screen data comes from listview
  String? getSelectedCountry(String country) {
    String selectedCountry = country;
    // String selectedCountry = "";
    if (countryList.contains(selectedCountry)) {
      for (int i = 0; i < countryList.length; i++) {
        if (countryList[i] == selectedCountry) {
          return countryDropdownValue = countryList[i];
        } else {
          continue;
        }
      }
    }
    return null;
  }

  UserDetailsModel storeUserValuesInModel() {
    return UserDetailsModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      age: ageController.text.trim(),
      contactNo: contactController.text.trim(),
      gender: selectedGender,
      city: cityController.text.trim(),
      country: countryDropdownValue,
      knownLanguages: getLanguages(),
    );
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    contactController.dispose();
    cityController.dispose();
    _genderSubject.close();
    _countryDropDownSubject.close();
    _languageSubject.close();
  }

// //  initializing the controller values
// void getInitializedValue() {
//   firstNameController = TextEditingController(text: firstName);
//   lastNameController = TextEditingController(text: lastName);
//   ageController = TextEditingController(text: age);
//   contactController = TextEditingController(text: contact);
//   cityController = TextEditingController(text: city);
//   country == null ? countryDropdownValue = countryList.first : getSelectedCountry();
//   language == null ? '' : setInitialSelectedLanguage(selectedLanguage);
//   if (gender == 'Male') {
//     selectedGender = genderList[0].selectedName;
//   } else if (gender == 'Female') {
//     selectedGender = genderList[1].selectedName;
//   } else {
//     selectedGender = genderList[2].selectedName;
//   }
// }
}
