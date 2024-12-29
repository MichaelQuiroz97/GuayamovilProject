import 'package:flutter/material.dart';
import 'package:guayamovil/Database/db_helper.dart';
import 'package:guayamovil/models/Taxi.dart';
import 'package:guayamovil/ventanas/add_taxi.dart';
import 'package:guayamovil/ventanas/ventana_perfil.dart';

class TaxiSeguro extends StatefulWidget {
  final String cedula;
  const TaxiSeguro({super.key, required this.cedula});
  @override
  State<TaxiSeguro> createState() => _TaxiSeguroState();
}

class _TaxiSeguroState extends State<TaxiSeguro> {
  List<Taxi> taxis = [];


  @override
  initState() {
    super.initState();
    loadTaxis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cedula),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_2),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      VentanaPerfil(cedula: widget.cedula),
                ),
              );
            },
          ),
        ],
      ),
      body: taxis.isEmpty
          ? const Center(child: Text('No hay taxis registrados.'))
          : ListView.builder(
              itemCount: taxis.length,
              itemBuilder: (context, index) {
                final taxi = taxis[index];
                return ListTile(
                  title: Text('Cedula Taxista: ${taxi.cedulaTaxista}'),
                  subtitle: Text('Placa: ${taxi.numeroPlaca}'),
                  trailing: Text('Cooperativa: ${taxi.nombreCooperativa}'),
                   onTap: () => _showOptions(taxi),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => AddTaxi(cedula: widget.cedula),
          ),
        );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> loadTaxis() async {
    final List<Map<String, dynamic>> taxiMaps = await SQLHelper.getTaxis();
    setState(() {
      taxis = taxiMaps.map((taxiMap) {
        return Taxi(
          id: taxiMap['id'],
          cedulaTaxista: taxiMap['cedulaTaxista'],
          marcaVehiculo: taxiMap['marcaVehiculo'],
          numeroPlaca: taxiMap['numeroPlaca'],
          nombreCooperativa: taxiMap['nombreCooperativa'],
          createdAt: DateTime.parse(taxiMap['createdAt']),
        );
      }).toList();
    });
  }

 void _showOptions(Taxi taxi) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            if (taxi.cedulaTaxista == widget.cedula) ...[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AddTaxi(
                        cedula: widget.cedula,
                        taxi: taxi,
                      ),
                    ),
                  ).then((_) => loadTaxis());
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Eliminar'),
                onTap: () async {
                  Navigator.pop(context);
                  await SQLHelper.deleteTaxi(taxi.numeroPlaca);
                  loadTaxis();
                },
              ),
            ] else ...[
              ListTile(
                leading: Icon(Icons.request_page),
                title: Text('Solicitar'),
                onTap: () {
                  Navigator.pop(context);
                  Text('Taxi Solicitado');
                },
              ),
            ],
          ],
        );
      },
    );
  }
 
}
