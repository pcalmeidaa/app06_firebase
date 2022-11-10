// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/login_controller.dart';
import 'tarefas_andamento_page.dart';
import 'tarefas_concluidas_page.dart';
import 'tarefas_page.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  var tarefas;

  // Telas de Navegecao
  final List<Widget> telas = [
    TarefasPage(),
    TarefasAndamentoPage(),
    TarefasConcluidasPage(),
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Tarefas',
                style: GoogleFonts.kanit(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_box,
                  size: 14,
                ),

                //
                // TODO: Retornar usuário logado
                //
                FutureBuilder<String>(
                  future: LoginController().retornarUsuarioLogado(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent.shade700,
        actions: [
          IconButton(
            tooltip: 'sair',
            onPressed: () {
              LoginController().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                'login',
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: telas[index],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        currentIndex: index,
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_outlined,
            ),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.electric_bolt_outlined,
            ),
            label: 'Em andamento',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Concluído',
          ),
        ],
      ),
    );
  }
}
