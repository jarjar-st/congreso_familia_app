import 'dart:convert';

import 'package:congreso_familia_app/config.dart';
import 'package:congreso_familia_app/controller/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  @override
  Widget build(BuildContext context) {
    List registroViewList = [
      ListTile(
        iconColor: Colors.blue,
        leading: const Icon(
          Icons.person_add,
          size: 35,
        ),
        title: const Text('Registrar Asistencia'),
        subtitle: const Text('Registre su asistencia al Congreso'),
        onTap: () {
          Get.find<Controller>().changeTabIndex(1);
        },
      ),
    ];

    return ListView.builder(
      itemCount: registroViewList.length,
      itemBuilder: (context, index) => registroViewList[index],
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();
  final nombreControler = TextEditingController();
  final apellidosControler = TextEditingController();
  final dniControler = TextEditingController();
  final emailControler = TextEditingController();
  final celularControler = TextEditingController();
  final nombreConyugeControler = TextEditingController();
  final apellidosConyugeControler = TextEditingController();
  final parroquiaControler = TextEditingController();
  final grupoControler = TextEditingController();

  Color emailBorderColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isEmpty || !regex.hasMatch(value)
          ? 'Ingrese un correo válido'
          : null;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // const Row(
              //   children: [
              //     Text("Nombre"),
              //   ],
              // ),
              // const SizedBox(height: 10),

              TextFormField(
                keyboardType: TextInputType.name,
                controller: nombreControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: apellidosControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: dniControler,
                maxLength: 15,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  MyCustomFormatter(),
                ],
                decoration: const InputDecoration(
                  counterText: '',
                  labelText: 'DNI',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su numero de Identidad';
                  }
                  if (value.length < 15) {
                    return 'El número de cédula debe tener 12 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                ],
                controller: emailControler,
                decoration: InputDecoration(
                  labelText: 'Correo Electronico',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: emailBorderColor, width: 1.0),
                  ),
                ),
                validator: validateEmail,
                onChanged: (value) {
                  setState(
                    () {
                      if (validateEmail(value) == null) {
                        emailBorderColor = const Color(0xFFE91e63);
                      } else {
                        emailBorderColor = Colors.grey.shade300;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: celularControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                maxLength: 8,
                decoration: const InputDecoration(
                  counterText: '',
                  labelText: 'Celular',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Por favor ingrese su Celular';
                //   }
                //   return null;
                // },
              ),

              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nombreConyugeControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Nombre de Esposa/o',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de su esposa/o';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: apellidosConyugeControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Apellidos de Esposa/o',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los apellidos de su esposa/o';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: parroquiaControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Parroquia en la que se congrega',
                  hintText: 'Si no se congrega colocar: "${'No me congrego'}"',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: grupoControler,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Movimiento/grupo al que pertenece',
                  hintText:
                      'Si no se pertenece a ninguno colocar: "${'No pertenezco a ningun movimiento o grupo'}"',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: const Text(
                          'Procesando Datos...',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );

                    var body = {
                      'data': {
                        'Nombre': nombreControler.text,
                        'Apellido': apellidosControler.text,
                        'Identidad': dniControler.text,
                        'Correo': emailControler.text,
                        'Celular': celularControler.text,
                        'NombreConyuge': nombreConyugeControler.text,
                        'ApellidoConyuge': apellidosConyugeControler.text,
                        'Parroquia': parroquiaControler.text,
                        'Grupo': grupoControler.text,
                      }
                    };

                    String result = await registerUser(body);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 5),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: result == 'Registro creado con éxito'
                            ? Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: Text(
                          result,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );

                    // try {
                    //   var response = await http.post(
                    //     Uri.parse('http://10.0.2.2:3002/register'),
                    //     headers: {"Content-Type": "application/json"},
                    //     body: jsonEncode(body),
                    //   );

                    //   print("ESTE ES EL RESPONSE: ${response.body}");

                    //   if (response.statusCode == 409) {
                    //     // Muestra un mensaje al usuario
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //           content: Text(
                    //               'El correo electrónico ya está registrado')),
                    //     );
                    //   } else if (response.statusCode == 201) {
                    //     print('Registro creado con éxito');
                    //   } else {
                    //     print('Error al crear el registro');
                    //   }
                    // } catch (e) {
                    //   print("ESTE ES EL ERROR: $e");
                    //   if (e.toString().contains(
                    //       'El correo electrónico ya está registrado')) {
                    //     // Muestra un mensaje al usuario
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //           content: Text(
                    //               'El correo electrónico ya está registrado')),
                    //     );
                    //   }
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //         content: Text(
                    //             'Error al registrar, intente nuevamente')),
                    //   );
                    // }
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> registerUser(Map<String, dynamic> body) async {
  try {
    final response = await http.post(
      Uri.parse('${Config.API_URL}/api/participantes'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return 'Registro creado con éxito';
    } else if (response.statusCode == 400) {
      final errors =
          jsonDecode(response.body)['error']['details']['errors'] as List;
      for (var error in errors) {
        if (error['path'][0] == 'Correo') {
          return 'El correo electrónico ya está registrado';
        }
        if (error['path'][0] == 'Identidad') {
          return 'El número de Identidad ya está registrado';
        }
      }
      return 'Error al crear el registro: ${response.body}';
    } else {
      return 'Error al crear el registro: ${response.statusCode}';
    }
  } catch (e) {
    return 'Error de conexión: $e';
  }
}

class MyCustomFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll('-', '');
    String formattedText;
    if (newText.length <= 4) {
      formattedText = newText;
    } else if (newText.length <= 8) {
      formattedText = '${newText.substring(0, 4)}-${newText.substring(4)}';
    } else {
      formattedText =
          '${newText.substring(0, 4)}-${newText.substring(4, 8)}-${newText.substring(8)}';
    }

    // Calcula la nueva posición del cursor
    int offset = newValue.selection.start;
    if (offset > 4) offset++;
    if (offset > 9) offset++;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
