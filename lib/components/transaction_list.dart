import 'package:flutter/material.dart';
import '../transaction.dart';
import 'package:intl/intl.dart' as intl;

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: 280,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final tr = transactions[index];
            return Card(
              child: Row(
                children: [
                  // Container que vai conter os valores dos produtos
                  //
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    //MARGIN: const EdgeInsets.Alguma_coisa.
                    //Função para definir as margens e bordas do container
                    //Na horizontal e vertical.
                    //
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                    //DECORATION: BoxDecoration(). Função para decorar
                    //E estilizar a box.
                    //border: Border.all.
                    //Define: cor, grossura, estilo e alinhamento da borda.
                    //
                    padding: const EdgeInsets.all(10),
                    //padding: EdgeInsets.all(value).
                    //Espaçamento do container em relação a outros widgets.
                    //
                    child: Text(
                      'R\$: ${tr.value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          'Produto: \t ${tr.title}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.deepPurple,
                            wordSpacing: 2,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          textDirection: TextDirection.ltr,
                          intl.DateFormat('d MMM y').format(tr.date),
                          //tr.date.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey,
                            wordSpacing: 2,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
