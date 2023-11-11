// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medica/config/config.dart';
import 'package:medica/data/models/user_model.dart';
import 'package:medica/viewmodels/auth_view_models/auth.dart';

class SignUpViewModel extends ChangeNotifier {
  bool obsecurePassword = true;
  bool obsecurePassword2 = true;
  final UserModel user = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    imageFile: File('assets/default.jpg'),
  );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void updateFirstName(String value) {
    user.firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    user.lastName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    user.email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    user.password = value;
    notifyListeners();
  }

  void updateImageFile(File newImageFile) {
    user.imageFile = newImageFile;
    notifyListeners();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Config.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool confirmPassword(BuildContext context) {
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBarMessage(context, 'please confirm your password');
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  bool confirmEmail(BuildContext context) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    final email = emailController.text.trim();
    if (!regex.hasMatch(email)) {
      showSnackBarMessage(context, 'Enter a valid email address');
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void togglePasswordVisibility() {
    obsecurePassword = !obsecurePassword;
    notifyListeners();
  }

  void togglePasswordVisibility2() {
    obsecurePassword2 = !obsecurePassword2;
    notifyListeners();
  }

  void updatePhoto(File photo) {
    // File newImageFile = File(photo);
    if (photo.existsSync()) {
      updateImageFile(photo);
      notifyListeners();
    } else {
      print("The file does not exist at the specified path.");
    }
  }

  void controllerToString() {
    user.updateFirstName(firstNameController.text.trim());
    user.updateLastName(lastNameController.text.trim());
    user.updateEmail(emailController.text.trim());
    user.updatePassword(passwordController.text.trim());
  }
  /*
    need to test this more to reduce the complexity
    the methode that save hte user to firebase and the one how savehis profile pic
  */

  // Function to save the user to Firestore
  Future<void> saveUserToFirestore(UserModel user, String userUid) async {
    try {
      final clientsRef = _firestore.collection('clients');
      final documentRef = clientsRef.doc(userUid);
      await documentRef.set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'password': user.password,
        // Add other user properties as needed
      });
    } catch (e) {
      print("Error saving user to Firestore: $e");
    }
  }

  Future<String> uploadProfilePicture(UserModel user, String userUID) async {
    if (user.imageFile == null) {
      // No image provided, use the default image from assets
      try {
        final defaultImageBytes =
            await rootBundle.load('assets/images/default.jpg');
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child(userUID);
        await storageRef.putData(defaultImageBytes.buffer.asUint8List());

        final downloadURL = await storageRef.getDownloadURL();
        return downloadURL;
      } catch (e) {
        print(
            "Error uploading default profile picture to Firebase Storage: $e");
        return '';
      }
    }

    // // Image is provided, upload it
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child(userUID);
      await storageRef.putFile(user.imageFile!);

      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading profile picture to Firebase Storage: $e");
      return '';
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      controllerToString(); // Update the UserModel with form data
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await saveUserToFirestore(user, uid);
      print('created the user');
      await uploadProfilePicture(user, uid);
      print('saved the profile pic ');
      // Show a success message or navigate to a different screen here
    } on FirebaseAuthException catch (e) {
      //display an error message must
      print("Firebase Authentication Error: ${e.message}");
    } catch (e) {
      print("~~~Error saving user to Firestore: $e");
      // Handle the Firestore save error as needed
    }
  }
}
