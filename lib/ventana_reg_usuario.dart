import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guayamovil/Database/db_helper.dart';
import 'package:guayamovil/login_page.dart';
import 'package:guayamovil/models/campos_widgets.dart';
import 'package:guayamovil/models/usuario.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final _cedulaController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isEditing = false;
    return Scaffold(
        appBar: AppBar(
          title: Text('GuayaMovil!',
              style: GoogleFonts.bebasNeue(fontSize: 32, color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 53, 114, 239),
                  Color.fromARGB(255, 58, 190, 249),
                  Color.fromARGB(255, 167, 230, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
            Color.fromARGB(255, 5, 12, 156),
            Color.fromARGB(255, 53, 114, 239),
            Color.fromARGB(255, 58, 190, 249),
            Color.fromARGB(255, 167, 230, 255)
          ], begin: Alignment.bottomCenter, end: Alignment.topRight)),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Icono
                    const SizedBox(height: 40),
                    Transform.scale(
                      scale: 4,
                      child: const Icon(Icons.person, color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    // Hello
                    Text('Crear Cuenta',
                        style: GoogleFonts.bebasNeue(fontSize: 48),
                        selectionColor: const Color.fromARGB(255, 0, 7, 103)),
                    const SizedBox(height: 20),

                    // Campo cédula
                    CampoCedula(
                      labelText: 'Cédula',
                      iconData: Icons.person,
                      controller: _cedulaController,
                    ),
                    // Campo Nombres
                    CampoNombres(
                      labelText: 'Nombres',
                      iconData: Icons.person,
                      controller: _nombresController,
                    ),
                    // Campo Apellidos
                    CampoApellidos(
                      labelText: 'Apellidos',
                      iconData: Icons.person,
                      controller: _apellidosController,
                    ),
                    // Campo Telefono
                    CampoTelefono(
                      labelText: 'Teléfono',
                      iconData: Icons.phone,
                      controller: _telefonoController,
                      editable: _isEditing,
                    ),
                    // Campo Correo
                    CampoEmail(
                      labelText: 'Email',
                      iconData: Icons.email,
                      controller: _emailController,
                      editable: _isEditing,

                    ),
                    // Campo Contraseña
                    CampoContrasena(
                      labelText: 'Contraseña',
                      iconData: Icons.lock,
                      controller: _contrasenaController,
                    ),

                    // Botón Registrar
                    botonRegistrarUsuario()
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget botonRegistrarUsuario() {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(226, 5, 106, 221),
          textStyle: GoogleFonts.bebasNeue(fontSize: 24),
        ),
        onPressed: () {
          _registrarUsuario();
        },
        child: const Text(
          'Registrar Usuario',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _registrarUsuario() async {
    try {
      final usuario = Usuario(
        cedula: _cedulaController.text,
        nombres: _nombresController.text,
        apellidos: _apellidosController.text,
        telefono: _telefonoController.text,
        email: _emailController.text,
        clave: _contrasenaController.text,
        tipoUsuario: 2,
      );

      await SQLHelper.insertUser(usuario);

      if (!mounted) return;
      _mostrarMensaje('Usuario registrado exitosamente');
      _limpiarCampos();
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _mostrarMensaje('Error al registrar usuario: ${e.toString()}');
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  void _limpiarCampos() {
    _cedulaController.clear();
    _nombresController.clear();
    _apellidosController.clear();
    _telefonoController.clear();
    _emailController.clear();
    _contrasenaController.clear();
  }
}
