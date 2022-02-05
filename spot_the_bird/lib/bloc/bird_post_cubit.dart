import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_the_bird/models/bird_model.dart';
import 'package:equatable/equatable.dart';
import 'package:spot_the_bird/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/bird_model.dart';

part 'bird_post_state.dart';

class BirdPostCubit extends Cubit<BirdPostState> {
  BirdPostCubit()
      : super(const BirdPostState(
          birdPosts: [],
          status: BirdPostStatus.initial,
        ));

  final DataBaseHelper _dbHelper = DataBaseHelper.instance;

  Future<void> getPosts() async {
    try {
      List<BirdModel> birdPosts = [];

      final List<Map<String, dynamic>> allRows = await _dbHelper.queryAllRows();

      if (allRows.isEmpty) {
        log('Rows are empty');
      } else {
        log('Rows have data');
      }

      for (Map<String, dynamic> row in allRows) {
        final Directory directory = await getApplicationDocumentsDirectory();

        final String path = '${directory.path}/${row['id']}.png';

        final File imageFile = File(path);

        imageFile.writeAsBytesSync(row[DataBaseHelper.picture]);

        birdPosts.add(BirdModel(
            id: row['id'],
            birdName: row[DataBaseHelper.birdName],
            birdDesc: row[DataBaseHelper.birdDesc],
            latitude: row[DataBaseHelper.latitude],
            longitude: row[DataBaseHelper.longitude],
            image: imageFile));
      }

      // emit(state.copyWith(birdPosts: birdPosts, status: BirdPostStatus.loaded));
    } catch (_) {
      emit(state.copyWith(status: BirdPostStatus.error));
    }
  }

  Future<void> addBirdPost(BirdModel birdModel) async {
    emit(state.copyWith(status: BirdPostStatus.loading));

    List<BirdModel> posts = [];

    posts.addAll(state.birdPosts);

    posts.add(birdModel);

    // TODO: add to SQL table

    Uint8List bytes = birdModel.image.readAsBytesSync();

    Map<String, dynamic> row = {
      DataBaseHelper.birdName: birdModel.birdName,
      DataBaseHelper.birdDesc: birdModel.birdDesc,
      DataBaseHelper.longitude: birdModel.longitude,
      DataBaseHelper.latitude: birdModel.latitude,
      DataBaseHelper.picture: bytes
    };

    final id = await _dbHelper.insert(row);

    birdModel.id = id;

    emit(state.copyWith(birdPosts: posts, status: BirdPostStatus.postAdded));
  }

  Future<void> deletePost(BirdModel birdModel) async {
    emit(state.copyWith(
      status: BirdPostStatus.loading,
    ));

    List<BirdModel> posts = List.from(
      state.birdPosts,
      growable: true,
    );

    posts.remove(birdModel);

    _dbHelper.delete(birdModel.id!);

    emit(state.copyWith(
      birdPosts: posts,
      status: BirdPostStatus.postRemoved,
    ));
  }
}
