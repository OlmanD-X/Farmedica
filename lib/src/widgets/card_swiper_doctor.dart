import 'package:appfarmedica/src/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DoctorSwiper extends StatelessWidget {
  final List<Doctor> _listDoctors;
  final String area;
  final String fecha;

  DoctorSwiper(
    this._listDoctors,
    this.area,
    this.fecha,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: _listDoctors.length == 0
          ? Text('No hay horarios registrados')
          : Swiper(
              pagination: new SwiperPagination(),
              // control: new SwiperControl(),
              itemCount: _listDoctors.length,
              itemBuilder: (context, index) {
                final doctor = _listDoctors[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    'Horarios',
                    arguments: {
                      'area': area,
                      'doctor': doctor.id,
                      'doctorName': doctor.nombreCompleto,
                      'date': fecha,
                    },
                  ),
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
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text(
                                'Doctor: ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doctor.nombreCompleto,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
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
                              Text(
                                'Carnet: ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doctor.carnet,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pacientes Atendidos',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  if (doctor.nameLast.length > 0)
                                    doctor.imagenLast != ""
                                        ? CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            backgroundImage:
                                                NetworkImage(doctor.imagenLast),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              doctor.nameLast[0],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  if (doctor.total > 1)
                                    CircleAvatar(
                                      child: Text(
                                        '+${doctor.total - 1}',
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
