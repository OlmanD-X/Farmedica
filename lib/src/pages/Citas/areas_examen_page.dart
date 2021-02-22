import 'package:appfarmedica/src/widgets/cards_area_exam_widget.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/models/area_model.dart';
import 'package:appfarmedica/src/providers/citas_provider.dart';

class SelectAreaExamenPage extends StatefulWidget {
  @override
  _SelectAreaExamenPageState createState() => _SelectAreaExamenPageState();
}

class _SelectAreaExamenPageState extends State<SelectAreaExamenPage> {
  final CitasProvider _citasProvider = CitasProvider();
  List<Area> _listAreas = [];

  @override
  void initState() {
    super.initState();
    _getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.account_circle),
          SizedBox(width: 10.0),
        ],
        leadingWidth: 40.0,
        title: Text('FARMEDICA'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Seleccione un área',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              final area = _listAreas[index];
              return AreasExamenCard(area);
            },
            itemCount: _listAreas.length,
          ))
        ],
      ),
    );
  }

  void _getAreas() async {
    _listAreas = await _citasProvider.getAreas();
    setState(() {});
  }
}
