class Taxi {
  final int? id;
  final String cedulaTaxista;
  final String marcaVehiculo;
  final String numeroPlaca;
  final String nombreCooperativa;
  final DateTime? createdAt;

  Taxi({
    this.id,
    required this.cedulaTaxista,
    required this.marcaVehiculo,
    required this.numeroPlaca,
    required this.nombreCooperativa,
    this.createdAt,
  });

}