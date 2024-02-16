import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioPage()),
          );
        },
      ),
    ];

    return ListView.separated(
      itemCount: registroViewList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: SingleChildScrollView(
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
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
                  maxLength: 15,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    MyCustomFormatter(),
                  ],
                  decoration: const InputDecoration(
                    counterText: '',
                    labelText: 'DNI - Identidad',
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
                    labelText: 'Correo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide:
                          BorderSide(color: emailBorderColor, width: 1.0),
                    ),
                  ),
                  validator: validateEmail,
                  onChanged: (value) {
                    setState(
                      () {
                        if (validateEmail(value) == null) {
                          emailBorderColor = Color(0xFFE91e63);
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Parroquia en la que se congrega',
                    hintText:
                        'Si no se congrega colocar: "${'No me congrego'}"',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Si el formulario es válido, muestra un snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Procesando Datos')));

                      print(emailControler.text);
                    }
                  },
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
