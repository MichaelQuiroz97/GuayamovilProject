import 'package:guayamovil/models/Taxi.dart';
import 'package:guayamovil/models/usuario.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await createUsuarioTable(database);
    await createTaxisTable(database);
  }

static Future<void> createUsuarioTable(sql.Database database) async {
  await database.execute("""
    CREATE TABLE Usuario (
      id INTEGER PRIMARY KEY,
      cedula TEXT,
      nombres TEXT,
      apellidos TEXT,
      telefono TEXT,
      email TEXT,
      clave TEXT,
      tipoUsuario INTEGER CHECK(tipoUsuario IN (1, 2)),
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
  """);
}

 static Future<void> createTaxisTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE Taxi (
        id INTEGER PRIMARY KEY,
        cedulaTaxista TEXT,
        marcaVehiculo TEXT,
        numeroPlaca TEXT,
        nombreCooperativa TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "database_name.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create - Insertar un nuevo usuario
  static Future<int> insertUser(Usuario usuario) async {
    final db = await SQLHelper.db();
    return await db.insert(
      'Usuario', 
      {
        'cedula': usuario.cedula,
        'nombres': usuario.nombres,
        'apellidos': usuario.apellidos,
        'telefono': usuario.telefono,
        'email': usuario.email,
        'clave': usuario.clave,
        'tipoUsuario': usuario.tipoUsuario,
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }



  // Create - Insertar un nuevo taxi
  static Future<int> insertTaxi(Taxi taxi) async {
    final db = await SQLHelper.db();
    return await db.insert(
      'Taxi',
      {
        'cedulaTaxista': taxi.cedulaTaxista,
        'marcaVehiculo': taxi.marcaVehiculo,
        'numeroPlaca': taxi.numeroPlaca,
        'nombreCooperativa': taxi.nombreCooperativa,
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Read - Obtener todos los Usuario
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db();
    return db.query('Usuario', orderBy: 'id');
  }

  // Read - Obtener todos los Taxis
  static Future<List<Map<String, dynamic>>> getTaxis() async {
    final db = await SQLHelper.db();
    return db.query('Taxi');
  }

  // Read - Obtener un usuario específico por ID
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQLHelper.db();
    return db.query('Usuario', where: 'id = ?', whereArgs: [id], limit: 1);
  }

   // Read - Obtener un Taxi específico por placa
  static Future<List<Map<String, dynamic>>> getTaxi(String numeroPlaca) async {
    final db = await SQLHelper.db();
    return db.query('Taxi', where: 'numeroPlaca = ?', whereArgs: [numeroPlaca], limit: 1);
  }

  // Update - Actualizar un usuario
  static Future<int> updateUser(Usuario usuario) async {
    final db = await SQLHelper.db();
    return await db.update(
      'Usuario',
      {
        'cedula': usuario.cedula,
        'nombres': usuario.nombres,
        'apellidos': usuario.apellidos,
        'telefono': usuario.telefono,
        'email': usuario.email,
        'clave': usuario.clave,
        'tipoUsuario': usuario.tipoUsuario,
      },
      where: 'cedula = ?',
      whereArgs: [usuario.cedula],
    );
  }


   // Update - Actualizar un Taxi
  static Future<int> updateTaxi(Taxi taxi) async {
    final db = await SQLHelper.db();
    return await db.update(
      'Taxi',
      {
        'cedulaTaxista': taxi.cedulaTaxista,
        'marcaVehiculo': taxi.marcaVehiculo,
        'numeroPlaca': taxi.numeroPlaca,
        'nombreCooperativa': taxi.nombreCooperativa
      },
      where: 'numeroPlaca = ?',
      whereArgs: [taxi.numeroPlaca],
    );
  }

  // Delete - Eliminar un usuario
  static Future<int> deleteUser(String cedula) async {
    final db = await SQLHelper.db();
    return await db.delete('Usuario', where: 'cedula = ?', whereArgs: [cedula]);
  }

   // Delete - Eliminar un Taxi
  static Future<int> deleteTaxi(String numeroPlaca) async {
    final db = await SQLHelper.db();
    return await db.delete('Taxi', where: 'numeroPlaca = ?', whereArgs: [numeroPlaca]);
  }

  // Buscar usuario por cédula
  static Future<List<Map<String, dynamic>>> getUserByCedula(String cedula) async {
    final db = await SQLHelper.db();
    return db.query('Usuario', where: 'cedula = ?', whereArgs: [cedula], limit: 1);
  }

  // Buscar usuario por email
  static Future<List<Map<String, dynamic>>> getUserByEmail(String email) async {
    final db = await SQLHelper.db();
    return db.query('Usuario', where: 'email = ?', whereArgs: [email], limit: 1);
  }

   // Validar credenciales
  static Future<List<Map<String, dynamic>>> validateCredentials(String email, String clave) async {
    final db = await SQLHelper.db();
    return db.query(
      'Usuario',
      where: 'email = ? AND clave = ?',
      whereArgs: [email, clave],
      limit: 1
    );
  }

}
