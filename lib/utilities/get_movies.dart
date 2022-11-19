import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference moviesListagem =
        FirebaseFirestore.instance.collection('movies');
    return FutureBuilder<DocumentSnapshot>(
        future: moviesListagem.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(data['name']);
          }
          return const Text('loading...');
        }));
  }
}
