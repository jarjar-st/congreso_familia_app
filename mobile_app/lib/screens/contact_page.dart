import 'package:flutter/material.dart';

class ContactoPage extends StatelessWidget {
  List contactViewList = [
    ListTile(
      iconColor: Colors.green,
      leading: const Icon(
        Icons.map_outlined,
        size: 35,
      ),
      title: const Text('Ubicación'),
      subtitle: const Text('Dirección del Congreso'),
      onTap: () {},
    ),
    ListTile(
      iconColor: Colors.green,
      leading: const Icon(
        Icons.mail,
        size: 35,
      ),
      title: const Text('Correo'),
      subtitle: const Text('Solicite Información'),
      onTap: () {},
    ),
    ListTile(
      iconColor: Colors.green,
      leading: const Icon(
        Icons.phone,
        size: 35,
      ),
      title: const Text('Llamar'),
      subtitle: const Text('Pregunte por el Congreso'),
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contactViewList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) => contactViewList[index],
    );
  }
}
