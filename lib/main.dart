import 'package:flutter/material.dart';
import 'package:flutter_despesas_pessoais/components/transaction_form.dart';
import '../transaction.dart';
import 'dart:math';

import 'components/transaction_list.dart';

main() => runApp(const DespesasPessoais());

class DespesasPessoais extends StatelessWidget {
  const DespesasPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
        title: 'Despesas Pessoais',
        themeMode: ThemeMode.dark,
        color: Color.fromARGB(255, 10, 228, 46),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Tênis',
      value: 320.10,
      date: DateTime.now(),
    ),
  ];
  addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(
      () {
        _transactions.add(newTransaction);
      },
    );

    Navigator.of(context).pop();
  }

  openTransactionFormmodal(BuildContext) {
    showModalBottomSheet(
        context: BuildContext,
        builder: (ctx) {
          return TransactionForm(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => openTransactionFormmodal(context),
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text(
          'Home page',
          textDirection: TextDirection.rtl,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('coluna(colunm)'),
            Container(
              margin: const EdgeInsets.all(12),
              child: const Card(
                color: Colors.green,
                elevation: 8,
                child: Text('Lugar do grafico'),
              ),
            ),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => openTransactionFormmodal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
