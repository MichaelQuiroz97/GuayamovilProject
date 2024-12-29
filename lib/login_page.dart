import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guayamovil/Database/db_helper.dart';
import 'package:guayamovil/home_screen.dart';
import 'package:guayamovil/models/campos_widgets.dart';
import 'package:guayamovil/ventana_reg_usuario.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  bool _isLoading = false;
   String _cedulaUsuario='';

  @override
  void dispose() {
    _emailController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromARGB(255, 5, 12, 156),
        Color.fromARGB(255, 53, 114, 239),
        Color.fromARGB(255, 58, 190, 249),
        Color.fromARGB(255, 167, 230, 255)
      ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Icono
                Image.asset('assets/prototipoguayamovil.png', scale: 0.5),
                const SizedBox(height: 5),
                //Hello
                Text('¡Bienvenido!',
                    style: GoogleFonts.bebasNeue(fontSize: 48),
                    selectionColor: const Color.fromARGB(255, 0, 7, 103)),
                const SizedBox(height: 20),

                //Campo correo
                CampoEmail(
                  labelText: 'Email',
                  iconData: Icons.email,
                  controller: _emailController,
                  editable: true,
                ),
                CampoContrasena(
                  labelText: 'Contraseña',
                  iconData: Icons.lock,
                  controller: _contrasenaController,
                  editable: true,
                ),

                //Botón Iniciar Sesión
                iniciarSesionBoton(),
                const SizedBox(height: 50),

                //No registrado
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        //color: Color(0xFF032B44),
                        color: Color(0xFFFEFFA7),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const RegistroUsuario(),
                          ),
                        );
                      },
                      child: const Text(
                        ' Registrese Aquí',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  
  Widget iniciarSesionBoton() {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(226, 5, 106, 221),
          textStyle: GoogleFonts.bebasNeue(fontSize: 24),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        ),
        onPressed: _isLoading ? null : _eventLogin,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Iniciar Sesión',
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  Future<void> _eventLogin() async {
    if (_emailController.text.isEmpty || _contrasenaController.text.isEmpty) {
      _mostrarMensaje('Error', 'Por favor, complete todos los campos');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credenciales = await SQLHelper.validateCredentials(
        _emailController.text,
        _contrasenaController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (credenciales.isNotEmpty) {
        // Usuario encontrado, guardar la cédula
        _cedulaUsuario = credenciales.first['cedula']; // Asumiendo que 'cedula' es una de las columnas devueltas

        // Navegar a HomeScreen y pasar la cédula
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => HomeScreen(cedula: _cedulaUsuario),
          ),
        );
      } else {
        // Usuario no encontrado
        _cedulaUsuario = ''; // Borrar la cédula si las credenciales son inválidas
        if (!mounted) return;
        _mostrarMensaje('Error', 'Credenciales inválidas');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _mostrarMensaje('Error', 'Ocurrió un error al iniciar sesión: $e');
    }
  }


 void _mostrarMensaje(String titulo, String mensaje) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      });
      
      return AlertDialog(
        title: Text(titulo),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(mensaje),
            const SizedBox(height: 20),
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    },
  );
}

}
