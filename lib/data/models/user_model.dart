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

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;
  File? get imageFile => _imageFile;

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
