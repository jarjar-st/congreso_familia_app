import 'package:flutter/material.dart';

class CongresoPage extends StatelessWidget {
  List congresoViewList = [
    ListTile(
      iconColor: Colors.orange,
      leading: const Icon(
        Icons.calendar_today,
        size: 35,
      ),
      title: const Text('Agencia'),
      subtitle: const Text('Programa de Charlas'),
      onTap: () {},
    ),
    ListTile(
      iconColor: Colors.orange,
      leading: const Icon(
        Icons.people_alt,
        size: 35,
      ),
      title: const Text('Oradores'),
      subtitle: const Text('Oradores de la Conferencia'),
      onTap: () {},
    ),
    ListTile(
      iconColor: Colors.orange,
      leading: const Icon(
        Icons.assignment,
        size: 35,
      ),
      title: const Text('Resumen'),
      subtitle: const Text('Vea cuales son las charlas de la conferencia'),
      onTap: () {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: congresoViewList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) => congresoViewList[index],
    );
  }
}
