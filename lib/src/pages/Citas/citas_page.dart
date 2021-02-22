import 'package:appfarmedica/src/pages/Citas/list_examenes.dart';
import 'package:appfarmedica/src/pages/Citas/recetas_page.dart';
import 'package:appfarmedica/src/pages/Home/info_page.dart';
import 'package:appfarmedica/src/search/search_delegate.dart';
import 'package:flutter/material.dart';

import 'package:appfarmedica/src/pages/Citas/list_citas.dart';
import 'package:appfarmedica/src/widgets/bottom_navigation_bar.dart';

class CitasPage extends StatefulWidget {
  @override
  _CitasPageState createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  int _selectedIndex = 0;
  List<Widget> _widgets = [
    ListCitas(),
    ListExamenes(),
    Recetas(),
    InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    int index1 = ModalRoute.of(context).settings.arguments ?? 0;
    _selectedIndex = index1;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10.0),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(_selectedIndex),
              );
            },
          ),
          SizedBox(width: 10.0),
          Icon(Icons.account_circle),
          SizedBox(width: 10.0),
        ],
        leading: Container(),
        leadingWidth: 0.0,
        title: Text('FARMEDICA'),
      ),
      body: _widgets.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBarBottom(
        f: (index) => () {
          if (index != -1) {
            // setState(() {
            //   _selectedIndex = index;
            // });
            Navigator.of(context)
                .pushReplacementNamed('citas', arguments: index);
          } else {
            _modalBottomSheet(context);
          }
        },
        position: _selectedIndex,
      ),
    );
  }

  void _modalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Agendar Cita'),
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('AreasCitas'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.wallet_travel),
                title: Text('Programar Examen'),
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('AreasExamen'),
              ),
            ],
          ),
        );
      },
    );
  }
}
