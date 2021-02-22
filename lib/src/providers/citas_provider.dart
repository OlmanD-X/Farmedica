import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:appfarmedica/src/models/area_model.dart';
import 'package:appfarmedica/src/models/cita_model.dart';
import 'package:appfarmedica/src/models/doctor_model.dart';
import 'package:appfarmedica/src/models/horario_model.dart';

class CitasProvider {
  Future<List<CitaModel>> getCitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/cita/list?id_usuario=$id',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<CitaModel> listCitas = [];
    for (var item in decodedData['data']) {
      final cita = CitaModel.fromJSON(item);
      listCitas.add(cita);
    }
    return listCitas;
  }

  Future<List<CitaModel>> getCitasQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/cita/list?id_usuario=$id',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<CitaModel> listCitas = [];
    for (var item in decodedData['data']) {
      final cita = CitaModel.fromJSON(item);
      listCitas.add(cita);
    }
    List<CitaModel> listCitas2 = listCitas
        .where((element) =>
            element.fechaCita.contains(query) || element.state.contains(query))
        .toList();
    return listCitas2;
  }

  Future<List<Area>> getAreas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.get(
        'https://farmedica-server.herokuapp.com/area/list',
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<Area> listAreas = [];
    for (var item in decodedData['data']) {
      final area = Area.fromJSON(item);
      listAreas.add(area);
    }
    return listAreas;
  }

  Future<List<Doctor>> getDoctors(int area, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/doctor/list',
        body: {'area': area.toString(), "fecha": date},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<Doctor> listDoctors = [];
    for (var item in decodedData['data']) {
      final doctor = Doctor.fromJSON(item);
      listDoctors.add(doctor);
    }
    return listDoctors;
  }

  Future<List<List<Horario>>> getHorario(int doctor, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/horario/list',
        body: {'id_doctor': doctor.toString(), "fecha": date},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    List<List<Horario>> listHorario = [];
    for (var i = 0; i < decodedData['data'].length; i += 2) {
      final horario = Horario.fromJSON(decodedData['data'][i]);
      List<Horario> auxList = [horario];
      if ((i + 1) < decodedData['data'].length) {
        final horario1 = Horario.fromJSON(decodedData['data'][i + 1]);
        auxList.add(horario1);
      }

      listHorario.add(auxList);
    }
    return listHorario;
  }

  Future<Map<String, dynamic>> reservarCita(int horario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id = prefs.getInt('userId');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/cita/create',
        body: {'id_horario': horario.toString(), "id_usuario": id.toString()},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<Map<String, dynamic>> cancelarCita(int cita) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/cita/estado?id=${cita.toString()}',
        body: {'estado': 3.toString()},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<Map<String, dynamic>> postergarCita(int cita) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await http.post(
        'https://farmedica-server.herokuapp.com/cita/estado?id=${cita.toString()}',
        body: {'estado': 2.toString()},
        headers: {'auth': token});
    final decodedData = json.decode(response.body);
    return decodedData;
  }
}
