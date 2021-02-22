import 'package:appfarmedica/src/models/receta_model.dart';
import 'package:appfarmedica/src/widgets/medicamento_card.dart';
import 'package:flutter/material.dart';

class DetailReceta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Receta cita = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.account_circle),
          SizedBox(width: 10.0),
        ],
        leadingWidth: 40.0,
        title: Text('FARMEDICA'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Receta R-${cita.numero}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            title: Text(
              'Cita',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              cita.cod,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          ListTile(
            title: Text(
              'Doctor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              cita.doctorNombre + ' ' + cita.doctorApellido,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          ListTile(
            title: Text(
              'Fecha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              cita.fechaCita,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Medicamentos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final area = cita.medicamentos[index];
                return MedicamentoCard(area);
              },
              itemCount: cita.medicamentos.length,
            ),
          )
        ],
      ),
    );
  }
}
