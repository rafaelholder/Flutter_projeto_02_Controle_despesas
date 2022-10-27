import 'package:flutter/material.dart';
import 'package:flutter_despesas_pessoais/components/transaction_item.dart';
import '../transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;
  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: constraints.maxHeight * 0.1,
                child: Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return TransactionItem(
            tr: tr,
            onRemove: onRemove,
          );
        },
      );
    }
  }
}
