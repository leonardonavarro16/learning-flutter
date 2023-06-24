import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';

import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/advert_filter.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/pagination_index.dart';
import 'package:swc_front/presentation/widgets/utils/story_bubble.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../../logic/cubits/adverts.dart';
import '../../logic/states/adverts.dart';
import '../widgets/advert_list.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.read<AuthenticationCubit>().state.token;
    int currentFavPageIndex = context.watch<AdvertsCubit>().state.currentPage;
    int decreasedCurrentPageIndex = currentFavPageIndex - 1;
    int increasedCurrentPageIndex = currentFavPageIndex + 1;
    int itemsPerPage = 10;
    int currentPage = 0;

    print("dotenv.env['API_URL'] = ${dotenv.env['API_URL']}");

    return Layout(
      content: BlocBuilder<AdvertsCubit, AdvertsState>(
        builder: (BuildContext context, AdvertsState state) {
          if (state.status == AdvertsStatus.indexSuccess) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterWidget(
                        adTags: state.adTags,
                        adverts: state.adverts,
                      ),
                      SvgPicture.asset(
                        'assets/Logo rojo.svg',
                        height: 50,
                        width: 50,
                      )
                    ],
                  ),
                ),
                // const SearchAppBar(),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      itemCount: 20,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return StoryBubble();
                      }),
                ),

                // SPACE DESIGNED TO ADVERTS POST AS LISTVIEW
                Expanded(
                  child: ListView(
                    children: [
                      AdverList(adverts: state.adverts),
                      const SizedBox(height: 15),
                      PaginationIndex(
                        currentPageIndex: currentFavPageIndex,
                        increasedCurrentPageIndex: increasedCurrentPageIndex,
                        decreasedCurrentPageIndex: decreasedCurrentPageIndex,
                        onNextPage: () {
                          if (state.adverts.length >= 10) {
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
                  ),
                ),
              ],
            );
          } else if (state.status == AdvertsStatus.indexFailure) {
            return TextView(text: state.error, color: const Color(0xFFFF0000));
          } else {
            return const Center(child: CustomIndicatorProgress());
          }
        },
      ),
    );
  }
}
