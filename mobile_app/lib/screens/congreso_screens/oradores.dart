import 'package:flutter/material.dart';

class Oradores extends StatelessWidget {
  List oradoresList = [
    {
      'nombre': 'Cardenal Oscar Rodriguez',
      'tema': 'Miercoles 29\nJueves 30\nViernes 31',
      'imagen':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww'
    },
    {
      'nombre': 'Orador 2',
      'tema': 'Tema de la charla',
      'imagen':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fHww'
    },
    {
      'nombre': 'Orador 3',
      'tema': 'Tema de la charla',
      'imagen':
          'https://plus.unsplash.com/premium_photo-1658527049634-15142565537a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YXZhdGFyfGVufDB8fDB8fHww'
    },
  ];
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: oradoresList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: ClipOval(
              child: Image.network(
                '${oradoresList[index]['imagen']}',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            title: Text('${oradoresList[index]['nombre']}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      '${oradoresList[index]['imagen']}',
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${oradoresList[index]['nombre']}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    SizedBox(height: 30.0),
                    // Text('${oradoresList[index]['biografia']}'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OradorDetalle extends StatelessWidget {
  final Map orador;

  OradorDetalle({Key? key, required this.orador}) : super(key: key);

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
            SizedBox(height: 8.0),
            Text(orador['nombre'], style: TextStyle(fontSize: 24.0)),
            SizedBox(height: 8.0),
            // Text(orador['biografia']),
          ],
        ),
      ),
    );
  }
}
