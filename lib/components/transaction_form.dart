import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //TransactionForm({super.key, required this.onSubmit});
  final titlecontroller = TextEditingController();
  final valuecontroller = TextEditingController();

  _submitForm() {
    final title = titlecontroller.text;
    final value = double.tryParse(valuecontroller.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
    );
  }
}
