import 'package:congreso_familia_app/controller/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongresoPage extends StatelessWidget {
  List congresoViewList = [
    ListTile(
      iconColor: Colors.orange,
      leading: const Icon(
        Icons.calendar_today,
        size: 35,
      ),
      title: const Text('Agenda'),
      subtitle: const Text('Programa de Charlas'),
      onTap: () {
        Get.find<Controller>().changeTabIndex(2);
      },
    ),
    ListTile(
      iconColor: Colors.orange,
      leading: const Icon(
        Icons.people_alt,
        size: 35,
      ),
      title: const Text('Oradores'),
      subtitle: const Text('Oradores de la Conferencia'),
      onTap: () {
        Get.find<Controller>().changeTabIndex(3);
      },
    ),
    ListTile(
      iconColor: Colors.orange,
      leading: const Icon(
        Icons.assignment,
        size: 35,
      ),
      title: const Text('Resumen'),
      subtitle: const Text('Vea cuales son las charlas de la conferencia'),
      onTap: () {
        Get.find<Controller>().changeTabIndex(4);
      },
    ),
  ];

  CongresoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: congresoViewList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (context, index) => congresoViewList[index],
    );
  }
}
