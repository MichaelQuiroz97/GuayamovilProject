import 'package:flutter/material.dart';
import 'package:guayamovil/Database/db_helper.dart';
import 'package:guayamovil/login_page.dart';
import 'package:guayamovil/models/campos_widgets.dart';
import 'package:guayamovil/models/usuario.dart';

class VentanaPerfil extends StatefulWidget {
  final String? cedula;
  const VentanaPerfil({super.key, this.cedula});

  @override
  State<VentanaPerfil> createState() => _VentanaPerfilState();
}

class _VentanaPerfilState extends State<VentanaPerfil> {
  Map<String, dynamic>? _usuario;
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
  }

  Future<void> _cargarUsuario() async {
    if (widget.cedula != null) {
      final usuarioData = await SQLHelper.getUserByCedula(widget.cedula!);
      if (usuarioData.isNotEmpty) {
        setState(() {
          _usuario = usuarioData.first;
          _telefonoController.text = _usuario!['telefono'];
          _emailController.text = _usuario!['email'];
          _contrasenaController.text = _usuario!['clave'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: _usuario == null
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {}, // Implementar lógica para cambiar foto
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.camera_alt,
                              size: 50, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildUsuarioInfo(),
                      const SizedBox(height: 20),
                      _buildEditableFields(),
                      const SizedBox(height: 20),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildUsuarioInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cédula: ${_usuario!['cedula']}',
            style: const TextStyle(fontSize: 20)),
        Text('Nombres: ${_usuario!['nombres']}',
            style: const TextStyle(fontSize: 20)),
        Text('Apellidos: ${_usuario!['apellidos']}',
            style: const TextStyle(fontSize: 20)),
      ],
    );
  }

  Widget _buildEditableFields() {
    return Column(
      children: [
        CampoTelefono(
          labelText: 'Teléfono',
          iconData: Icons.phone,
          controller: _telefonoController,
          editable: _isEditing,
        ),
        CampoEmail(
          labelText: 'Email',
          iconData: Icons.email,
          controller: _emailController,
          editable: _isEditing,
        ),
        CampoContrasena(
            labelText: 'Contraseña',
            iconData: Icons.lock,
            controller: _contrasenaController,
            editable: _isEditing),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_isEditing) {
              _guardarCambios();
            }
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          child: Text(_isEditing ? 'Guardar' : 'Editar'),
        ),
        ElevatedButton(
          onPressed: _eliminarPerfil,
          child: const Text('Eliminar Perfil'),
        ),
      ],
    );
  }

  Future<void> _eliminarPerfil() async {
    if (widget.cedula != null) {
      await SQLHelper.deleteUser(widget.cedula!);
      _mostrarMensaje('Perfil eliminado exitosamente');
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );
    }
  }

  Future<void> _guardarCambios() async {
    if (_usuario != null) {
      Usuario usuarioActualizado = Usuario(
        cedula: _usuario!['cedula'],
        nombres: _usuario!['nombres'],
        apellidos: _usuario!['apellidos'],
        telefono: _telefonoController.text,
        email: _emailController.text,
        clave: _contrasenaController.text,
        tipoUsuario: _usuario!['tipoUsuario'],
      );
      await SQLHelper.updateUser(usuarioActualizado);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado con éxito')),
      );
      _cargarUsuario();
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }
}
