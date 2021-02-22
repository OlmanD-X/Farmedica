import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      'https://farmedica-server.herokuapp.com/auth/login',
      body: {'username': username, 'password': password},
    );
    final decodedData = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (decodedData['status'] == null) {
      await prefs.setString('token', decodedData['auth']['token']);
      await prefs.setInt('userId', decodedData['user']['id']);
    }
    return decodedData;
  }

  Future<Map<String, dynamic>> register(
      {String username,
      String password,
      String confirmPassword,
      String email,
      String dni,
      String phone,
      String name,
      String lastName}) async {
    if (password != confirmPassword)
      return {'status': 'Error', 'message': 'Las contraseñas no coinciden'};
    final response = await http.post(
      'https://farmedica-server.herokuapp.com/user/create',
      body: {
        'username': username,
        'password': password,
        'dni': dni,
        'nombre': name,
        'apellido': lastName,
        'telefono': phone,
        'correo': email,
        'imagen': 'NULL',
      },
    );
    final decodedData = json.decode(response.body);
    return decodedData;
  }
}
