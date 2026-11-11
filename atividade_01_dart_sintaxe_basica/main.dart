
enum Classificacao {
  semAvaliacoes,
  baixa,
  regular,
  alta,
}

void main() {
  const notaMinima = 1;
  const notaMaxima = 5;
  const notaPositiva = 4;

  final notasRecebidas = <String, List<String>>{
    'Agenda UFAPE': ['5', '4', '5', '0', '3', '6'],
    'Biblioteca Digital': ['3', '2', '4', '1'],
    'Mapa do Campus': [],
    'Restaurante Universitário': ['5', '5', '4', '4', '5'],
    'Transporte Universitário': ['0', '6', '-1'],
  };

  final categoriasPorApp = <String, String>{
    'Agenda UFAPE': 'Organização',
    'Biblioteca Digital': 'Serviços',
    'Mapa do Campus': 'Localização',
    'Restaurante Universitário': 'Serviços',
    'Transporte Universitário': 'Serviços',
  };

  final contatosPorApp = <String, String?>{
    'Agenda UFAPE': 'agenda@exemplo.com',
    'Biblioteca Digital': null,
    'Mapa do Campus': 'mapa@exemplo.com',
    'Restaurante Universitário': 'ru@exemplo.com',
  };

  final notasValidasPorApp = <String, List<int>>{};
  final descartadasPorApp = <String, int>{};
  final categoriasUnicas = <String>{};

  // QUESTÃO 1 — PREPARAÇÃO DOS DADOS

  for (final app in notasRecebidas.keys) {
    final notasValidas = <int>[];
    int descartadas = 0;

    for (final notaTexto in notasRecebidas[app]!) {
      final nota = int.parse(notaTexto);

      if (nota >= notaMinima && nota <= notaMaxima) {
        notasValidas.add(nota);
      } else {
        descartadas++;
      }
    }

    notasValidasPorApp[app] = notasValidas;
    descartadasPorApp[app] = descartadas;

    final categoria = categoriasPorApp[app];
    if (categoria != null) {
      categoriasUnicas.add(categoria);
    }
  }

  // QUESTÃO 2 — RELATÓRIO

  print('RELATÓRIO DE AVALIAÇÕES');
  print('======================');

  for (final app in notasRecebidas.keys) {
    final categoria = categoriasPorApp[app] ?? 'Não informado';
    final contato = contatosPorApp[app] ?? 'Não informado';

    final notas = notasValidasPorApp[app]!;
    final quantidadeValidas = notas.length;
    final quantidadeDescartadas = descartadasPorApp[app]!;

    String mediaTexto = 'Não calculado';
    String percentualTexto = 'Não calculado';

    Classificacao classificacao;

    if (quantidadeValidas == 0) {
      classificacao = Classificacao.semAvaliacoes;
    } else {
      final soma = notas.reduce((a, b) => a + b);
      final media = soma / quantidadeValidas;

      final positivas =
          notas.where((nota) => nota >= notaPositiva).length;

      final percentual = (positivas / quantidadeValidas) * 100;

      mediaTexto = media.toStringAsFixed(2);
      percentualTexto = '${percentual.toStringAsFixed(2)}%';

      if (media < 3) {
        classificacao = Classificacao.baixa;
      } else if (media < 4) {
        classificacao = Classificacao.regular;
      } else {
        classificacao = Classificacao.alta;
      }
    }

    String classificacaoTexto;

    switch (classificacao) {
      case Classificacao.semAvaliacoes:
        classificacaoTexto = 'Sem avaliações';
        break;
      case Classificacao.baixa:
        classificacaoTexto = 'Baixa';
        break;
      case Classificacao.regular:
        classificacaoTexto = 'Regular';
        break;
      case Classificacao.alta:
        classificacaoTexto = 'Alta';
        break;
    }

    print('\nAplicativo: $app');
    print('Categoria: $categoria');
    print('Contato: $contato');
    print('Notas válidas: $quantidadeValidas');
    print('Notas descartadas: $quantidadeDescartadas');
    print('Média: $mediaTexto');
    print('Notas positivas: $percentualTexto');
    print('Classificação: $classificacaoTexto');
    print('----------------------');
  }

  print('\nCATEGORIAS ENCONTRADAS');

  for (final categoria in categoriasUnicas) {
    print('- $categoria');
  }
}
