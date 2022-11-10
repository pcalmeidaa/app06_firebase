// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/tarefas_controller.dart';
import 'util.dart';

class TarefasExibirWidget extends StatefulWidget {
  final tarefas;
  final cor;
  final icone;
  final status;

  const TarefasExibirWidget(this.tarefas, this.cor, this.icone, this.status,
      {Key? key})
      : super(key: key);

  @override
  State<TarefasExibirWidget> createState() => _TarefasExibirWidgetState();
}

class _TarefasExibirWidgetState extends State<TarefasExibirWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.tarefas.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('Não foi possível conectar.'),
                );
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      dynamic item = dados.docs[index].data();
                      String titulo = item['titulo'];
                      String descricao = item['descricao'];

                      return Card(
                        color: widget.cor,
                        child: ListTile(
                          title: Text(
                            titulo,
                            style: GoogleFonts.roboto(fontSize: 22),
                          ),
                          subtitle: Text(
                            descricao,
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          trailing: Visibility(
                            visible: widget.status != '3' ? true : false,
                            child: IconButton(
                              icon: Icon(widget.icone),
                              onPressed: () {
                                TarefasController().atualizar(
                                  dados.docs[index].id,
                                  widget.status,
                                );

                                sucesso(
                                  context,
                                  'Status atualizado com sucesso.',
                                );
                              },
                            ),
                          ),
                          onLongPress: () {
                            TarefasController().remover(dados.docs[index].id);
                            sucesso(context, 'Item removido com sucesso.');
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhuma tarefa encontrada.'),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
