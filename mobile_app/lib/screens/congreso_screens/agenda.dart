import 'package:congreso_familia_app/screens/congreso_screens/resumen.dart';
import 'package:flutter/material.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final List agendaList = [
    {
      'hora': '10:00 am',
      'titulo': 'Apertura',
      'tipo': 'apertura',
    },
    {
      'hora': '11:00 am',
      'titulo': '1ra Conferencia',
      'tipo': 'charla',
    },
    {
      'hora': '12:00 pm',
      'titulo': 'Almuerzo',
      'tipo': 'almuerzo',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: agendaList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            agendaList[index]['tipo'] == 'charla'
                ? Icons.group
                : agendaList[index]['tipo'] == 'apertura'
                    ? Icons.content_cut
                    : Icons.dining,
            size: 40,
          ),
          title: Text('${agendaList[index]['hora']}'),
          subtitle: Text('${agendaList[index]['titulo']}'),
          onTap: () {
            if (agendaList[index]['tipo'] == 'charla') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => resumenPage(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
