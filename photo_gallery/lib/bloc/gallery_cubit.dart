import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery/services/network_helper.dart';
import '../keys.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(const GalleryInitial());

  Future<void> getImagesFromPixabay() async {
    emit(const GalleryLoading());
    // Logiikan suoritus
    List<String> pixabyImages = [];

    String url =
        'https://pixabay.com/api/?key=$pixabayApiKey&image_type=photo&per_page=20&category=nature&page=1';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    Map<String, dynamic> data = await networkHelper.getData();

    for (var entry in data['hits']) {
      pixabyImages.add(entry['largeImageURL']);
    }
    //
    emit(GalleryLoaded(images: pixabyImages));
  }
}
