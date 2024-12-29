class Usuario {
  final int? id;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String telefono;
  final String email;
  final String clave;
  final int tipoUsuario;
  final DateTime? createdAt;

  Usuario({
    this.id,
    required this.cedula,
    required this.nombres,
    required this.apellidos,
    required this.telefono,
    required this.email,
    required this.clave,
    required this.tipoUsuario,
    this.createdAt,
  });

}