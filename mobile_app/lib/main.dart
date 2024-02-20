import 'package:congreso_familia_app/screens/congreso_screens/oradores.dart';
import 'package:congreso_familia_app/screens/home_page.dart';
import 'package:congreso_familia_app/screens/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Home(),
    FormularioPage(),
    Oradores(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text('Congreso de la Familia'),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
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
            onTabTapped(value);
          },
        ),
      ),
    );
  }
}
