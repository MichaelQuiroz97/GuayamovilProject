import 'package:flutter/material.dart';

class RutaBus extends StatefulWidget{
  const RutaBus({super.key});
  @override
  State<RutaBus> createState() => _RutaBusState();
}

class _RutaBusState extends State<RutaBus> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guayamovil'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ruta Bus', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ]
        )
      ),
    );
  }

}