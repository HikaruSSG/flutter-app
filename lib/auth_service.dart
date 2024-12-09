import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  final String _baseUrl = 'https://flutter-api-sd0r.onrender.com';
  final String _token =
      'a20bd0cff00f48c31b0ca158c3951dcd9654a0a0935158985d624c57e5a42930f924362ff452255a096294994509ac63bba8f5bc19cce4f248d4a71328583c08dd9fb35899855b0ee830d8125113a585d4c7c089f824cb4f4e58204f6d8de97eb7472ca02fe9f1aa346cfd316caada77e278cc6b0aae850cfc8a29cca80e63a1';

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/local'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({
        'identifier': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonData['user']);
      await prefs.setString('token', jsonData['jwt']);
    } else {
      final errorMessage = jsonDecode(response.body)['error']['message'];
      throw Exception('Failed to login: $errorMessage');
    }
  }

  Future<http.Response> signup(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/auth/local/register'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(jsonData['user']));
      await prefs.setString('token', jsonData['jwt']);
    } else {
      final errorMessage = jsonDecode(response.body)['error']['message'];
      throw Exception('Failed to sign up: $errorMessage');
    }

    return response;
  }
}
