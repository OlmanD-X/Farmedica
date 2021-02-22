import 'package:appfarmedica/src/models/cita_model.dart';
import 'package:flutter/material.dart';

class CardHist extends StatelessWidget {
  final CitaModel cita;
  CardHist(this.cita);
  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed('DetailCita', arguments: cita),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        cita.cod,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        cita.area,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        cita.fechaCita,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        cita.state,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: stateColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
