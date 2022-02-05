import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_the_bird/bloc/bird_post_cubit.dart';
import 'package:spot_the_bird/bloc/location_cubit.dart';
import 'package:spot_the_bird/views/add_bird_view.dart';
import 'package:spot_the_bird/views/bird_info_view.dart';
import 'views/kartta_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit()..getLocation(),
        ),
        BlocProvider<BirdPostCubit>(
            create: (context) => BirdPostCubit()..getPosts()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlue.shade700),
          primarySwatch: Colors.lightGreen,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ),
        ),
        // home: KarttaView(),
        initialRoute: '/',
        routes: {
          '/': (context) => KarttaView(),
          BirdInfoView.routeName: (context) => BirdInfoView(),
          AddBirdView.routeName: (context) => AddBirdView(),
        },
      ),
    );
  }
}
