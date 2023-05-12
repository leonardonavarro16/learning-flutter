import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({Key? key}) : super(key: key);

  @override
  _DatePickerInputState createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerField> {
  TextEditingController _date = TextEditingController();
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.quicksand(),
      controller: _date,
      decoration: InputDecoration(
        labelText: 'Select Date',
        icon: const Icon(CupertinoIcons.calendar),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
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
                      )),
              child: child!),
        );
        if (pickedDate != null) {
          setState(() {
            _date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          });
        }
      },
    );
  }
}
