import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String email;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.profilePicture,
  });

  // Helper function to get full name
  String get fullName => '$firstname $lastname';

  //function to split full name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //function to generate a username fromm the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstname = nameParts[0].toLowerCase();
    String lastname = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstname$lastname"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  //function to create empty user model
  static UserModel empty() => UserModel(
      id: '', firstname: '', lastname: '', email: '', profilePicture: '');

  //convert model to json structure
  Map<String, dynamic> toJson() {
    return {
      'Firstname': firstname,
      'LastName': lastname,
      'Email': email,
      'ProfilePicture': profilePicture,
    };
  }

  //method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstname: data['Firstname'] ?? '',
        lastname: data['Lastname'] ?? '',
        email: data['Email'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
