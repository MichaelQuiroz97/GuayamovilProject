import 'package:flutter/material.dart';
import 'package:guayamovil/ventanas/ventana_home.dart';
import 'package:guayamovil/ventanas/ventana_perfil.dart';


class HomeScreen extends StatefulWidget{
  final String cedula;
  const HomeScreen({super.key, required this.cedula});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentPageIndex=0;
  @override
  Widget build(BuildContext context){
    Theme.of(context);
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
                  builder: (BuildContext context) => VentanaPerfil(cedula: widget.cedula),
                ),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),icon: Icon(Icons.home_outlined),label: 'Home',
          ),
          NavigationDestination(icon: Badge(child: Icon(Icons.notifications_sharp)),label: 'Notifications',
          ),
          NavigationDestination(icon: Badge( label: Text('2'),child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),

      body: <Widget>[
        /// Home page
       VentanaHome(cedula: widget.cedula),
        //const Center(child:  Text("Home")),

        /// Notifications page
        const Center(child:  Text("Notificaciones")),

        /// Messages page
        const Center(child:  Text("Mensajes"))
      ][currentPageIndex],
    );

  }
  
}
