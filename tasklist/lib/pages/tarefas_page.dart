// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklist/pages/tarefas_exebir_widget.dart';

import '../controller/tarefas_controller.dart';
//import 'tarefas_exibir_widget.dart';
import 'util.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  var txtTitulo = TextEditingController();
  var txtDescricao = TextEditingController();

  var tarefas;

  @override
  void initState() {
    super.initState();
    tarefas = TarefasController().listar('0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade100,
            child: ListTile(
              leading: Icon(Icons.add_task_outlined),
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              title: Text(
                'Adicionar tarefa',
                style: GoogleFonts.roboto(fontSize: 22),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Adicionar',
                      style: GoogleFonts.roboto(
                        fontSize: 36,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    backgroundColor: Colors.blueGrey.shade50,
                    content: Container(
                      width: 350,
                      height: 260,
                      child: Column(
                        children: [
                          campoTexto('Título', Icons.title, txtTitulo),
                          TextField(
                            style: GoogleFonts.roboto(fontSize: 24),
                            controller: txtDescricao,
                            maxLines: 5,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              labelText: 'Descrição',
                              labelStyle: GoogleFonts.roboto(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actionsPadding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(120, 50),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'cancelar',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.blueAccent.shade700,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade700,
                          minimumSize: Size(120, 50),
                        ),
                        onPressed: () {
                          if (txtTitulo.text.isNotEmpty) {
                            TarefasController().adicionar(
                              txtTitulo.text,
                              txtDescricao.text,
                            );
                            txtTitulo.clear();
                            txtDescricao.clear();
                            sucesso(context, 'Tarefa adicionada com sucesso.');
                          } else {
                            erro(context, 'Informe o título da tarefa');
                          }

                          Navigator.pop(context);
                        },
                        child: Text(
                          'salvar',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          //
          // EXIBIR TAREFAS
          //
          TarefasExibirWidget(
            tarefas,
            Colors.yellowAccent.shade100,
            Icons.electric_bolt,
            '1',
          ),
        ],
      ),
    );
  }
}
