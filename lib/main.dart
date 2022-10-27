// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_despesas_pessoais/components/charts.dart';
import 'package:flutter_despesas_pessoais/components/transaction_form.dart';
import '../transaction.dart';
import 'dart:math';
import 'dart:io';
import 'components/transaction_list.dart';

main() => runApp(const DespesasPessoais());

class DespesasPessoais extends StatelessWidget {
  const DespesasPessoais({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'Controle de Despesas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: Colors.lightGreen),
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                //Procurar em fonts.google
                fontFamily: 'QuickSand',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    //Transaction()
  ];

  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (tr) {
        return tr.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(
      () {
        _transactions.add(newTransaction);
      },
    );

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(
      () {
        _transactions.removeWhere((tr) => tr.id == id);
      },
    );
  }

  openTransactionFormmodal(BuildContext) {
    showModalBottomSheet(
      context: BuildContext,
      builder: (ctx) {
        return TransactionForm(addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //Criação de varíavel de MediaQuery.of para otimizar o codigo e diminuiur.
    final appBar = AppBar(
      actions: [
        IconButton(
          onPressed: () => openTransactionFormmodal(context),
          icon: const Icon(Icons.add),
        ),
      ],
      title: Text(
        'Controle Suas Despesas!',
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'Quicksand',
          fontSize: 26 * mediaQuery.textScaleFactor,
        ),
      ),
    );

    final alturaDisponivel =
        mediaQuery.size.height - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Exibir Gráfico'),
                  Switch.adaptive(
                    activeColor: Colors.deepPurple,
                    value: _showChart,
                    onChanged: ((value) {
                      setState(
                        () {
                          _showChart = value;
                        },
                      );
                    }),
                  ),
                ],
              ),
              if (_showChart)
                SizedBox(
                  height: alturaDisponivel * 0.45,
                  child: Chart(recentTransaction: _recentTransactions),
                ),
              //if (!_showChart || !isLandscape)
              SizedBox(
                height: alturaDisponivel * 0.55,
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: /* Platform.isIOS
          ? CupertinoButton(
              child: Icon(Icons.add),
              onPressed: () => openTransactionFormmodal(context),
            )
          : */
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => openTransactionFormmodal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
