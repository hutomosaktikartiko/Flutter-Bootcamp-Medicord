import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_medium/features/news/presentation/cubit/news_cubit.dart';
import 'features/news/presentation/pages/news/news_page.dart';
import 'service_locator.dart' as sl;

Future<void> main() async {
  await sl.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.serviceLocator<NewsCubit>(),
        ),
      ],
      child: const MaterialApp(home: NewsPage()),
    );
  }
}
