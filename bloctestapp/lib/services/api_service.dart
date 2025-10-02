import 'dart:async';


import '../models/user.dart';


/// Very small mock API service. Replace with real `http` calls when needed.
class ApiService {
Future<Map<String, dynamic>> login(String email, String password) async {
await Future.delayed(const Duration(seconds: 1)); // simulate network


// *Simple mocked logic* — password must be 'password' to succeed.
if (password == 'password') {
final user = User(id: 'u-1', name: 'Jaafar', email: email);
final token = 'mock-token-123';
return {'token': token, 'user': user};
}


throw Exception('Invalid credentials');
}
}