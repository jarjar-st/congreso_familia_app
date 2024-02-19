import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=14.08337483595821,-87.1794319991498');

class ContactoPage extends StatelessWidget {
  List contactViewList = [
    const ListTile(
      iconColor: Colors.green,
      leading: Icon(
        Icons.map_outlined,
        size: 35,
      ),
      title: Text('Ubicación'),
      subtitle: Text('Dirección del Congreso'),
      onTap: launchUrlInit,
    ),
    ListTile(
      iconColor: Colors.green,
      leading: const Icon(
        Icons.mail,
        size: 35,
      ),
      title: const Text('Correo'),
      subtitle: const Text('Solicite Información'),
      onTap: () {
        final Uri params = Uri(
          scheme: 'mailto',
          path: 'example@example.com', // Reemplaza con tu dirección de correo
          query:
              'subject=Solicitud de Información&body=Hola, me gustaría solicitar más información.',
        );

        var url = params;
        launchUrl(url);
      },
    ),
    ListTile(
      iconColor: Colors.green,
      leading: const Icon(
        Icons.phone,
        size: 35,
      ),
      title: const Text('Llamar'),
      subtitle: const Text('Pregunte por el Congreso'),
      onTap: () {
        final Uri params = Uri(
          scheme: 'tel',
          path: '+1234567890', // Reemplaza con tu número de teléfono
        );
        launchUrl(params); // Reemplaza con tu número de teléfono
      },
    ),
  ];

  ContactoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contactViewList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) => contactViewList[index],
    );
  }
}

Future<void> launchUrlInit() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
