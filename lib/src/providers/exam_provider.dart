import 'dart:convert';

import 'package:appfarmedica/src/models/examen_create_model.dart';
import 'package:appfarmedica/src/models/examen_model.dart';
import 'package:appfarmedica/src/models/receta_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExamenesProvider {
  Future<List<Examen>> getHorarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/cita_examen/list?id_usuario=$id',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<Examen> listCitas = [];
    for (var item in decodedData['data']) {
      final examen = Examen.fromJSON(item);
      listCitas.add(examen);
    }
    return listCitas;
  }

  Future<List<Examen>> getHorariosQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/cita_examen/list?id_usuario=$id',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<Examen> listCitas = [];
    for (var item in decodedData['data']) {
      final examen = Examen.fromJSON(item);
      listCitas.add(examen);
    }

    List<Examen> queryExamen = listCitas
        .where((element) =>
            element.fechaCita.contains(query) ||
            element.state.contains(query) ||
            element.examen.contains(query))
        .toList();
    return queryExamen;
  }

  Future<Map<String, dynamic>> cancelarExamen(int examen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/cita_examen/estado?id=${examen.toString()}',
        body: {'estado': 3.toString()},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<Map<String, dynamic>> postergarExamen(int examen, String fecha) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/cita_examen/update?id=${examen.toString()}',
        body: {'fecha_postergacion': fecha},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<List<ExamenCreate>> getExamenes(
      int area, String date, String turno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/examen/list',
        body: {'area': area.toString(), "fecha": date, "turno": turno},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<ExamenCreate> listDoctors = [];
    for (var item in decodedData['data']) {
      final doctor = ExamenCreate.fromJSON(item);
      listDoctors.add(doctor);
    }
    return listDoctors;
  }

  Future<List<Receta>> getRecetas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/receta/listUsuario?id_usuario=$id',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<Receta> listCitas = [];
    for (var item in decodedData['data']) {
      final examen = Receta.fromJSON(item);
      listCitas.add(examen);
    }
    return listCitas;
  }

  Future<List<Receta>> getRecetasQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/receta/listUsuario?id_usuario=$id',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<Receta> listCitas = [];
    for (var item in decodedData['data']) {
      final examen = Receta.fromJSON(item);
      listCitas.add(examen);
    }
    List<Receta> listCitas2 = listCitas
        .where((element) => element.fechaCita.contains(query))
        .toList();
    return listCitas2;
  }

  Future<Map<String, dynamic>> reservarExamen(int horario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/cita_examen/create',
        body: {'id_horario': horario.toString(), "id_usuario": id.toString()},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    return decodedData;
  }
}
