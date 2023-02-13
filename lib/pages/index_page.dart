import 'package:flutter/cupertino.dart';
import 'package:swc_front/widgets/advert_list.dart';
import 'package:swc_front/widgets/layout.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: Column(
        children: const [AdverList()],
      ),
    );
  }
}
