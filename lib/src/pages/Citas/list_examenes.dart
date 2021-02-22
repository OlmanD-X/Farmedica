import 'package:flutter/material.dart';

import 'package:appfarmedica/src/providers/exam_provider.dart';
import 'package:appfarmedica/src/widgets/card_exam_hist_widget.dart';

class ListExamenes extends StatefulWidget {
  @override
  _ListExamenesState createState() => _ListExamenesState();
}

class _ListExamenesState extends State<ListExamenes> {
  final ExamenesProvider _citasExamenes = ExamenesProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Lista de Exámenes',
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
            future: _citasExamenes.getHorarios(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final examen = snapshot.data[index];
                      return CardExamHist(examen);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                return Center(
                  child: Text('No hay examenes registrados'),
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
