import 'package:appfarmedica/src/pages/Citas/areas_examen_page.dart';
import 'package:appfarmedica/src/pages/Citas/detail_cita_page.dart';
import 'package:appfarmedica/src/pages/Citas/detail_receta_page.dart';
import 'package:appfarmedica/src/pages/Citas/select_examen_page.dart';
import 'package:appfarmedica/src/pages/Citas/verify_cita_page.dart';
import 'package:appfarmedica/src/pages/Home/info_page.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/pages/Citas/select_area_page.dart';
import 'package:appfarmedica/src/pages/Home/home_page.dart';
import 'package:appfarmedica/src/pages/Login/login_page.dart';
import 'package:appfarmedica/src/pages/Register/register_page.dart';
import 'package:appfarmedica/src/pages/Citas/citas_page.dart';
import 'package:appfarmedica/src/pages/Citas/doctor_cita_page.dart';
import 'package:appfarmedica/src/pages/Citas/horarios_citas.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
    'citas': (BuildContext context) => CitasPage(),
    'AreasCitas': (BuildContext context) => SelectAreaPage(),
    'AreasExamen': (BuildContext context) => SelectAreaExamenPage(),
    'DetailCita': (BuildContext context) => DetailCita(),
    'DoctorCita': (BuildContext context) => DoctorCitaPage(),
    'Horarios': (BuildContext context) => HorariosPage(),
    'VerificarCita': (BuildContext context) => VerifyCitaPage(),
    'SelectExamen': (BuildContext context) => SelectExamen(),
    'DetailReceta': (BuildContext context) => DetailReceta(),
  };
}
