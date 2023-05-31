import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: dejar una sola variable entre en pickedDate, el selectedDate y lastSelectedDate
//TODO: dejar una sola variable entre el initialValue y el fieldValue

class DatePickerField extends StatefulWidget {
  final Function onChange;
  final DateTime? initialValue;

  const DatePickerField({
    Key? key,
    required this.onChange,
    this.initialValue,
  }) : super(key: key);

  @override
  State<DatePickerField> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerField> {
  final TextEditingController _date = TextEditingController();
  DateTime currentDate = DateTime.now();
  late DateTime dateCenturyAgo;
  DateTime? pickedDate;
  bool hasError = false;
  DateTime? lastSelectedDate;
  DateTime? selectedDate;
  String? formattedInitialValue;

  @override
  void initState() {
    super.initState();
    _date.text = widget.initialValue == null
        ? ''
        : DateFormat('dd-MM-yyyy').format(widget.initialValue!);
    dateCenturyAgo = currentDate.subtract(
      const Duration(days: 365 * 100),
    );
    selectedDate = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return TextFormField(
      initialValue: formattedInitialValue,
      readOnly: true,
      // style: GoogleFonts.quicksand(),
      style: const TextStyle(fontFamily: 'SanFrancisco'),
      controller: _date,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.calendar,
          color: Colors.grey,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
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
        labelText: selectedDate == null
            ? t.birthdateLabelLinkText
            : DateFormat('dd-MM-yyyy').format(selectedDate!),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.enterBirthdateLinkText;
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
          return t.mustBeOlderErrorLinkText;
        }

        hasError = false;
        return null;
      },
      onTap: () async {
        pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? currentDate,
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
              textTheme: const TextTheme(
                displayLarge:
                    TextStyle(fontFamily: 'SanFrancisco'), // no aplica
                displayMedium:
                    TextStyle(fontFamily: 'SanFrancisco'), // no aplica
                displaySmall:
                    TextStyle(fontFamily: 'SanFrancisco'), // no aplica
                headlineMedium: TextStyle(
                    fontFamily:
                        'SanFrancisco'), // controla: fecha en cabecera, día - mes. mod. 1 y mod. 2
                headlineSmall:
                    TextStyle(fontFamily: 'SanFrancisco'), // no aplica
                titleMedium: TextStyle(
                  fontFamily: 'SanFrancisco',
                  color: Colors.white,
                  fontSize: 18,
                ), // controla: título y fecha seleccionada en mod. 2
                titleSmall: TextStyle(
                    fontFamily:
                        'SanFrancisco'), // Controla: seleccionador de mes y años en mod. 1
                bodyLarge: TextStyle(fontFamily: 'SanFrancisco'), // no aplica
                bodyMedium: TextStyle(fontFamily: 'SanFrancisco'), // no aplica
                bodySmall: TextStyle(
                  fontFamily: 'SanFrancisco',
                  fontSize: 14,
                ), // controla: numeros de fecha del calendario mod. 1
                labelLarge: TextStyle(
                  fontFamily: 'SanFrancisco',
                  fontWeight: FontWeight.bold,
                ), // controla: botones de aceptar y cancelar mod. 1 y mod. 2
                labelSmall: TextStyle(
                  fontFamily: 'SanFrancisco',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ), // controla: seleccionar fecha mod. 1 y mod. 2
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
          selectedDate = pickedDate;
          setState(() {
            _date.text = DateFormat('dd-MM-yyyy').format(pickedDate!);
            int age = getAge();
            widget.onChange(age, pickedDate!);
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
