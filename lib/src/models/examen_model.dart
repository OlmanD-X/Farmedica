// Generated by https://quicktype.io

class Examen {
  int codigo;
  String fecha;
  int cola;
  String turno;
  String examen;
  int precio;
  int areaId;
  String areaNombre;
  String areaDescripcion;
  int estado;

  Examen({
    this.codigo,
    this.fecha,
    this.cola,
    this.turno,
    this.examen,
    this.precio,
    this.areaId,
    this.areaNombre,
    this.areaDescripcion,
    this.estado,
  });

  Examen.fromJSON(Map<String, dynamic> json) {
    codigo = json['codigo'];
    fecha = json['fecha'];
    cola = json['cola'];
    turno = json['turno'];
    examen = json['examen'];
    precio = json['precio'];
    areaId = json['area_id'];
    areaNombre = json['area_nombre'];
    areaDescripcion = json['area_descripcion'];
    estado = json['estado'];
  }

  String get nameLittle =>
      examen.length > 20 ? examen.substring(0, 20) + '...' : examen;

  String get state {
    String stateFinal = '';
    switch (estado) {
      case 1:
        stateFinal = 'ATENDIDO';
        break;
      case 3:
        stateFinal = 'CANCELADO';
        break;
      case 2:
        stateFinal = 'POSTERGADO';
        break;
      case 4:
        stateFinal = 'PENDIENTE';
        break;
    }
    return stateFinal;
  }

  String get cod {
    String cad = codigo.toString();
    while (cad.length < 8) {
      cad = '0' + cad;
    }
    return 'EM-' + cad;
  }

  String get fechaCita {
    String aux = fecha.toString().substring(0, 10);
    List<String> date = aux.split('-');
    return "${date[2]}/${date[1]}/${date[0]}";
  }
}
