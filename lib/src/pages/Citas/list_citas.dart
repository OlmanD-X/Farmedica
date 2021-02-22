import 'package:flutter/material.dart';

import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:appfarmedica/src/widgets/card_hist_widget.dart';

class ListCitas extends StatefulWidget {
  @override
  _ListCitasState createState() => _ListCitasState();
}

class _ListCitasState extends State<ListCitas> {
  final CitasProvider _citasProvider = CitasProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Lista de Citas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: FutureBuilder(
            future: _citasProvider.getCitas(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final cita = snapshot.data[index];
                      return CardHist(cita);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                return Center(
                  child: Text('No tiene citas registradas'),
                );
              }
              return Container(
                height: 600.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
