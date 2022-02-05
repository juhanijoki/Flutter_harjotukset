import 'dart:io';

class BirdModel {
  int? id;
  String birdName;
  String birdDesc;

  double latitude;
  double longitude;

  File image;

  BirdModel({
    this.id,
    required this.birdName,
    required this.birdDesc,
    required this.latitude,
    required this.longitude,
    required this.image,
  });
}
