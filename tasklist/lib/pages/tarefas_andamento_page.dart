// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tasklist/pages/tarefas_exebir_widget.dart';

import '../controller/tarefas_controller.dart';
//import 'tarefas_exibir_widget.dart';

class TarefasAndamentoPage extends StatefulWidget {
  const TarefasAndamentoPage({Key? key}) : super(key: key);

  @override
  State<TarefasAndamentoPage> createState() => _TarefasAndamentoPageState();
}

class _TarefasAndamentoPageState extends State<TarefasAndamentoPage> {
  var tarefas;

  @override
  void initState() {
    super.initState();
    tarefas = TarefasController().listar('1');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
      child: Column(
        children: [
          TarefasExibirWidget(
            tarefas,
            Colors.orangeAccent.shade100,
            Icons.check_circle_outline,
            '2',
          ),
        ],
      ),
    );
  }
}
