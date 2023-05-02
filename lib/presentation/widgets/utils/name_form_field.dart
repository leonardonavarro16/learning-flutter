import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';

class NameFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const NameFormField({
    super.key,
    required this.onChange,
    this.initialValue,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
        fieldValue: initialValue,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Nombre:',
        ),
        onChange: onChange,
        onFieldSubmitted: onFieldSubmitted,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su nombre completo';
          }
          final nameRegExp = RegExp(
              r"^\s*([A-Za-z][A-Za-zñÑ]*(?:\s+[A-Za-z][A-Za-zñÑ]*)*\.?\s*)$");
          if (!nameRegExp.hasMatch(value)) {
            return 'Ingrese un nombre válido';
          }
          return null;
        });
  }
}


// 1. convertir a stateful el widget
// 2. crear un controlador en el estado
// 3. pasar controlador al TextFormField
// 4. crear metodo _getErrorText
// 5. pasarle el metodo _getErrorText al atributo "validator" del TextFormField
// 6. pasar el resultado de _getErrorText al atributo "errorText" del decoration del TextFormField
// 7. validar que no se le pase nada al atributo "onChange" del TextFormField
// 8. crear el metodo "initState" en el estado
// 9. en el metodo "initState" llamar al metodo _controller.addListener(_onChange);
// 10. crear el metodo _onChange
// 11. usar widget.onChange en _onChange y pasarle el atributo _controller.text
// 12. llamar al setState en el metodo _onChange
// 13. sobresecribir el metodo "dispose" en el estado
// 14. llamar el metodo _controller.dispose(); en el metodo dispose del estado
// 15. crear atributo _touched e inicialisarlo como false
// 16. setear el atributo _touched como true en el metodo _onChange
// 17. en el metodo _getErrorText agregar al inicio if (!_touched) return null;
// 18. crear metodo bool _isValid() => null == _getErrorText(_controller.text);
// 19. pasarle al widget.onChange lo que retorne _isValid() asi: widget.onChange(value, _isValid());


// ---

// pasar a un archivo propio el BaseTextFormField
// usarlo en todo los form_fields que sean de texto
// ver si es necesario pasarle nuevos atributos al BaseTextFormField y pasarselos