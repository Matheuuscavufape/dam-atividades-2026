abstract class Livro {
  final int codigo;
  String _titulo;
  final String? autor;

  Livro(this.codigo, String titulo, [this.autor]) : _titulo = titulo.trim();

  String get titulo => _titulo;

  set titulo(String novoTitulo) {
    if (novoTitulo.trim().isNotEmpty) {
      _titulo = novoTitulo.trim();
    }
  }

  String get nomeAutor => autor ?? 'Autor desconhecido';

  String descricao();
}

extension ReferenciaLivro on Livro {
  String referencia() => '$titulo - $nomeAutor';
}

abstract class Emprestavel {
  bool get disponivel;
  bool emprestar();
  void devolver();
}

class LivroFisico extends Livro implements Emprestavel {
  final int numeroPaginas;
  bool _disponivel = true;

  LivroFisico(int codigo, String titulo, this.numeroPaginas, [String? autor])
      : super(codigo, titulo, autor);

  @override
  bool get disponivel => _disponivel;

  @override
  bool emprestar() {
    if (!_disponivel) {
      return false;
    }
    _disponivel = false;
    return true;
  }

  @override
  void devolver() {
    _disponivel = true;
  }

  @override
  String descricao() {
    return 'Livro físico | Código: $codigo | '
        'Título: $titulo | Autor: $nomeAutor | '
        'Páginas: $numeroPaginas';
  }
}

class LivroDigital extends Livro {
  final double tamanhoMB;

  LivroDigital(int codigo, String titulo, this.tamanhoMB, [String? autor])
      : super(codigo, titulo, autor);

  @override
  String descricao() {
    return 'Livro digital | Código: $codigo | '
        'Título: $titulo | Autor: $nomeAutor | '
        'Tamanho: $tamanhoMB MB';
  }
}

void main() {
  final livroFisico = LivroFisico(1, 'Dom Casmurro', 256, 'Machado de Assis');
  final livroDigital = LivroDigital(2, 'O Pequeno Príncipe', 3.5, 'Antoine de Saint-Exupéry');
  final livroSemAutor = LivroFisico(3, 'Histórias Populares', 120);

  final List<Livro> catalogo = [livroFisico, livroDigital, livroSemAutor];

  print('CATÁLOGO DA BIBLIOTECA\n');

  for (final livro in catalogo) {
    print(livro.descricao());
    print('Referência: ${livro.referencia()}\n');
  }

  print('ALTERAÇÃO DE TÍTULO\n');
  print('Título original: ${livroFisico.titulo}');

  livroFisico.titulo = '  Dom Casmurro - Nova Edição  ';
  print('Título atualizado: ${livroFisico.titulo}');

  livroFisico.titulo = '   ';
  print('Após entrada em branco: ${livroFisico.titulo}');

  print('\nEMPRÉSTIMOS\n');
  print('Disponibilidade inicial: ${livroFisico.disponivel}');

  print(livroFisico.emprestar() ? 'Empréstimo aceito.' : 'Empréstimo recusado.');
  print('Disponibilidade: ${livroFisico.disponivel}');

  print(livroFisico.emprestar() ? 'Empréstimo aceito.' : 'Empréstimo recusado.');

  livroFisico.devolver();
  print('Livro devolvido.');
  print('Disponibilidade após devolução: ${livroFisico.disponivel}');

  livroFisico.devolver();
  print('Disponibilidade após nova devolução: ${livroFisico.disponivel}');
}
