import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:appfarmedica/src/providers/exam_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  int index;

  DataSearch(this.index);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    final examenProvider = ExamenesProvider();
    final citaProvider = CitasProvider();
    dynamic aux;

    if (index == 0) {
      aux = citaProvider.getCitasQuery;
    } else if (index == 1) {
      aux = examenProvider.getHorariosQuery;
    } else {
      aux = examenProvider.getRecetasQuery;
    }

    return FutureBuilder(
      future: aux(query),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.map((m) {
              String title = '';
              String fecha = m.fechaCita;
              if (index == 0) {
                title = m.cod;
                fecha += ' - ' + m.state;
              } else if (index == 1) {
                title = m.examen;
                fecha += ' - ' + m.state;
              } else {
                title = 'R-00${m.id}';
              }
              return ListTile(
                // leading: FadeInImage(
                //   image: NetworkImage(m.),
                //   placeholder: AssetImage('assets/img/no-image.jpg'),
                //   width: 50.0,
                //   fit: BoxFit.contain,
                // ),
                title: Text(title),
                subtitle: Text(fecha),
                onTap: () {
                  // close(context, null);
                  if (index == 0) {
                    Navigator.pushNamed(context, 'DetailCita', arguments: m);
                  } else if (index == 1) {
                    Navigator.pushNamed(context, 'detail', arguments: m);
                  } else {
                    Navigator.pushNamed(context, 'DetailReceta', arguments: m);
                  }
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
