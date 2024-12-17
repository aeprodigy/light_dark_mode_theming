// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDark = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = prefs.getBool('isDark') ?? false;
    });
  }

  void _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isDark', isDark);
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDark = isDark;
    });
    _saveTheme(isDark);
  }

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                _toggleTheme(!_isDark);
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _isDark ? Icon(
                  Icons.dark_mode,
                  key: ValueKey('dark'),
                  size: 100,
                  color: Colors.yellow,
                ) : 
                Icon(
                        Icons.light_mode,
                        key: ValueKey('light'),
                        size: 100,
                        color: Colors.orange,
                      )
                ,
              ),
            ),
            
          ),
              SizedBox(
            height: 20,
          ),
          _isDark ? Text('Dark Mode', style: TextStyle(color: Colors.white),) : Text('Light Mode')

        ],
      )),
    );
  }
}
