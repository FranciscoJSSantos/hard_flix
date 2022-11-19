import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hard_flix/models/movies.dart';
import 'package:hard_flix/views/user_form.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';
import 'login.dart';

class MoviesList extends StatelessWidget {
  final docUser = FirebaseFirestore.instance.collection("movies").doc('my-id');

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop();
    }

    final controllerName = TextEditingController();
    final controllerFaixaEtaria = TextEditingController();
    final controllerAno = TextEditingController();
    final controllerGenero = TextEditingController();
    final controllerDuracao = TextEditingController();
    final controllerIdioma = TextEditingController();
    final controllerAvaliacao = TextEditingController();

    final form = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();

            Get.to(() => LoginScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 350));
          },
        ),
        title: const Text("Lista de Filmes"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.to(() => UserForm(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 350));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("movies").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                DocumentReference<Map<String, dynamic>>;
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.play_circle),
                  ),
                  title: Text(document['name']),
                  subtitle: Text(document['genero']),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              content: SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Text("Nome: ${document['name']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Faixa etária: ${document['genero']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Ano lançamento: ${document['anoLancamento']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Gênero: ${document['genero']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Duração: ${document['duracao']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Idioma: ${document['idioma']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "Avaliação: ${document['avaliacao']}"),
                                      const SizedBox(height: 50),
                                      ElevatedButton(
                                          child: const Text('Voltar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  )),
                            ));
                  },
                  trailing: SizedBox(
                    width: 100,
                    child: Row(children: <Widget>[
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                      insetPadding: const EdgeInsets.all(10),
                                      content: Form(
                                        child: Column(children: <Widget>[
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerName,
                                            decoration: const InputDecoration(
                                              hintText: "Nome",
                                            ),
                                          ),
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerFaixaEtaria,
                                            decoration: const InputDecoration(
                                              hintText: "Faixa Etaria",
                                            ),
                                          ),
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerAno,
                                            decoration: const InputDecoration(
                                              hintText: "Ano",
                                            ),
                                          ),
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerGenero,
                                            decoration: const InputDecoration(
                                              hintText: "Gênero",
                                            ),
                                          ),
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerDuracao,
                                            decoration: const InputDecoration(
                                              hintText: "Duração",
                                            ),
                                          ),
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerIdioma,
                                            decoration: const InputDecoration(
                                              hintText: "Idioma",
                                            ),
                                          ),
                                          TextFormField(
                                            showCursor: true,
                                            autofocus: true,
                                            controller: controllerAvaliacao,
                                            decoration: const InputDecoration(
                                              hintText: "Avaliação",
                                            ),
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Background color
                                                  ),
                                                  child: const Text(
                                                    'Voltar',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .blue, // Background color
                                                  ),
                                                  child: const Text('Alterar',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white))),
                                            ],
                                          ),
                                        )
                                      ]));
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.orange,
                      ),
                      IconButton(
                        onPressed: () {
                          final docUser = FirebaseFirestore.instance
                              .collection("movies")
                              .doc(document['id']);

                          docUser.delete();
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ]),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }

  Stream<List<Movies>> readMovies() {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("movies").doc();

    return docRef.snapshots().map((dados) => dados.data() as List<Movies>);
  }

  Future updateMovie(Movies movie, String id) async {
    var collection = FirebaseFirestore.instance.collection('movies');
    collection
        .doc(id) // <-- Doc ID where data should be updated.
        .update({'key': 'value'}) // <-- Updated data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  List<String> docIds = [];
  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('movies')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
  }
}
