import 'dart:io';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/bird_model.dart';
import '../bloc/bird_post_cubit.dart';

class AddBirdView extends StatefulWidget {
  static const String routeName = '/add_bird_view';
  // final File image;
  // final LatLng latLng;

  // const AddBirdView({
  //   required this.latLng,
  //   required this.image,
  // });

  @override
  _AddBirdViewState createState() => _AddBirdViewState();
}

class _AddBirdViewState extends State<AddBirdView> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? desc;

  late final FocusNode _descriptionFocusNode;

  void _submit(BuildContext context, LatLng latLng, File image) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    // Lisää linnun postaus

    context.read<BirdPostCubit>().addBirdPost(BirdModel(
        birdName: name!,
        birdDesc: desc!,
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        image: image));

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final LatLng latLng = args['latLng'];
    final File image = args['image'] as File;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lisää lintu'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Linnun nimi tekstikenttä
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter bird name...'),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                name = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 2) {
                  return 'Enter longer name...';
                }
                return null;
              },
            ),
            TextFormField(
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_) => _submit(context, latLng, image),
              decoration:
                  const InputDecoration(hintText: 'Enter bird description...'),
              textInputAction: TextInputAction.done,
              onSaved: (newValue) {
                desc = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 2) {
                  return 'Enter longer name...';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lisää linnun postaus ja palaa takaisin karttaan
          _submit(context, latLng, image);
        },
      ),
    );
  }
}
