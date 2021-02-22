import 'package:appfarmedica/src/models/area_model.dart';
import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/models/cita_model.dart';

class DetailCita extends StatelessWidget {
  final CitasProvider _citasProvider = CitasProvider();
  @override
  Widget build(BuildContext context) {
    final CitaModel cita = ModalRoute.of(context).settings.arguments;
    Color stateColor = Colors.black;
    switch (cita.estado) {
      case 1:
        stateColor = Colors.green;
        break;
      case 3:
        stateColor = Colors.red;
        break;
      case 2:
        stateColor = Colors.blue;
        break;
      case 4:
        stateColor = Colors.amber;
        break;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.account_circle),
          SizedBox(width: 10.0),
        ],
        leadingWidth: 40.0,
        title: Text(
          'FARMEDICA',
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              width: double.infinity,
              child: Text(
                'Detalle Cita',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Fecha',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                cita.fechaCita,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Hora',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                cita.hora,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Especialidad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                cita.area,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Doctor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                cita.doctor,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Estado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                cita.state,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: stateColor,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (cita.estado == 4)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Postergar Cita'),
                              content: Text(
                                  '¿Esta seguro que desea postergar la cita?'),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancelar'),
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    Map<String, dynamic> response =
                                        await _citasProvider
                                            .postergarCita(cita.codigo);
                                    if (response['status'] == 'Exito') {
                                      Area area = Area(
                                          id: cita.areaId, nombre: cita.area);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('DoctorCita',
                                              ModalRoute.withName('citas'),
                                              arguments: area);
                                    }
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 15.0,
                      ),
                      color: Colors.blue,
                      child: Text('POSTERGAR'),
                    ),
                  ),
                if (cita.estado == 4 || cita.estado == 2)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Cancelar Cita'),
                              content: Text(
                                  '¿Esta seguro que desea cancelar la cita?'),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancelar'),
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    Map<String, dynamic> response =
                                        await _citasProvider
                                            .cancelarCita(cita.codigo);
                                    if (response['status'] == 'Exito') {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('citas',
                                              ModalRoute.withName('citas'));
                                    }
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 15.0,
                      ),
                      color: Colors.red,
                      child: Text('CANCELAR'),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // String _getDate(String date) {
  //   List<String> dateFinal = date.split('-');
  //   return "${dateFinal[2]}/${dateFinal[1]}/${dateFinal[0]}";
  // }
}
