import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:swc_front/widgets/advert_list.dart';
import 'package:swc_front/widgets/layout.dart';
import 'package:swc_front/models/advert.dart';

import '../states/adverts.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Advert> adverts = context.watch<AdvertsState>().adverts;
    return Layout(
      content: ListView(
        children: [const SizedBox(height: 20), AdverList(adverts: adverts)],
      ),
    );
  }
}
