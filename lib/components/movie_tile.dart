import 'package:flutter/material.dart';

import '../models/movies.dart';
import '../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final Movies movie;

  const UserTile(this.movie);

  @override
  Widget build(BuildContext context) {
    const avatar = CircleAvatar(
      backgroundColor: Colors.redAccent,
      child: Icon(Icons.play_circle_fill),
    );

    return ListTile(
      leading: avatar,
      title: Text(movie.name),
      subtitle: Text("Faixa Etária: ${movie.classificacaoEtaria}"),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: movie,
                  );
                },
                icon: const Icon(Icons.edit),
                color: Colors.orange),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                color: Colors.red)
          ],
        ),
      ),
    );
  }
}
