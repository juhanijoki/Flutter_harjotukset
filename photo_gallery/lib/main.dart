import 'package:flutter/material.dart';
import './bloc/gallery_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/gallery_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryCubit>(
      create: (context) => GalleryCubit()..getImagesFromPixabay(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const PhotoView(),
      ),
    );
  }
}
