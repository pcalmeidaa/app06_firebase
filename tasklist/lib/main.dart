// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasklist/pages/criar_conta_page.dart';
import 'package:tasklist/pages/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //
  //  INICIALIZAÇÃO DO FIREBASE
  //

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      initialRoute: 'login',
      routes: {
        'login' :(context) => LoginPage(),
        'criar_conta' :(context) => CriarContaPage(),

      },
    ),
  );
}
