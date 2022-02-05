import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/bloc/bird_post_cubit.dart';
import 'package:spot_the_bird/bloc/location_cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../models/bird_model.dart';
import 'dart:developer';
import 'dart:io';
import 'bird_info_view.dart';
import 'add_bird_view.dart';

class KarttaView extends StatelessWidget {
  KarttaView({Key? key}) : super(key: key);

  final MapController _mapController = MapController();

  Future<void> _getImageAndCreatePost(
      {required BuildContext context, required LatLng latLng}) async {
    File? image;

    final ImagePicker imagePicker = ImagePicker();
    // Valitse kuva
    final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);

    if (pickedImage != null) {
      // Siirrytään addbird-näkymään

      image = File(pickedImage.path);
      Navigator.of(context).pushNamed(AddBirdView.routeName, arguments: {
        'latLng': latLng,
        'image': image,
      });
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => AddBirdView(latLng: latLng, image: image!)));
    } else {
      log('No image selected');
    }
  }

  List<Marker> _buildMarkers(List<BirdModel> birdPosts) {
    List<Marker> markers = [];

    for (var post in birdPosts) {
      markers.add(Marker(
        point: LatLng(post.latitude, post.longitude),
        width: 55,
        height: 55,
        builder: (context) => Container(
          color: Colors.yellow,
        ),
      ));
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
          listener: (previousState, currentState) {
            if (currentState is LocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error fetching location')));
            }
            if (currentState is LocationLoaded) {
              _mapController.onReady.then((value) => _mapController.move(
                  LatLng(currentState.latitude, currentState.longitude), 15));
            }
          },
          child: BlocConsumer<BirdPostCubit, BirdPostState>(
            listener: (prevState, currState) {
              if (currState.status == BirdPostStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).errorColor,
                  duration: const Duration(seconds: 2),
                  content: const Text(
                      'Error has occured while doing operations with bird posts'),
                ));
              }
            },
            buildWhen: (prevState, currentState) =>
                (prevState.status != currentState.status),
            builder: (context, birdPostState) => FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onLongPress: (position, latLng) {
                  // Valitsee kuvan ja menee addbird-näkymään missä lintu luodaan
                  _getImageAndCreatePost(context: context, latLng: latLng);
                },
                center: LatLng(0, 0),
                zoom: 12,
                maxZoom: 17,
                minZoom: 3.5,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  retinaMode: true,
                ),
                MarkerLayerOptions(
                  // markers: _buildMarkers(birdPostState.birdPosts),
                  markers: birdPostState.birdPosts
                      .map(
                        (post) => Marker(
                          width: 55,
                          height: 55,
                          point: LatLng(post.latitude, post.longitude),
                          builder: (context) => GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/bird_info_view',
                                arguments: post),
                            child: Image.asset('assets/bird_icon.png'),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.navigation_rounded,
          size: 30,
        ),
        onPressed: () {
          context.read<LocationCubit>().getLocation();
        },
      ),
    );
  }
}
