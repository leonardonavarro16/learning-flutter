import 'package:flutter/material.dart';

class FavIconContainer extends StatelessWidget {
  final bool selected;
  final double? height;
  final double? width;
  final void Function()? onTap;

  const FavIconContainer(
      {Key? key, this.height, this.width, this.onTap, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 35,
      width: width ?? 35,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Icon(
            shadows: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 2),
                blurRadius: 5.0,
              ),
            ],
            color: selected ? Colors.red : Colors.grey,
            size: selected ? 25 : 20.5,
            selected ? Icons.favorite : Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}



  // }

  // showDialog(
  //   context: context,
  //   builder: (context) {
  //     Future.delayed(const Duration(milliseconds: 1200), () {
  //       Navigator.of(context).pop();
  //     });

  //     return StatefulBuilder(
  //       builder: (context, setState) {
  //         return AlertDialog(
  //           backgroundColor: Colors.black.withOpacity(0.8),
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(30)),
  //           ),
  //           title: const Text(
  //             'Anuncio marcado!',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xFFFF0000),
  //             ),
  //           ),
  //           content: const Text(
  //             'Se ha guardado en mis anuncios favoritos',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           // actions: [
  //           //   CustomButton(
  //           //     borderRadius: 15,
  //           //     text: 'Cerrar',
  //           //     onPressed: () {
  //           //       Navigator.of(context).pop();
  //           //     },
  //           //   ),
  //           // ],
  //         );
  //       },
  //     );
  //   },
  // );

