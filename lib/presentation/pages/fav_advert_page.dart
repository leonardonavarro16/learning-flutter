import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/logic/cubits/adverts.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/adverts.dart';
import 'package:swc_front/presentation/forms/login_form.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/fav_icon_container.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/modal_closed_content.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: BlocBuilder<AdvertsCubit, AdvertsState>(
        builder: (BuildContext context, AdvertsState state) {
          if (state.status == AdvertsStatus.indexSuccess) {
            final favoriteAdverts =
                state.adverts.where((advert) => advert.isFav).toList();

            if (favoriteAdverts.isEmpty) {
              return const Center(
                  child: TextView(
                text: 'No favorite adverts',
                color: Colors.white,
              ));
            }

            return ListView.builder(
              itemCount: favoriteAdverts.length,
              itemBuilder: (context, index) {
                final advert = favoriteAdverts[index];
                return Expanded(
                  child: InkWell(
                    // onTap: () {
                    //   BaseModal.open(context: context, children: [
                    //     _buildModalOpenedContent(context),
                    //   ]);
                    // },
                    child: _buildModalClosedFavAdvert(context, advert),
                  ),
                );
              },
            );
          } else if (state.status == AdvertsStatus.indexFailure) {
            return TextView(text: state.error, color: Colors.red);
          } else {
            return const Center(child: CustomIndicatorProgress());
          }
        },
      ),
    );
  }

  Widget _buildModalClosedFavAdvert(BuildContext context, Advert advert) {
    double width = MediaQuery.of(context).size.width;
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
                                  color: Colors.red,
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
                                                color: Colors.red,
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
