import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:flutter/material.dart';

class VerifyCitaPage extends StatelessWidget {
  final CitasProvider _citasProvider = CitasProvider();
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10.0),
          Icon(Icons.search),
          SizedBox(width: 10.0),
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
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 20.0),
                  Image.asset(
                    'assets/images/logo-verify.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 30.0),
                  Text(
                    'Verificar Cita',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.blue,
              height: 5.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Verifique si el horario se encuentra disponible para reservar la cita',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              title: Text(
                'Doctor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                data['doctor'],
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
                data['area'],
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Fecha',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                data['date'],
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
                data['horario'].hora,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () async {
                  Map<String, dynamic> response =
                      await _citasProvider.reservarCita(data['horario'].id);
                  if (response['status'] == 'Exito') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Solicitud exitosa'),
                          content: Text('Cita reservada exitosamente'),
                          actions: [
                            FlatButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      'citas', ModalRoute.withName('citas')),
                              child: Text('OK'),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 15.0,
                ),
                color: Colors.blue,
                child: Text('Verificar y Reservar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
