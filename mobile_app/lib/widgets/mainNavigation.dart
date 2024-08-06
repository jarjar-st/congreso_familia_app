import 'package:congreso_familia_app/main.dart';
import 'package:congreso_familia_app/screens/congreso_screens/oradores.dart';

import 'package:congreso_familia_app/screens/register_page.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({
    super.key,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_add),
          label: "Registro",
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today),
          label: "Agenda",
        ),
        NavigationDestination(
          icon: Icon(Icons.people_alt),
          label: "Oradores",
        ),
        NavigationDestination(
          icon: Icon(Icons.assignment),
          label: "Resumen",
        ),
      ],
      onDestinationSelected: (value) {
        if (value == 0) {
          setState(() {
            currentIndex = value;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        } else if (value == 1) {
          setState(() {
            currentIndex = value;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioPage(),
            ),
          );

          // } else if (value == 2) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => CongresoPage(),
          //     ),
          //   );
        } else if (value == 3) {
          setState(() {
            currentIndex = value;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Oradores(),
            ),
          );
          // } else if (value == 4) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Resumen(),
          //     ),
          //   );
          // }
        }
      },
    );
  }
}
