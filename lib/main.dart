import 'package:flutter/material.dart';
import 'package:swc_front/presentation/pages/index_page.dart';

import 'presentation/router/app_router.dart';

void main() => runApp(SwcApp());

class SwcApp extends StatelessWidget {
  final AppNavigatorObserver navigatorObserver = AppNavigatorObserver();
  SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IndexPage(),
      navigatorObservers: [navigatorObserver],
    );
  }
}


//todo: en el index page dejar de usar un FutureBuilder y usar un BlocBuilder
//todo: en la ruta pasarle el BlocProvider
//todo: crear eventos del AdvertsCubit AdvertsFetchInProcess, AdvertsFetchSuccess, AdvertsFetchFailure
//todo: crear un AdvertsCubit
//todo: crear eventos del CurrentUserCubit son CurrentUserFetchInitial, CurrentUserFetchInProcess, CurrentUserFetchSuccess, CurrentUserFetchFailure
//todo: crear un CurrentUserCubit
//todo: 
//todo: 
//todo: 
//todo: 
//todo: 