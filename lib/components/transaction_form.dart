import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titlecontroller = TextEditingController();
  final valuecontroller = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = titlecontroller.text;
    final value = double.tryParse(valuecontroller.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    ).then(
      (pickeDate) {
        if (pickeDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickeDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: titlecontroller,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  label: Text('Título'),
                ),
              ),
              TextField(
                controller: valuecontroller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  label: Text('Valor (R\$)'),
                ),
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? '(Nehuma Data Selecionada)'
                            : 'Data Selecionada: ${intl.DateFormat('dd/MM/y').format(_selectedDate!)}',
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.all(12),
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar Data',
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(12),
                onPressed: () {
                  _submitForm();
                },
                child: const Text(
                  'Adicionar Transação',
                  style: TextStyle(color: Colors.lightGreen),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
