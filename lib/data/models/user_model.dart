// ignore_for_file: unnecessary_getters_setters
import 'dart:io';

class UserModel {
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  File? _imageFile;

  UserModel({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    File? imageFile,
  })  : _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _password = password,
        _imageFile = imageFile;

  // Another constructor
  //i will use it for the login page to give null values to all except the email and password
  // UserModel.fromMap(Map<String, dynamic> map)
  //     : _firstName = map['firstName'] ?? '',
  //       _lastName = map['lastName'] ?? '',
  //       _email = map['email'] ?? '',
  //       _password = map['password'] ?? '',
  //       _imageFile = File(map['imageFilePath']);

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;
  File? get imageFile => _imageFile;

  set firstName(String newFirstName) {
    _firstName = newFirstName;
  }

  set lastName(String newLastName) {
    _lastName = newLastName;
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  set password(String newPassword) {
    _password = newPassword;
  }

  set imageFile(File? newImageFile) {
    _imageFile = newImageFile;
  }

  void updateFirstName(String newFirstName) {
    _firstName = newFirstName;
  }

  void updateLastName(String newLastName) {
    _lastName = newLastName;
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
  }

  void updatePassword(String newPassword) {
    _password = newPassword;
  }

  void updateImageFile(File? newImageFile) {
    _imageFile = newImageFile;
  }
}
