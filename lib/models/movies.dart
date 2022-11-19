class Movies {
  String id;
  final String name;
  final String classificacaoEtaria;
  final String anoLancamento;
  final String genero;
  final String duracao;
  final String idioma;
  final String avaliacao;

  Movies(
      {this.id = '',
      required this.name,
      required this.classificacaoEtaria,
      required this.anoLancamento,
      required this.genero,
      required this.duracao,
      required this.idioma,
      required this.avaliacao});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'classificacaoEtaria': classificacaoEtaria,
        'anoLancamento': anoLancamento,
        'genero': genero,
        'duracao': duracao,
        'idioma': idioma,
        'avaliacao': avaliacao
      };

  static Movies fromJson(Map<String, dynamic> json) => Movies(
      id: json['id'],
      name: json['name'],
      classificacaoEtaria: json['classificacaoEtaria'],
      anoLancamento: json['anoLancamento'],
      genero: json['genero'],
      duracao: json['duracao'],
      idioma: json['idioma'],
      avaliacao: json['avaliacao']);
}
