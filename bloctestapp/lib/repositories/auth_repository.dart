import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';


import '../models/user.dart';
import '../services/api_service.dart';


class AuthRepository {
final ApiService apiService;
final SharedPreferences prefs;
static const _tokenKey = 'auth_token';
static const _userKey = 'auth_user';


AuthRepository({required this.apiService, required this.prefs});


Future<Map<String, dynamic>> login(String email, String password) async {
final res = await apiService.login(email, password);
final token = res['token'] as String;
final user = res['user'] as User;
// persist
await persistToken(token, user);
return {'token': token, 'user': user};
}


Future<void> persistToken(String token, User user) async {
await prefs.setString(_tokenKey, token);
await prefs.setString(_userKey, jsonEncode(user.toJson()));
}


Future<bool> hasToken() async {
return prefs.containsKey(_tokenKey);
}


Future<User?> getUser() async {
final raw = prefs.getString(_userKey);
if (raw == null) return null;
return User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}


Future<void> deleteToken() async {
await prefs.remove(_tokenKey);
await prefs.remove(_userKey);
}
}