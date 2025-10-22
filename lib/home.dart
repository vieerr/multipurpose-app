import 'package:flutter/material.dart';

import 'coins/view/vuelto_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Super App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shadowColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Add menu functionality here if needed
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Add notifications functionality here if needed
            },
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: <Widget>[
        Card(child: Center(child: Text("Inicio"))),
        VueltoPage(),
        Card(child: Center(child: Text("Ejercicio 13"))),
        Card(child: Center(child: Text("Ejercicio 14"))),
        Card(child: Center(child: Text("Ejercicio 15"))),
      ][currentPageIndex],
    );
  }

  NavigationBar _bottomNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      // indicatorColor: Colors.blueAccent,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.shop), label: "Cajero"),
        NavigationDestination(
          icon: Icon(Icons.monetization_on),
          label: "Monedas",
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: "Bisiesto",
        ),
        NavigationDestination(icon: Icon(Icons.check), label: "Perfecto"),
        NavigationDestination(icon: Icon(Icons.food_bank), label: "Dieta"),
      ],
    );
  }
}
