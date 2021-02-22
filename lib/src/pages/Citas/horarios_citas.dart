import 'package:appfarmedica/src/models/horario_model.dart';
import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:appfarmedica/src/widgets/horario_widget.dart';
import 'package:flutter/material.dart';

class HorariosPage extends StatefulWidget {
  @override
  _HorariosPageState createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {
  final CitasProvider _citasProvider = CitasProvider();

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text('FARMEDICA'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Seleccione un Horario',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Tolerancia: 5 minutos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: _citasProvider.getHorario(data['doctor'], data['date']),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final List<Horario> horario = snapshot.data[index];
                      return HorarioWidget(
                        horarioItem: horario,
                        date: data['date'],
                        area: data['area'],
                        doctor: data['doctorName'],
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                return Container(
                  height: 800.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
