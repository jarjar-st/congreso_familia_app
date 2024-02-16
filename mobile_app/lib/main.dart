import 'package:congreso_familia_app/screens/congreso_page.dart';
import 'package:congreso_familia_app/screens/contact_page.dart';
import 'package:congreso_familia_app/screens/register_page.dart';
import 'package:congreso_familia_app/widgets/carousel.dart';
import 'package:congreso_familia_app/widgets/mainNavigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  Color _color = Colors.black;
  Color _color2 = Colors.black;
  Color _color3 = Colors.black;

  final List<Widget> _children = [
    RegistroPage(),
    CongresoPage(),
    ContactoPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congreso de Programación'),
      ),
      body: Column(
        children: [
          Carousel(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _currentIndex == 0
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        onTabTapped(0);
                        _color = Colors.blue;
                        _color2 = Colors.black;
                        _color3 = Colors.black;
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: _color,
                      ),
                      child: Text('REGISTRO '),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _currentIndex == 1
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        onTabTapped(1);
                        _color2 = Colors.orange;
                        _color = Colors.black;
                        _color3 = Colors.black;
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: _color2,
                      ),
                      child: Text('CONGRESO'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _currentIndex == 2
                              ? Colors.green
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        onTabTapped(2);
                        _color3 = Colors.green;
                        _color = Colors.black;
                        _color2 = Colors.black;
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: _color3,
                      ),
                      child: Text('CONTACTO'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _children[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: MainNavigation(),
    );
  }
}
