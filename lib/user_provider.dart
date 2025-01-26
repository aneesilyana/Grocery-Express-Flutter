import 'dart:io';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _fullName;
  String? _email;
  File? _profilePicture;
  String? _phoneNumber;
  String? _address;

  // Getters
  String? get fullName => _fullName;
  String? get email => _email;
  File? get profilePicture => _profilePicture;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;

  // Setters
  void setFullName(String fullName) {
    _fullName = fullName;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setProfilePicture(File profilePicture) {
    _profilePicture = profilePicture;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  // Update multiple fields at once
  void updateUser({
    String? fullName,
    String? email,
    File? profilePicture,
    String? phoneNumber,
    String? address,
  }) {
    if (fullName != null) _fullName = fullName;
    if (email != null) _email = email;
    if (profilePicture != null) _profilePicture = profilePicture;
    if (phoneNumber != null) _phoneNumber = phoneNumber;
    if (address != null) _address = address;

    notifyListeners(); // Notify listeners to rebuild UI
  }

  // Reset the user's profile (e.g., on logout)
  void clearUserProfile() {
    _fullName = null;
    _email = null;
    _profilePicture = null;
    _phoneNumber = null;
    _address = null;
    notifyListeners();
  }

  // Populate user's profile with default or initial values
  void setDefaultUserProfile({
    String? fullName,
    String? email,
    File? profilePicture,
    String? phoneNumber,
    String? address,
  }) {
    _fullName = fullName ?? "Guest";
    _email = email ?? "guest@example.com";
    _profilePicture = profilePicture;
    _phoneNumber = phoneNumber ?? "No Phone";
    _address = address ?? "No Address";
    notifyListeners();
  }
}
