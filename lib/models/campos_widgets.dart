import 'package:flutter/material.dart';


// Campo de texto para cédula
class CampoCedula extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;

  const CampoCedula({super.key, required this.labelText, required this.iconData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    iconData,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labelText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Campo de texto para nombres
class CampoNombres extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;

  const CampoNombres({super.key, required this.labelText, required this.iconData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    iconData,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labelText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Campo de texto para apellidos
class CampoApellidos extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;

  const CampoApellidos({super.key, required this.labelText, required this.iconData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    iconData,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labelText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Campo de texto para número de teléfono
class CampoTelefono extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;
  final bool editable;

  const CampoTelefono({
    super.key,
    required this.labelText,
    required this.iconData,
    required this.controller,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    iconData,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labelText,
                    ),
                    enabled: editable,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Campo de texto para email
class CampoEmail extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;
  final bool editable;

  const CampoEmail({
    super.key,
    required this.labelText,
    required this.iconData,
    required this.controller,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    iconData,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labelText,
                    ),
                    enabled: editable,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

//------------------------------- Campo de texto para contraseña--------------------------------
// Campo de texto para contraseña
class CampoContrasena extends StatefulWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController controller;
  final bool editable;

  const CampoContrasena({
    super.key,
    required this.labelText,
    required this.iconData,
    required this.controller,
    this.editable = true,
  });

  @override
  _CampoContrasenaState createState() => _CampoContrasenaState();
}

class _CampoContrasenaState extends State<CampoContrasena> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    widget.iconData,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: widget.labelText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    enabled: widget.editable,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}