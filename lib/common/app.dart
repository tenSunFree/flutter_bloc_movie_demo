import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_movie_demo/home/update/home_bloc.dart';
import 'package:flutter_bloc_movie_demo/home/view/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint('main.dart, MyApp, build');
    return MaterialApp(
      title: 'flutter_bloc_movie_demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: HomeScreen(),
      ),
    );
  }
}