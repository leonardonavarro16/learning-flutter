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
  bool hasError = false;
  DateTime? lastSelectedDate;

  @override
  void initState() {
    super.initState();
    dateCenturyAgo = currentDate.subtract(
      const Duration(days: 365 * 100),
    );
  }

  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      style: GoogleFonts.quicksand(),
      controller: _date,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFFF0000),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFFF0000),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFFF0000),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFFF0000),
          ),
        ),
        labelText: 'Fecha de nacimiento',
        // icon: const Icon(CupertinoIcons.calendar),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese su fecha de nacimiento';
        }

        final birthday = DateFormat('dd-MM-yyyy').parse(value);
        int age = currentDate.year - birthday.year;
        if (currentDate.month < birthday.month ||
            (currentDate.month == birthday.month &&
                currentDate.day < birthday.day)) {
          age--;
        }

        if (age <= 18) {
          hasError = true;
          return 'Debes ser mayor a 18 años para registrarte';
        }

        hasError = false;
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: lastSelectedDate ?? currentDate,
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
              textTheme: TextTheme(
                displayLarge: GoogleFonts.quicksand(),
                displayMedium: GoogleFonts.quicksand(),
                displaySmall: GoogleFonts.quicksand(),
                headlineMedium: GoogleFonts.quicksand(),
                headlineSmall: GoogleFonts.quicksand(),
                titleMedium: GoogleFonts.quicksand(),
                titleSmall: GoogleFonts.quicksand(),
                bodyLarge: GoogleFonts.quicksand(),
                bodyMedium: GoogleFonts.quicksand(),
                bodySmall: GoogleFonts.quicksand(),
                labelLarge: GoogleFonts.quicksand(),
                labelSmall: GoogleFonts.quicksand(),
              ),
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
          lastSelectedDate = pickedDate;
          setState(() {
            _date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
            widget.onChange(getAge());
          });
        }
      },
      onChanged: (value) {
        if (hasError) {
          setState(() {
            hasError = false;
          });
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) {
        setState(() {
          hasError = true;
        });
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
