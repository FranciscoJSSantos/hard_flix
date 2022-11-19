import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hard_flix/models/movies.dart';
import 'package:hard_flix/routes/app_routes.dart';
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
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
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
                        onPressed: () {},
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

    // return FirebaseFirestore.instance.collection('movies').snapshots().map(
    //     (snapshot) =>
    //         snapshot.docs.map((doc) => Movies.fromJson(doc.data())).toList());
  }
}
