import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:congreso_familia_app/config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List> fetchOradores() async {
  final response = await http.get(Uri.parse(
      '${Config.API_URL}/api/oradores?populate[horarios][fields][0]=Titulo&populate[horarios][fields][1]=Fecha&populate[Imagenes][fields]=url&populate[Imagenes][fields]=formats'));

  if (response.statusCode == 200) {
    var res = jsonDecode(response.body);
    List resList = res["data"];
    print("ESTA ES LA DATAAAAAA: ${res["data"][0]["attributes"]}");
    print(res["data"][0]["attributes"]["Nombre"]);
    return resList;
  } else {
    throw Exception('Failed to load oradores');
  }
}

class Oradores extends StatelessWidget {
  // List oradoresList = [
  //   {
  //     'nombre': 'Cardenal Oscar Rodriguez',
  //     'tema': 'Miercoles 29\nJueves 30\nViernes 31',
  //     'imagen':
  //         'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww',
  //     'biografia':
  //         'Es un cardenal hondureño, arzobispo de Tegucigalpa y presidente de Caritas Internacional. '
  //             'Es conocido por su labor en la defensa de los derechos humanos y por su compromiso con la justicia social.'
  //   },
  //   {
  //     'nombre': 'Orador 2',
  //     'tema': 'Tema de la charla',
  //     'imagen':
  //         'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fHww',
  //     'biografia': 'Cardenal Oscar Rodriguez Maradiaga\n\n'
  //         'Es un cardenal hondureño, arzobispo de Tegucigalpa y presidente de Caritas Internacional. '
  //         'Es conocido por su labor en la defensa de los derechos humanos y por su compromiso con la justicia social.'
  //   },
  //   {
  //     'nombre': 'Orador 3',
  //     'tema': 'Tema de la charla',
  //     'imagen':
  //         'https://plus.unsplash.com/premium_photo-1658527049634-15142565537a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YXZhdGFyfGVufDB8fDB8fHww',
  //     'biografia': 'Cardenal Oscar Rodriguez Maradiaga\n\n'
  //         'Es un cardenal hondureño, arzobispo de Tegucigalpa y presidente de Caritas Internacional. '
  //         'Es conocido por su labor en la defensa de los derechos humanos y por su compromiso con la justicia social.'
  //   },
  // ];
  Oradores({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: ListView.separated(
  //       itemCount: oradoresList.length,
  //       separatorBuilder: (BuildContext context, int index) => Divider(),
  //       itemBuilder: (BuildContext context, int index) {
  //         var temas = oradoresList[index]['tema'].split('\n');
  //         return ListTile(
  //           // leading: CircleAvatar(
  //           //   foregroundColor: Colors.blue,
  //           //   radius: 40,
  //           //   backgroundImage: NetworkImage('${oradoresList[index]['imagen']}'),
  //           // ),
  //           leading: ClipOval(
  //             child: Image.network(
  //               '${oradoresList[index]['imagen']}',
  //               width: 60,
  //               height: 60,
  //               fit: BoxFit.cover,
  //               alignment: Alignment.topCenter,
  //             ),
  //           ),
  //           title: Text('${oradoresList[index]['nombre']}'),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: temas.map<Widget>((tema) {
  //               return Row(
  //                 children: [
  //                   Text('• ', style: TextStyle(fontSize: 16)),
  //                   Expanded(child: Text(tema)),
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) =>
  //                     OradorDetalle(orador: oradoresList[index]),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
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
    return SafeArea(
      child: FutureBuilder(
          future: fetchOradores(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List temasList =
                      snapshot.data![index]['attributes']['horarios']["data"];
                  print(temasList);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              '${Config.API_URL}${snapshot.data![index]['attributes']['Imagenes']["data"][0]["attributes"]["formats"]["thumbnail"]["url"]}',
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
                        '${snapshot.data![index]['attributes']['Nombre']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (snapshot
                                          .data![index]['attributes']
                                              ['Imagenes']["data"]
                                          .length >
                                      1)
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${Config.API_URL}${snapshot.data![index]['attributes']['Imagenes']["data"][1]["attributes"]["formats"]["medium"]["url"]}',
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      fit: BoxFit.cover,
                                      alignment: const Alignment(0, -0.5),
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          LinearProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          'http://10.0.2.2:1337${snapshot.data![index]['attributes']['Imagenes']["data"][0]["attributes"]["formats"]["medium"]["url"]}',
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      fit: BoxFit.cover,
                                      alignment: const Alignment(0, -0.5),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              LinearProgressIndicator(
                                        value: downloadProgress.progress,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${snapshot.data![index]['attributes']['Nombre']}',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              buildRichText(snapshot.data![index]['attributes']
                                  ['Biografia']),
                              // Text(
                              //   '${snapshot.data![index]['attributes']['Biografia'][0]["children"][0]["text"]}',
                              //   style: const TextStyle(
                              //     fontSize: 15.0,
                              //   ),
                              // ),
                              const SizedBox(height: 15.0),
                              (temasList.isNotEmpty)
                                  ? const Text("Horarios:")
                                  : Container(),
                              const SizedBox(height: 15.0),
                              (temasList.isNotEmpty)
                                  ? Column(
                                      children: temasList
                                          .map<Widget>((tema) {
                                            // Parse the date string into a DateTime object
                                            DateTime fecha = DateTime.parse(
                                                    tema["attributes"]["Fecha"])
                                                .toUtc();

                                            fecha = fecha
                                                .subtract(Duration(hours: 6));

                                            // Format the DateTime object into a more visual string
                                            String fechaFormateada = DateFormat(
                                                    'dd-MMMM-yyyy – hh:mm a')
                                                .format(fecha);

                                            return Row(
                                              children: [
                                                const Text(
                                                  '• ',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      '${tema["attributes"]["Titulo"]} - $fechaFormateada'),
                                                ),
                                              ],
                                            );
                                          })
                                          .toList()
                                          .cast<Widget>()
                                          .toList(),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(
                  "Ocurrio esto: ${snapshot.error} y esto: ${snapshot.data}");
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class OradorDetalle extends StatelessWidget {
  final Map orador;

  const OradorDetalle({Key? key, required this.orador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(orador['nombre']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.network(orador['imagen']),
            const SizedBox(height: 8.0),
            Text(
              orador['nombre'],
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(orador['biografia']),
          ],
        ),
      ),
    );
  }
}
