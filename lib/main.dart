import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_medium/day_3/cubit/list_posts_cubit.dart';
import 'package:flutter_medium/day_4/cubit/list_post_day4_cubit.dart';

import 'day_3/screens/home_day_3_screen.dart';
import 'day_4/screens/home_day_4_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListPostsCubit(),
        ),
        BlocProvider(
          create: (context) => ListPostDay4Cubit(),
        ),
      ],
      child: const MaterialApp(
        home: HomeDay3Screen(),
      ),
    );
  }
}
