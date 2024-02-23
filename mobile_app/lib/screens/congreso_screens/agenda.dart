import 'package:congreso_familia_app/config.dart';
import 'package:congreso_familia_app/screens/congreso_screens/resumen.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List> fetchHorarios() async {
  final response = await http.get(Uri.parse(
      '${Config.API_URL}/api/horarios?fields[0]=Titulo&fields[1]=Tipo&fields[2]=Fecha&fields[3]=Inicio&fields[4]=Final'));

  if (response.statusCode == 200) {
    var res = jsonDecode(response.body);
    List resList = res["data"];

    // Ordenar la lista por fecha y hora
    resList.sort((a, b) {
      DateTime fechaA = DateTime.parse(a["attributes"]["Fecha"]).toUtc();
      DateTime fechaB = DateTime.parse(b["attributes"]["Fecha"]).toUtc();
      return fechaA.compareTo(fechaB);
    });

    print("ESTA ES LA DATAAAAAA: ${res["data"]}");
    return resList;
  } else {
    throw Exception('Failed to load oradores');
  }
}

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  // final List agendaList = [
  //   {
  //     'hora': '10:00 am',
  //     'titulo': 'Apertura',
  //     'tipo': 'apertura',
  //   },
  //   {
  //     'hora': '11:00 am',
  //     'titulo': '1ra Conferencia',
  //     'tipo': 'charla',
  //   },
  //   {
  //     'hora': '12:00 pm',
  //     'titulo': 'Almuerzo',
  //     'tipo': 'almuerzo',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchHorarios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              DateTime fecha =
                  DateTime.parse(snapshot.data![index]["attributes"]["Fecha"])
                      .toUtc();
              DateFormat inputFormat = DateFormat("HH:mm:ss.SSS");
              DateFormat outputFormat = DateFormat("h:mm a");

              DateTime horaInicio = inputFormat
                  .parse(snapshot.data![index]["attributes"]["Inicio"]);
              String horaInicio12h = outputFormat.format(horaInicio);

              DateTime horaFinal = inputFormat
                  .parse(snapshot.data![index]["attributes"]["Final"]);
              String horaFinal12h = outputFormat.format(horaFinal);

              // horaInicio = horaInicio.subtract(Duration(hours: 6));
              // horaFinal = horaInicio.subtract(Duration(hours: 6));

              // Format the DateTime object into a more visual string
              String fechaFormateada = DateFormat('dd-MMMM').format(fecha);
              // String horaInicioFormateada =
              //     DateFormat('hh:mm a').format(horaInicio);
              // String horaFinalFormateada =
              //     DateFormat('hh:mm a').format(horaFinal);

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                color: Colors.white70,
                child: ListTile(
                  leading: Icon(
                    snapshot.data![index]['attributes']["Tipo"] == 'charla'
                        ? Icons.group
                        : snapshot.data![index]['attributes']["Tipo"] ==
                                'apertura'
                            ? Icons.content_cut
                            : Icons.dining,
                    size: 40,
                  ),
                  // title: Text('${agendaList[index]['hora']}'),
                  title: Text(
                    '${snapshot.data![index]['attributes']["Titulo"]}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$fechaFormateada\n',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: '$horaInicio12h - $horaFinal12h',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
