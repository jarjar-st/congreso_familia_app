import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

List<dynamic>? _cachedHorarios;

// Future<List> fetchHorarios() async {
//   // Paso 2: Verificar si los datos ya están almacenados
//   if (_cachedHorarios != null) {
//     return _cachedHorarios!;
//   }

//   // Paso 3: Obtener los datos si no están almacenados
//   final response = await http.get(Uri.parse(
//       'https://24studiohnserver.com/api/congreso/api/horarios?populate[orador][populate][Imagenes][fields]=url&populate[orador][populate][Imagenes][fields]=formats&populate[orador][fields]=Nombre&fields[1]=Titulo&fields[2]=Fecha&fields[3]=Inicio&fields[4]=Final&fields[5]=Resumen&filters[Tipo][\$eq]=charla'));

//   if (response.statusCode == 200) {
//     print("ESTE ES EL ERROR ttt: ${response.statusCode}");
//     print("ESTE ES EL ERROR tewr: ${response.body}");

//     var res = jsonDecode(response.body);
//     List resList = res["data"];
//     resList.sort((a, b) {
//       DateTime fechaA = DateTime.parse(a["attributes"]["Fecha"]).toUtc();
//       DateTime fechaB = DateTime.parse(b["attributes"]["Fecha"]).toUtc();
//       return fechaA.compareTo(fechaB);
//     });
//     print("ESTA ES LA DATAAAAAA: ${res["data"][0]["attributes"]}");

//     // Almacenar los datos obtenidos para uso futuro
//     _cachedHorarios = resList;
//     return resList;
//   } else {
//     print("ESTE ES EL ERROR: ${response.statusCode}");
//     throw Exception('Failed to load oradores');
//   }
// }

class resumenPage extends StatefulWidget {
  const resumenPage({super.key});

  @override
  State<resumenPage> createState() => _resumenPageState();
}

class _resumenPageState extends State<resumenPage> {
  Future<List<dynamic>> fetchResumeLocal() async {
    print("entroooooo");
    // Carga el archivo JSON como un string
    String jsonString = await rootBundle.loadString('assets/data/resumen.json');
    print("ESTO ESTA DENTRO DEL JJJJJJJJSSSSSSOOOOON: $jsonString");

    // Decodifica el string JSON a una lista de mapas
    var jsonData = jsonDecode(jsonString);

    List resList = jsonData["data"];

    print("ESTO ESTA DENTRO DEL JJJJJJJJSSSSSSOOOOON: $jsonData");

    return resList;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchResumeLocal();
    super.initState();
  }

  Widget buildRichText(List<dynamic> data) {
    List<TextSpan> children = [];

    for (var item in data) {
      if (item['type'] == 'paragraph') {
        for (var child in item['children']) {
          if (child['bold'] == true && child['italic'] == true) {
            children.add(
              TextSpan(
                text: child['text'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          }
          if (child['bold'] == true && child['italic'] == null) {
            children.add(
              TextSpan(
                text: child['text'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (child['bold'] == null && child['italic'] == true) {
            children.add(
              TextSpan(
                text: child['text'],
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          }
          if (child['bold'] == null && child['italic'] == null) {
            children.add(
              TextSpan(
                text: child['text'],
              ),
            );
          }
        }
      } else if (item['type'] == 'list') {
        children.add(
          const TextSpan(
            text: '\n',
          ),
        );
        for (var listItem in item['children']) {
          for (var i = 0; i < listItem['children'].length; i++) {
            if (i == 0) {
              if (listItem['children'][i]["bold"] == true &&
                  listItem['children'][i]["italic"] == true) {
                children.add(
                  TextSpan(
                    text: '\n• ' + listItem['children'][i]['text'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
              if (listItem['children'][i]["bold"] == true &&
                  listItem['children'][i]["italic"] == null) {
                children.add(
                  TextSpan(
                    text: '\n• ' + listItem['children'][i]['text'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if (listItem['children'][i]["bold"] == null &&
                  listItem['children'][i]["italic"] == true) {
                children.add(
                  TextSpan(
                    text: '\n• ' + listItem['children'][i]['text'],
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
              if (listItem['children'][i]["bold"] == null &&
                  listItem['children'][i]["italic"] == null) {
                children.add(
                  TextSpan(
                    text: '\n• ' + listItem['children'][i]['text'],
                  ),
                );
              }
            } else {
              if (listItem['children'][i]["bold"] == true &&
                  listItem['children'][i]["italic"] == true) {
                children.add(
                  TextSpan(
                    text: listItem['children'][i]['text'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
              if (listItem['children'][i]["bold"] == true &&
                  listItem['children'][i]["italic"] == null) {
                children.add(
                  TextSpan(
                    text: listItem['children'][i]['text'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if (listItem['children'][i]["bold"] == null &&
                  listItem['children'][i]["italic"] == true) {
                children.add(
                  TextSpan(
                    text: listItem['children'][i]['text'],
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
              if (listItem['children'][i]["bold"] == null &&
                  listItem['children'][i]["italic"] == null) {
                children.add(
                  TextSpan(
                    text: listItem['children'][i]['text'],
                  ),
                );
              }
            }
          }
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            children: children,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchResumeLocal(),
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
                      // child: CachedNetworkImage(
                      //   imageUrl:
                      //       'https://24studiohnserver.com/api/congreso/${snapshot.data![index]['attributes']['orador']["data"]["attributes"]["Imagenes"]["data"][0]["attributes"]["formats"]["thumbnail"]["url"]}',
                      //   width: 60,
                      //   height: 60,
                      //   fit: BoxFit.cover,
                      //   alignment: Alignment.topCenter,
                      //   progressIndicatorBuilder:
                      //       (context, url, downloadProgress) =>
                      //           CircularProgressIndicator(
                      //               value: downloadProgress.progress),
                      //   errorWidget: (context, url, error) =>
                      //       const Icon(Icons.error),
                      // ),
                      child: Image.asset(
                        "${snapshot.data![index]['attributes']['orador']["data"]["attributes"]["Imagenes"]["data"][0]["attributes"]["formats"]["thumbnail"]["url"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    title: Text(
                      '${snapshot.data![index]['attributes']['Titulo']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '$fechaFormateada - $horaInicio12h ',
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
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15.0),
                              // buildRichText(snapshot.data![index]['attributes']
                              //     ['Resumen']),
                              // const SizedBox(height: 15.0),
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
              return null;
            },
          );
        } else if (snapshot.hasError) {
          print("ESTE ES EL ERROR: ${snapshot.error}");
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
