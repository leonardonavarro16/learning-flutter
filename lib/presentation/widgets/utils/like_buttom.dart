import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';

class HeartIconContainer extends StatefulWidget {
  double? height;
  double? width;

  HeartIconContainer({Key? key, this.height, this.width}) : super(key: key);

  @override
  _HeartIconContainerState createState() => _HeartIconContainerState();
}

class _HeartIconContainerState extends State<HeartIconContainer> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 35,
      width: widget.width ?? 35,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: toggleLike,
        child: Center(
          child: Expanded(
            child: Icon(
              shadows: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 2),
                  blurRadius: 5.0,
                ),
              ],
              isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isLiked ? Colors.red : Colors.grey,
              size: isLiked ? 25 : 20.5,
            ),
          ),
        ),
      ),
    );
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 1200), () {
              Navigator.of(context).pop();
            });

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: Colors.black.withOpacity(0.8),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  title: const Text(
                    'Anuncio marcado!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                  content: const Text(
                    'Se ha guardado en mis anuncios favoritos',
                    style: TextStyle(color: Colors.white),
                  ),
                  // actions: [
                  //   CustomButton(
                  //     borderRadius: 15,
                  //     text: 'Cerrar',
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //   ),
                  // ],
                );
              },
            );
          },
        );
      }
    });
  }
}
