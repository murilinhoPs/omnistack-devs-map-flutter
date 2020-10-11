import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oministack_flutter_app/cubit/k_google_plex_cubit.dart';
import 'package:oministack_flutter_app/cubit/map_marks_cubit.dart';
import 'package:oministack_flutter_app/cubit/my_position_cubit.dart';
import 'pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyPositionCubit>(
          create: (_) => MyPositionCubit(),
        ),
        BlocProvider<MapMarksCubit>(
          create: (_) => MapMarksCubit(),
        ),
        BlocProvider<KGooglePlexCubit>(
          create: (_) => KGooglePlexCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
