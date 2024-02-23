import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:congreso_familia_app/config.dart';

Future<List> fetchHorarios() async {
  final response = await http.get(Uri.parse(
      '${Config.API_URL}/api/horarios?populate[orador][populate][Imagenes][fields]=url&populate[orador][fields]=Nombre&fields[1]=Titulo&fields[2]=Fecha&fields[3]=Inicio&fields[4]=Final&fields[5]=Resumen&filters[Tipo][\$eq]=charla'));

  if (response.statusCode == 200) {
    var res = jsonDecode(response.body);
    List resList = res["data"];
    resList.sort((a, b) {
      DateTime fechaA = DateTime.parse(a["attributes"]["Fecha"]).toUtc();
      DateTime fechaB = DateTime.parse(b["attributes"]["Fecha"]).toUtc();
      return fechaA.compareTo(fechaB);
    });
    print("ESTA ES LA DATAAAAAA: ${res["data"][0]["attributes"]}");
    return resList;
  } else {
    throw Exception('Failed to load oradores');
  }
}

class resumenPage extends StatefulWidget {
  const resumenPage({super.key});

  @override
  State<resumenPage> createState() => _resumenPageState();
}

class _resumenPageState extends State<resumenPage> {
  Widget buildRichText(List<dynamic> data) {
    List<Widget> children = [];

    for (var item in data) {
      if (item['type'] == 'paragraph') {
        for (var child in item['children']) {
          if (child['bold'] == true) {
            children.add(
              Text(
                child['text'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          } else {
            children.add(Text(child['text']));
          }
        }
      } else if (item['type'] == 'list') {
        for (var listItem in item['children']) {
          children.add(
            Text(
              '• ' + listItem['children'][0]['text'],
            ),
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchHorarios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
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
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${Config.API_URL}${snapshot.data![index]['attributes']['orador']["data"]["attributes"]["Imagenes"]["data"][0]["attributes"]["url"]}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      '${snapshot.data![index]['attributes']['Titulo']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${fechaFormateada} - ${horaInicio12h} ',
                    ),

                    // trailing: const Column(
                    //   children: [
                    //     Text("Ver mas"),
                    //     Icon(Icons.arrow_drop_down),
                    //   ],
                    // ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15.0),
                              buildRichText(snapshot.data![index]['attributes']
                                  ['Resumen']),
                              const SizedBox(height: 15.0),
                              Text(
                                'Orador: ${snapshot.data![index]['attributes']['orador']["data"]["attributes"]["Nombre"]}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text(
              "Ocurrio esto: ${snapshot.error} y esto: ${snapshot.data}");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
