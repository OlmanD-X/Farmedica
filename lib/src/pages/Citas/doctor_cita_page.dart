import 'package:appfarmedica/src/models/area_model.dart';
import 'package:appfarmedica/src/providers/citas_provider.dart';
import 'package:appfarmedica/src/widgets/card_swiper_doctor.dart';
import 'package:flutter/material.dart';

class DoctorCitaPage extends StatefulWidget {
  @override
  _DoctorCitaPageState createState() => _DoctorCitaPageState();
}

class _DoctorCitaPageState extends State<DoctorCitaPage> {
  TextEditingController _inputFieldDateController = TextEditingController();

  CitasProvider _citasProvider = CitasProvider();

  @override
  void initState() {
    super.initState();
    List<String> date = DateTime.now().toString().substring(0, 10).split('-');
    String finalDate = "${date[2]}/${date[1]}/${date[0]}";
    _inputFieldDateController.text = finalDate;
  }

  @override
  Widget build(BuildContext context) {
    final Area area = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10.0),
          Icon(Icons.search),
          SizedBox(width: 10.0),
          Icon(Icons.account_circle),
          SizedBox(width: 10.0),
        ],
        leadingWidth: 40.0,
        title: Text('FARMEDICA'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 20.0,
                top: 10.0,
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Seleccione una fecha',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
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
                  lastDate: DateTime.now().add(Duration(days: 15)),
                  locale: Locale('es', 'PE'),
                );
                if (picker != null) {
                  setState(() {
                    List<String> date =
                        picker.toString().substring(0, 10).split('-');
                    String finalDate = "${date[2]}/${date[1]}/${date[0]}";
                    _inputFieldDateController.text = finalDate;
                  });
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 20.0,
                top: 50.0,
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Seleccione un doctor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return DoctorSwiper(snapshot.data, area.nombre,
                      _getDate(_inputFieldDateController.text));
                return Container(
                  height: 500.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              future: _citasProvider.getDoctors(
                area.id,
                _getDate(_inputFieldDateController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDate(String date) {
    List<String> dateFinal = date.split('/');
    return dateFinal[2] + '-' + dateFinal[1] + '-' + dateFinal[0];
  }
}
