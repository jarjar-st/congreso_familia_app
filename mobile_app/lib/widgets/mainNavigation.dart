import 'package:flutter/material.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
    );
  }
}
