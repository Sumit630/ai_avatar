import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  String apiURL="https://randomuser.me/api/?results=50";
  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = true;

  String _selectedGender = 'Male';
  String _selectedAgeRange = '18-30';
  String searchQuery = '';

  List<UserModel> get users => _users;
  List<UserModel> get filteredUsers => _filteredUsers;
  bool get isLoading => _isLoading;
  String get selectedGender => _selectedGender;
  String get selectedAgeRange => _selectedAgeRange;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();
    final response =
    await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      _users = results.map((json) => UserModel.fromJson(json)).toList();
      applyFilters();
    } else {
      _users = [];
      _filteredUsers = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  void updateGender(String? gender) {
    _selectedGender = gender ?? 'Male';
    applyFilters();
  }

  void updateAgeRange(String? range) {
    _selectedAgeRange = range ?? '18-30';
    applyFilters();
  }

  void updateSearchQuery(String query) {
    searchQuery = query.toLowerCase().trim();
    applyFilters();
  }

  void applyFilters() {
    _filteredUsers = _users.where((user) {
      final matchesGender = user.gender.toLowerCase() == _selectedGender.toLowerCase();
      final matchesSearch = user.fullName.toLowerCase().contains(searchQuery);
      final matchesAge = matchAge(user.age);
      return matchesGender && matchesSearch && matchesAge;
    }).toList();
    notifyListeners();
  }

  bool matchAge(int age) {
    switch (_selectedAgeRange) {
      case '18-30':
        return age >= 18 && age <= 30;
      case '31-45':
        return age >= 31 && age <= 45;
      case '45+':
        return age > 45;
      default:
        return true;
    }
  }
}
