import 'package:appfarmedica/src/models/horario_model.dart';
import 'package:flutter/material.dart';

class HorarioWidget extends StatelessWidget {
  final List<Horario> horarioItem;
  final String doctor;
  final String date;
  final String area;

  HorarioWidget({this.horarioItem, this.doctor, this.date, this.area});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            if (horarioItem[0].condicion == 1) {
              Navigator.of(context).pushNamed(
                'VerificarCita',
                arguments: {
                  'horario': horarioItem[0],
                  'doctor': doctor,
                  'area': area,
                  'date': date,
                },
              );
            }
          },
          child: Card(
            margin:
                EdgeInsets.only(top: 10.0, bottom: 5.0, left: 5.0, right: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.timelapse),
                      SizedBox(width: 10.0),
                      Text(
                        horarioItem[0].hora,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        'Consultorio: ${horarioItem[0].consultorio}',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      SizedBox(width: 15.0),
                      Icon(
                        horarioItem[0].condicion == 1
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: horarioItem[0].condicion == 1
                            ? Colors.green
                            : Colors.red,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        if (horarioItem.length > 1)
          GestureDetector(
            onTap: () {
              if (horarioItem[1].condicion == 1) {
                Navigator.of(context).pushNamed(
                  'VerificarCita',
                  arguments: {
                    'horario': horarioItem[1],
                    'doctor': doctor,
                    'area': area,
                    'date': date,
                  },
                );
              }
            },
            child: Card(
              margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.timelapse),
                        SizedBox(width: 10.0),
                        Text(
                          horarioItem[1].hora,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          'Consultorio: ${horarioItem[1].consultorio}',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        SizedBox(width: 15.0),
                        Icon(
                          horarioItem[1].condicion == 1
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: horarioItem[1].condicion == 1
                              ? Colors.green
                              : Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
