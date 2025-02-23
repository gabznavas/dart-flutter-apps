import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  void Function(String title, double value, DateTime date) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate;

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  void _showDatePicket() async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(2019);
    final lastDate = DateTime.now();
    final dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (dateTime == null) {
      return;
    }
    setState(() {
      _selectedDate = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String dateBrazilFormat = 'd/M/y';

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            SizedBox(
              height: 75,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada.'
                          : 'Data selecionada: ${DateFormat(dateBrazilFormat).format(_selectedDate!)}',
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: _showDatePicket,
                    child: Text(
                      _selectedDate == null
                          ? 'Selecionar data'
                          : 'Alterar data',
                    ),
                  ),
                  SizedBox(width: 1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: _submitForm,
                  child: Text('Nova Transação'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
