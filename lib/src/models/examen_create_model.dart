// Generated by https://quicktype.io

class ExamenCreate {
  int id;
  String nombre;
  String descripcion;
  int cola;
  String imagen;
  int precio;
  List<dynamic> requisito;

  ExamenCreate({
    this.id,
    this.nombre,
    this.descripcion,
    this.cola,
    this.imagen,
    this.precio,
    this.requisito,
  });

  ExamenCreate.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    cola = json['cola'];
    imagen = json['imagen'];
    precio = json['precio'];
    requisito = json['requisito'];
  }
}
