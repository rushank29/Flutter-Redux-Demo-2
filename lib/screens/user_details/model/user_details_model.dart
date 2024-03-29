class UserDetailsModel {
  String? firstName;
  String? lastName;
  String? age;
  String? contactNo;
  String? gender; //  Radio button
  String? city;
  String? country; //  Dropdown
  String? knownLanguages; //  Checkbox

  UserDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.contactNo,
    required this.gender,
    required this.city,
    required this.country,
    required this.knownLanguages,
  });

  static UserDetailsModel? fromJson(dynamic json) {
    return json != null
        ? UserDetailsModel(
            firstName: json['firstName'],
            lastName: json['lastName'],
            age: json['age'],
            contactNo: json['contactNo'],
            gender: json['gender'],
            city: json['city'],
            country: json['country'],
            knownLanguages: json['knownLanguages'],
          )
        : null;
  }

  dynamic toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'contactNo': contactNo,
      'gender': gender,
      'city': city,
      'country': country,
      'knownLanguages': knownLanguages,
    };
  }

  factory UserDetailsModel.initial() {
    return UserDetailsModel(
      firstName: '',
      lastName: '',
      age: '',
      contactNo: '',
      gender: '',
      city: '',
      country: '',
      knownLanguages: '',
    );
  }
}
