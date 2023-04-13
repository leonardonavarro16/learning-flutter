import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/presentation/widgets/layout.dart';

import '../../logic/cubits/adverts.dart';
import '../../logic/states/adverts.dart';
import '../widgets/advert_list.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: BlocBuilder<AdvertsCubit, AdvertsState>(
        builder: (BuildContext context, AdvertsState state) {
          if (state.status == AdvertsStatus.success) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                AdverList(adverts: state.adverts)
              ],
            );
          } else if (state.status == AdvertsStatus.failure) {
            return Text(state.error, style: const TextStyle(color: Colors.red));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
