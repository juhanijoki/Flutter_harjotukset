import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/bloc/gallery_cubit.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<GalleryCubit, GalleryState>(
              builder: (context, state) {
                if (state is GalleryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GalleryLoaded) {
                  GridView.builder(
                      itemCount: state.images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6.0,
                              mainAxisSpacing: 6.0),
                      itemBuilder: (context, index) {
                        return Image.network(
                          state.images[index],
                          fit: BoxFit.cover,
                        );
                      });
                }
                return Container();
              },
            )),
      ),
    );
  }
}
