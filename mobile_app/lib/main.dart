import 'package:congreso_familia_app/screens/congreso_screens/agenda.dart';
import 'package:congreso_familia_app/screens/congreso_screens/oradores.dart';
import 'package:congreso_familia_app/screens/congreso_screens/resumen.dart';
import 'package:congreso_familia_app/screens/home_page.dart';
import 'package:congreso_familia_app/screens/register_page.dart';
import 'package:congreso_familia_app/screens/web_view_page.dart'; // Importa la nueva pantalla
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:congreso_familia_app/controller/menu_controller.dart';

void main() {
  initializeDateFormatting('es', null).then((_) {
    Intl.defaultLocale = 'es';
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Controller c = Get.put(Controller());

  final List<Widget> _children = [
    const Home(),
    // const FormularioPage(),
    const FormWebViewPage(),
    const AgendaScreen(),
    const Oradores(),
    const resumenPage(),
  ];

  final List _title = [
    'Congreso de la Familia',
    'Registro',
    // 'Registro',
    'Agenda',
    'Oradores',
    'Resumen',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<Controller>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.blue,
              title: Text('${_title[controller.currentIndex.value]}'),
            ),
            body: _children[controller.currentIndex.value],
            bottomNavigationBar: NavigationBar(
              selectedIndex: controller.currentIndex.value,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Inicio",
                ),
                // NavigationDestination(
                //   icon: Icon(Icons.person_add),
                //   label: "Registro",
                // ),
                NavigationDestination(
                  icon: Icon(Icons.person_add),
                  label:
                      "Registro", // Añade el icono y etiqueta para la nueva pestaña
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
                controller.changeTabIndex(value);
              },
            ),
          );
        },
      ),
    );
  }
}
