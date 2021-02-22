import 'package:appfarmedica/src/providers/exam_provider.dart';
import 'package:appfarmedica/src/widgets/card_receta_widget.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/widgets/card_hist_widget.dart';

class Recetas extends StatefulWidget {
  @override
  _ListRecetasState createState() => _ListRecetasState();
}

class _ListRecetasState extends State<Recetas> {
  final ExamenesProvider _citasProvider = ExamenesProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Lista de Recetas',
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
            future: _citasProvider.getRecetas(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final cita = snapshot.data[index];
                      return CardReceta(cita);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                return Center(
                  child: Text('No tiene recetas registradas'),
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
