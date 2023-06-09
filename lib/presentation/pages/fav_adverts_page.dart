import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/logic/cubits/adverts.dart';
import 'package:swc_front/logic/states/adverts.dart';
import 'package:swc_front/presentation/widgets/advert_list.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class FavAdvertsPage extends StatelessWidget {
  const FavAdvertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: BlocBuilder<AdvertsCubit, AdvertsState>(
        builder: (BuildContext context, AdvertsState state) {
          if (state.status == AdvertsStatus.indexSuccess) {
            if (state.adverts.isEmpty) {
              return const Center(
                child: TextView(
                  text: 'No favorite adverts',
                  color: Colors.white,
                ),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(top: 3, right: 15),
                  child: SvgPicture.asset(
                    'assets/Logo rojo.svg',
                    height: 55,
                  ),
                ),
                const SizedBox(height: 20),
                const TextView(
                  fontSize: 20,
                  text: 'Mis anuncios favoritos',
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      AdverList(
                        adverts: state.adverts,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state.status == AdvertsStatus.indexFailure) {
            return TextView(
              text: state.error,
              color: const Color(0xFFFF0000),
            );
          } else {
            return const Center(child: CustomIndicatorProgress());
          }
        },
      ),
    );
  }
}
