import 'package:flutter/material.dart';
import 'package:guayamovil/Database/db_helper.dart';
import 'package:guayamovil/models/Taxi.dart';
import 'package:guayamovil/ventanas/ventana_perfil.dart';

class AddTaxi extends StatefulWidget {
  final String cedula;
  final Taxi? taxi; // Taxi para editar, si es null, es creación
  const AddTaxi({super.key, required this.cedula, this.taxi});
  @override
  State<AddTaxi> createState() => _AddTaxiState();
}

class _AddTaxiState extends State<AddTaxi> {
  final _formKey = GlobalKey<FormState>();
  final _marcaVehiculoController = TextEditingController();
  final _numeroPlacaController = TextEditingController();
  final _nombreCooperativaController = TextEditingController();
  final List<String> _marcas = ['Toyota', 'Nissan', 'Chevrolet', 'Ford', 'Honda'];
  String _selectedMarca = '';

  @override
  void initState() {
    super.initState();
    if (widget.taxi != null) {
      _marcaVehiculoController.text = widget.taxi!.marcaVehiculo;
      _numeroPlacaController.text = widget.taxi!.numeroPlaca;
      _nombreCooperativaController.text = widget.taxi!.nombreCooperativa;
      _selectedMarca = widget.taxi!.marcaVehiculo;
    }
  }

 void _saveTaxi() async {
    if (_formKey.currentState!.validate()) {
      Taxi taxi = Taxi(
        cedulaTaxista: widget.cedula,
        marcaVehiculo: _selectedMarca,
        numeroPlaca: _numeroPlacaController.text,
        nombreCooperativa: _nombreCooperativaController.text,
      );
      try {
        if (widget.taxi == null) {
          await SQLHelper.insertTaxi(taxi);
        } else {
          await SQLHelper.updateTaxi(taxi);
        }
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _deleteTaxi() async {
    if (widget.taxi != null) {
      await SQLHelper.deleteTaxi(widget.taxi!.numeroPlaca);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taxi == null ? 'Crear Taxi' : 'Editar Taxi'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_2),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => VentanaPerfil(cedula: widget.cedula),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedMarca.isEmpty ? null : _selectedMarca,
                decoration: const InputDecoration(labelText: 'Marca del Vehículo'),
                items: _marcas.map((String marca) {
                  return DropdownMenuItem<String>(
                    value: marca,
                    child: Text(marca),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMarca = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la marca del vehículo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numeroPlacaController,
                decoration: const InputDecoration(labelText: 'Número de Placa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de placa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombreCooperativaController,
                decoration: const InputDecoration(labelText: 'Nombre de la Cooperativa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la cooperativa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  if (widget.taxi != null)
                    TextButton(
                      onPressed: _deleteTaxi,
                      child: const Text('Eliminar'),
                    ),
                  TextButton(
                    onPressed: _saveTaxi,
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}