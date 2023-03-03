import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgePageTwo extends StatefulWidget {
  const AgePageTwo({super.key});

  @override
  _AgePageTwo createState() => _AgePageTwo();
}

class _AgePageTwo extends State<AgePageTwo> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Selecciona tu fecha de cumpleaños',
      cancelText: 'Cancelar',
      confirmText: 'Seleccionar',
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: const InputDecoration(
                    focusColor: Colors.white,
                    labelText: 'Date of Birth',
                    hintText: 'YYYY-MM-DD',
                  ),
                  controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(_selectedDate),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
