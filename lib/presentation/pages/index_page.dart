import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/advert_search_field.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/pagination_index.dart';
import 'package:swc_front/presentation/widgets/utils/stories_tile_widget.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../../logic/cubits/adverts.dart';
import '../../logic/states/adverts.dart';
import '../widgets/advert_list.dart';

class IndexPage extends StatelessWidget {
  final String? searchText;

  const IndexPage({Key? key, this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? token = context.read<AuthenticationCubit>().state.token;
    User? currentUser = context.watch<AuthenticationCubit>().state.user;
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    int currentFavPageIndex = context.watch<AdvertsCubit>().state.currentPage;
    int decreasedCurrentPageIndex = currentFavPageIndex - 1;
    int increasedCurrentPageIndex = currentFavPageIndex + 1;
    int itemsPerPage = 10;
    int currentPage = 0;
    double maxWidth = MediaQuery.of(context).size.width;

    return Layout(
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: maxWidth * 0.60,
                  height: 40,
                  child: AdvertSearchField(
                    searchText: searchText,
                    onChange: (value, shouldSearch) {
                      if (value.length >= 3) {
                        context
                            .read<AdvertsCubit>()
                            .fetchAdverts(token, searchText: value);
                      } else if (value.isEmpty) {
                        context.read<AdvertsCubit>().fetchAdverts(token);
                      }
                    },
                  ),
                ),
                SizedBox(width: maxWidth * 0.05),
                SvgPicture.asset(
                  'assets/Logo rojo.svg',
                  height: 50,
                  width: maxWidth * 0.1,
                ),
              ],
            ),
          ),
          if (isLogged)
            StoriesTile(
                username: currentUser!.name,
                backgroundImage:
                    // currentUser?.image != null ?
                    MemoryImage(currentUser.image!)
                // : null,
                ),
          Expanded(
            child: BlocBuilder<AdvertsCubit, AdvertsState>(
              builder: (BuildContext context, AdvertsState state) {
                if (state.status == AdvertsStatus.indexSuccess) {
                  List<Advert> filteredAdverts = state.adverts;

                  if (searchText != null && searchText!.length >= 3) {
                    filteredAdverts = state.adverts
                        .where((advert) => advert.name
                            .toLowerCase()
                            .contains(searchText!.toLowerCase()))
                        .toList();
                  }

                  if (filteredAdverts.isEmpty) {
                    return const Center(
                      child: TextView(
                        text: 'No se encontraron anuncios',
                        color: Colors.white,
                      ),
                    );
                  }

                  return ListView(
                    children: [
                      AdverList(adverts: filteredAdverts),
                      const SizedBox(height: 15),
                      PaginationIndex(
                        currentPageIndex: currentFavPageIndex,
                        increasedCurrentPageIndex: increasedCurrentPageIndex,
                        decreasedCurrentPageIndex: decreasedCurrentPageIndex,
                        onNextPage: () {
                          if (filteredAdverts.length >= 10) {
                            currentPage++;
                            context.read<AdvertsCubit>().nextPage(token);
                          }
                        },
                        onPreviousPage: () {
                          if (itemsPerPage > 0) {
                            currentPage--;
                            context.read<AdvertsCubit>().previousPage(token);
                          }
                        },
                      ),
                      const SizedBox(height: 15)
                    ],
                  );
                } else if (state.status == AdvertsStatus.indexFailure) {
                  return TextView(
                      text: state.error, color: const Color(0xFFFF0000));
                } else {
                  return const Center(child: CustomIndicatorProgress());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
