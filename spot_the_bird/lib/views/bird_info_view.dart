import 'package:flutter/material.dart';
import 'package:spot_the_bird/bloc/bird_post_cubit.dart';
import 'package:spot_the_bird/models/bird_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirdInfoView extends StatelessWidget {
  static const String routeName = '/bird_info_view';
  // const BirdInfoView({required this.birdModel, Key? key}) : super(key: key);

  // final BirdModel birdModel;

  @override
  Widget build(BuildContext context) {
    final BirdModel birdModel =
        ModalRoute.of(context)!.settings.arguments as BirdModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(birdModel.birdName),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 1.4,
            child: Image.file(birdModel.image, fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(birdModel.birdName,
                style: Theme.of(context).textTheme.headline5),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(birdModel.birdDesc,
                style: Theme.of(context).textTheme.headline6),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<BirdPostCubit>().deletePost(birdModel);

                Navigator.of(context).pop();
              },
              child: const Text('Delete')),
        ],
      ),
    );
  }
}
