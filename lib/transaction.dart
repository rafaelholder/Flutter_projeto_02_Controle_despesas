class Transaction {
  // Classe\Struct que para declarações das varíaveis
  // Que serão usadas no app.
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    //Construtor da classe.
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });
}
