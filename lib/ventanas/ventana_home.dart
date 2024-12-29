import 'package:flutter/material.dart';
import 'package:guayamovil/ventanas/ruta_bus.dart';
import 'package:guayamovil/ventanas/taxi_seguro.dart';


class VentanaHome extends StatefulWidget{
  final String cedula;
  const VentanaHome({super.key,  required this.cedula});
  @override
  State<VentanaHome> createState() => _VentanaHomeState();
}

class _VentanaHomeState extends State<VentanaHome> {
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: GridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(45),
        children: [
          ServiceCard(
            title: 'Bus',
            subtitle: 'Consulte las rutas de Buses de su ciudad',
            details: 'Pasaje Actual 0,30 centavos',
            image: 'assets/iconbus.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const RutaBus(),
                ),
              );
            },
          ),
          ServiceCard(
            title: 'Taxi',
            subtitle: 'Solicite un Taxi Seguro',
            details: 'Cotice la tarifa',
            image: 'assets/icontaxi.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => TaxiSeguro(cedula: widget.cedula),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String details;
  final String image;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.title, required this.subtitle, required this.details, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
   return GestureDetector( 
      onTap: onTap, 
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1,
                child: Image.asset(image),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(subtitle, textAlign: TextAlign.center),
              Text(details),
            ],
          ),
        ),
      ),
    );
  }
}

