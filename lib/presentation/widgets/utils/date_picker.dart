import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final Function onChange;
  const DatePickerField({Key? key, required this.onChange}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerField> {
  final TextEditingController _date = TextEditingController();
  DateTime currentDate = DateTime.now();
  late DateTime dateCenturyAgo;

  @override
  void initState() {
    super.initState();
    dateCenturyAgo = currentDate.subtract(
      const Duration(days: 365 * 100),
    );
  }

  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.quicksand(),
      controller: _date,
      decoration: InputDecoration(
        labelText: 'Select your birth date',
        icon: const Icon(CupertinoIcons.calendar),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: dateCenturyAgo,
          lastDate: currentDate,
          builder: (context, child) => Theme(
            data: ThemeData(
              dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ).copyWith(
              dialogBackgroundColor: const Color.fromARGB(255, 25, 25, 25),
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: const Color(0xFFFF0000),
                    surface: const Color(0xFFFF0000),
                    onPrimary: Colors.white,
                    onSurface: Colors.white,
                  ),
            ),
            child: child!,
          ),
        );
        if (pickedDate != null) {
          setState(() {
            _date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
            widget.onChange(getAge());
          });
        }
      },
    );
  }

  int getAge() {
    if (_date.text.isNotEmpty) {
      final birthday = DateFormat('dd-MM-yyyy').parse(_date.text);
      int age = currentDate.year - birthday.year;
      if (currentDate.month < birthday.month ||
          (currentDate.month == birthday.month &&
              currentDate.day < birthday.day)) {
        age--;
      }
      return age;
    } else {
      return 0;
    }
  }
}
