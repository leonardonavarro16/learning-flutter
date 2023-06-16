import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/logic/cubits/adverts.dart';
import 'package:swc_front/presentation/forms/login_form.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/modal_opened_content.dart';
import 'package:swc_front/presentation/widgets/utils/fav_icon_container.dart';
import 'package:swc_front/presentation/widgets/utils/modal_closed_content.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../../logic/cubits/authentication_cubit.dart';
import 'utils/base_modal.dart';
import 'package:swc_front/presentation/widgets/utils/image_swiper.dart';

class AdverList extends StatelessWidget {
  int colsPerRow = 0;
  double colsWidth = 0;
  int rowsCount = 0;

  BoxConstraints constraints = const BoxConstraints();
  final double spaceBetweenCols;
  final List<Advert> adverts;
  final int itemsPerPage;
  int currentPage = 0;
  AdverList({
    super.key,
    required this.adverts,
    this.spaceBetweenCols = 10,
    this.itemsPerPage = 10,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        setConstraints(constraints);
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: constraints.maxWidth,
              child: Table(
                children: generateTableRows(constraints),
              ),
            ),
          ],
        );
      },
    );
  }

  List<TableRow> generateTableRows(BoxConstraints constraints) {
    List<TableRow> tableRows = [];
    colsPerRow = calculateColsPerRow();
    colsWidth = calculateColsWidth();
    rowsCount = calculateRowsCount();

    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    endIndex = endIndex > adverts.length ? adverts.length : endIndex;
    // La expresión startIndex ~/ colsPerRow calcula el índice de fila truncado en la generación de filas de la tabla.
    // El operador ~/ realiza una división entera y trunca el resultado eliminando los decimales.
    // La división entera truncada elimina los decimales sin redondear el cociente.

    for (int rowIndex = startIndex ~/ colsPerRow;
        rowIndex < (endIndex - 1) ~/ colsPerRow + 1;
        rowIndex++) {
      List<Widget> advertPreviews = generateTableRow(rowIndex);
      while (advertPreviews.length < colsPerRow) {
        advertPreviews.add(Container());
      }

      tableRows.add(TableRow(
        children: advertPreviews,
      ));
    }
    return tableRows;
  }

  List<Widget> generateTableRow(int rowIndex) {
    bool lastRow = rowsCount - 1 == rowIndex;
    int endIndex = lastRow ? adverts.length : colsPerRow * (rowIndex + 1);
    List<Advert> rowAdverts =
        adverts.getRange(rowIndex * colsPerRow, endIndex).toList();
    return List<Widget>.of(rowAdverts.map((Advert advert) {
      return _AdvertPreview(width: colsWidth, advert: advert);
    }));
  }

  int calculateColsPerRow() {
    if (constraints.maxWidth <= 300) {
      return 1;
    } else if (constraints.maxWidth <= 600) {
      return 2;
    } else if (constraints.maxWidth <= 800) {
      return 3;
    } else if (constraints.maxWidth <= 1000) {
      return 4;
    } else if (constraints.maxWidth <= 1200) {
      return 5;
    } else {
      return 6;
    }
  }

  int calculateRowsCount() {
    if (colsPerRow == 0) return 0;
    return (adverts.length / colsPerRow).ceil();
  }

  double calculateColsWidth() {
    if (colsPerRow == 0) return 0;
    return (constraints.maxWidth - (2 * colsPerRow * spaceBetweenCols)) /
        colsPerRow;
  }

  void setConstraints(BoxConstraints cons) {
    constraints = cons;
  }
}

class _AdvertPreview extends StatelessWidget {
  final double width;
  final Advert advert;

  const _AdvertPreview({required this.width, required this.advert});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BaseModal.open(context: context, children: [
          _buildModalOpenedContent(context),
        ]);
      },
      child: _buildModalClosedContent(context),
    );
  }

  Widget _buildModalOpenedContent(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            if (advert.images.length == 1)
              SizedBox(
                height: screenHeight,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image.memory(advert.images.first, fit: BoxFit.cover),
                  ],
                ),
              ),
            if (advert.images.length > 1)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ImageSlider(
                    images: advert.images,
                  ),
                ),
              ),
          ],
        ),
        Positioned(
          top: 16,
          left: 16,
          child: FavIconContainer(
            selected: advert.isFav,
            onTap: () {
              String? token = context.read<AuthenticationCubit>().state.token;
              if (token == null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(const Duration(minutes: 1), () {
                      Navigator.of(context).pop();
                    });
                    return CustomAlertDialog(
                      hasButton: false,
                      header: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                CupertinoIcons.xmark_square_fill,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 2),
                                      blurRadius: 5.0)
                                ],
                                size: 32.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const TextView(
                            fontSize: 14,
                            text: 'Accede para marcar como favorito!',
                            color: Color(0xFFFF0000),
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            // height: 140,
                            width: 140,
                            child: SvgPicture.asset(
                              'assets/Logo blanco.svg',
                            ),
                          ),
                        ],
                      ),
                      content: Container(
                        height: 240,
                        width: 400,
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                const LoginForm(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextView(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        text: '¿No tienes una cuenta?'),
                                    // SizedBox(height: 15),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pushReplacementNamed(
                                                context,
                                                Routes.registrationPage),
                                        child: const TextView(
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF0000),
                                          text: 'Registrate',
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
                return;
              }
              context.read<AdvertsCubit>().toggleAdvertFav(advert, token);
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ModalOpenedContainerContent(
            advert: advert,
          ),
        ),
      ],
    );
  }

  Widget _buildModalClosedContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Center(
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: advert.images.isEmpty
                    ? Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZNQZI9chyqtlvn6KNfid_ACsf4O-NiKn9Cw&usqp=CAU')
                    : Image.memory(advert.images.first),
              ),
              Positioned(
                top: 5,
                right: 5,
                // padding: const EdgeInsets.only(right: 3, top: 3),
                child: FavIconContainer(
                  selected: advert.isFav,
                  onTap: () {
                    String? token =
                        context.read<AuthenticationCubit>().state.token;
                    if (token == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(const Duration(minutes: 1), () {
                            Navigator.of(context).pop();
                          });
                          return CustomAlertDialog(
                            hasButton: false,
                            header: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      CupertinoIcons.xmark_square_fill,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 2),
                                            blurRadius: 5.0)
                                      ],
                                      size: 32.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const TextView(
                                  fontSize: 14,
                                  text: 'Accede para marcar como favorito!',
                                  color: Color(0xFFFF0000),
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  // height: 140,
                                  width: 140,
                                  child: SvgPicture.asset(
                                    'assets/Logo blanco.svg',
                                  ),
                                ),
                              ],
                            ),
                            content: Container(
                              height: 240,
                              width: 400,
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      const LoginForm(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const TextView(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              text: '¿No tienes una cuenta?'),
                                          // SizedBox(height: 15),
                                          TextButton(
                                              onPressed: () => Navigator
                                                  .pushReplacementNamed(context,
                                                      Routes.registrationPage),
                                              child: const TextView(
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFF0000),
                                                text: 'Registrate',
                                              )),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      return;
                    }
                    context.read<AdvertsCubit>().toggleAdvertFav(advert, token);
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ModalClosedContainerContent(
                  advert: advert,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
