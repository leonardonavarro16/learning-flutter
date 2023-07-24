import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/logic/cubits/adverts.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/adverts.dart';
import 'package:swc_front/presentation/widgets/advert_list.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/pagination_index.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class FavAdvertsPage extends StatelessWidget {
  const FavAdvertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? token = context.read<AuthenticationCubit>().state.token;
    int currentFavPageIndex =
        context.watch<AdvertsCubit>().state.currentFavPage;
    int decreasedCurrentPageIndex = currentFavPageIndex - 1;
    int increasedCurrentPageIndex = currentFavPageIndex + 1;
    int itemsPerPage = 10;
    int currentFavPage = 0;
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
                const SizedBox(height: 50),
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
                      AdvertList(
                        adverts: state.adverts,
                      ),
                      const SizedBox(height: 15),
                      if (state.adverts.length == itemsPerPage ||
                          state.adverts.length < 10)
                        PaginationIndex(
                          currentPageIndex: currentFavPageIndex,
                          increasedCurrentPageIndex: increasedCurrentPageIndex,
                          decreasedCurrentPageIndex: decreasedCurrentPageIndex,
                          onNextPage: () {
                            if (state.adverts.length >= itemsPerPage) {
                              currentFavPage++;
                              context.read<AdvertsCubit>().nextFavPage(token);
                            }
                          },
                          onPreviousPage: () {
                            if (itemsPerPage > 0) {
                              currentFavPage--;
                              context
                                  .read<AdvertsCubit>()
                                  .previousFavPage(token);
                            }
                          },
                          onFirstPage: () =>
                              context.read<AdvertsCubit>().fetchAdverts(token),
                        ),
                      const SizedBox(height: 15)
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
