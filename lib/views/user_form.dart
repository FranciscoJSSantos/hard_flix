import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hard_flix/models/movies.dart';

class UserForm extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerFaixaEtaria = TextEditingController();
  final controllerAno = TextEditingController();
  final controllerGenero = TextEditingController();
  final controllerDuracao = TextEditingController();
  final controllerIdioma = TextEditingController();
  final controllerAvaliacao = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Filmes"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final movie = Movies(
                    name: controllerName.text,
                    classificacaoEtaria: controllerFaixaEtaria.text,
                    anoLancamento: controllerAno.text,
                    genero: controllerGenero.text,
                    duracao: controllerDuracao.text,
                    idioma: controllerIdioma.text,
                    avaliacao: controllerAvaliacao.text);

                creteMovie(movie);

                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextFormField(
                controller: controllerFaixaEtaria,
                decoration: const InputDecoration(
                  labelText: 'Faixa Etária',
                ),
              ),
              TextFormField(
                controller: controllerAno,
                decoration: const InputDecoration(
                  labelText: 'Ano Lançamento',
                ),
              ),
              TextFormField(
                controller: controllerGenero,
                decoration: const InputDecoration(
                  labelText: 'Gênero',
                ),
              ),
              TextFormField(
                controller: controllerDuracao,
                decoration: const InputDecoration(
                  labelText: 'Duração',
                ),
              ),
              TextFormField(
                controller: controllerIdioma,
                decoration: const InputDecoration(
                  labelText: 'Idioma',
                ),
              ),
              TextFormField(
                controller: controllerAvaliacao,
                decoration: const InputDecoration(
                  labelText: 'Avaliação',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future creteMovie(Movies movie) async {
    final docUser = FirebaseFirestore.instance.collection('movies').doc();

    movie.id = docUser.id;

    final json = movie.toJson();

    await docUser.set(json);
  }
}
