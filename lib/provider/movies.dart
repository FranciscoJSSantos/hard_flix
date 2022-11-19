import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hard_flix/data/dummy_movies.dart';
import 'package:hard_flix/models/movies.dart';

class MoviesProvider with ChangeNotifier {
  final Map<String, Movies> _items = {...DUMMY_MOVIES};

  List<Movies> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Movies byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Movies movie) {
    // ignore: unnecessary_null_comparison
    if (movie == null) {
      return;
    }

    // ignore: unnecessary_null_comparison
    if (movie != null &&
        movie.id.trim().isNotEmpty &&
        _items.containsKey(movie.id)) {
      _items.update(
        movie.id,
        (value) => Movies(
            id: movie.id,
            name: movie.name,
            classificacaoEtaria: movie.classificacaoEtaria,
            anoLancamento: movie.anoLancamento,
            genero: movie.genero,
            duracao: movie.duracao,
            idioma: movie.idioma,
            avaliacao: movie.avaliacao),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => Movies(
            id: id,
            name: movie.name,
            classificacaoEtaria: movie.classificacaoEtaria,
            anoLancamento: movie.anoLancamento,
            genero: movie.genero,
            duracao: movie.duracao,
            idioma: movie.idioma,
            avaliacao: movie.avaliacao),
      );
    }

    notifyListeners();
  }

  void remove(Movies movie) {
    _items.remove(movie.id);

    notifyListeners();
  }
}
