import 'package:appfarmedica/src/models/examen_create_model.dart';
import 'package:appfarmedica/src/models/receta_model.dart';
import 'package:appfarmedica/src/providers/exam_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ExamenSwiper extends StatelessWidget {
  final List<ExamenCreate> _listExamenes;
  ExamenesProvider _citasProvider = ExamenesProvider();

  ExamenSwiper(this._listExamenes);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: _listExamenes.length == 0
          ? Text('No hay horarios registrados')
          : Swiper(
              pagination: new SwiperPagination(),
              // control: new SwiperControl(),
              itemCount: _listExamenes.length,
              itemBuilder: (context, index) {
                final doctor = _listExamenes[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Reservar Examen'),
                          content: Text(
                              '¿Esta seguro que desea reservar el examen?'),
                          actions: [
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancelar'),
                            ),
                            FlatButton(
                              onPressed: () async {
                                Map<String, dynamic> response =
                                    await _citasProvider
                                        .reservarExamen(doctor.id);
                                if (response['status'] == 'Exito') {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(response['status']),
                                        content:
                                            Text("Examen reservado con éxito"),
                                        actions: [
                                          FlatButton(
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      'citas',
                                                      ModalRoute.withName(
                                                          'citas'),
                                                      arguments: 1);
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 300.0,
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
                            image: NetworkImage(doctor.imagen),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                doctor.nombre,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'S/ ${doctor.precio}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  doctor.descripcion,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Requisitos',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('No tiene requisitos'),
                                  CircleAvatar(
                                    child: Text(
                                      '${doctor.cola}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
