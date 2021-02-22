import 'package:appfarmedica/src/models/receta_model.dart';
import 'package:flutter/material.dart';

class MedicamentoCard extends StatelessWidget {
  final Medicamento area;

  MedicamentoCard(this.area);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              padding: EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(area.imagen),
                  fadeInDuration: Duration(milliseconds: 200),
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    area.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    area.descripcion,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    area.frecuencia,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
