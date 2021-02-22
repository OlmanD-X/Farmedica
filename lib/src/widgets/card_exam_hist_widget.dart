import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:appfarmedica/src/providers/exam_provider.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/models/examen_model.dart';

class CardExamHist extends StatefulWidget {
  final Examen examen;

  CardExamHist(this.examen);

  @override
  _CardExamHistState createState() => _CardExamHistState();
}

class _CardExamHistState extends State<CardExamHist> {
  TextEditingController _inputFieldDateController = TextEditingController();
  ExamenesProvider _citasProvider = ExamenesProvider();

  @override
  Widget build(BuildContext context) {
    Color stateColor = Colors.black;
    switch (widget.examen.estado) {
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
      onTap: () => _modalBottomSheet(context, widget.examen.codigo),
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
                        widget.examen.examen,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        widget.examen.areaNombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'S/ ${widget.examen.precio}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.examen.fechaCita,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        widget.examen.state,
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

  void _modalBottomSheet(context, examen) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.timer),
                title: Text('Postergar Examen'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Postergar Examen'),
                        content: Container(
                          child: TextField(
                            enableInteractiveSelection: false,
                            controller: _inputFieldDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Fecha de Cita',
                              suffixIcon: Icon(Icons.perm_contact_calendar),
                              icon: Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime picker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 15)),
                                locale: Locale('es', 'PE'),
                              );
                              if (picker != null) {
                                setState(() {
                                  List<String> date = picker
                                      .toString()
                                      .substring(0, 10)
                                      .split('-');
                                  String finalDate =
                                      "${date[2]}/${date[1]}/${date[0]}";
                                  _inputFieldDateController.text = finalDate;
                                });
                              }
                            },
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancelar'),
                          ),
                          FlatButton(
                            onPressed: () async {
                              String fecha = _inputFieldDateController.text;
                              Map<String, dynamic> response =
                                  await _citasProvider.postergarExamen(
                                      examen, fecha);
                              if (response['status'] == 'Exito') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(response['status']),
                                      content:
                                          Text("Examen postergado con éxito"),
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
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(response['status']),
                                      content: Text(response['message']),
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
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.cancel_outlined),
                title: Text('Cancelar Examen'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Cancelar Examen'),
                        content:
                            Text('¿Esta seguro que desea cancelar el examen?'),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancelar'),
                          ),
                          FlatButton(
                            onPressed: () async {
                              Map<String, dynamic> response =
                                  await _citasProvider.cancelarExamen(examen);
                              if (response['status'] == 'Exito') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(response['status']),
                                      content:
                                          Text("Examen cancelado con éxito"),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
