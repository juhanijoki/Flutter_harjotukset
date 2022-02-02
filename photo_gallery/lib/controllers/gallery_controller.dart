import 'package:get/get.dart';
import '../services/network_helper.dart';
import '../keys.dart';

enum GalleryStatus { loading, initial, loaded, error }

class GalleryController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    getImages();

    update();
  }

  GalleryStatus status = GalleryStatus.initial;

  List<String> _images = [];

  List<String> get images {
    return [..._images];
  }

  int get photoCount => _images.length;
  int _page = 1;

  Future<void> getImages() async {
    status = GalleryStatus.loading;
    update();
    // Logiikan suoritus
    List<String> pixabyImages = [];

    String url =
        'https://pixabay.com/api/?key=$pixabayApiKey&image_type=photo&per_page=20&category=nature&page=$_page';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    Map<String, dynamic> data = await networkHelper.getData();

    for (var entry in data['hits']) {
      pixabyImages.add(entry['largeImageURL']);
    }
    _images = pixabyImages;
    status = GalleryStatus.loaded;

    update();
  }

  Future<void> loadMore() async {
    status = GalleryStatus.loading;
    update();
    List<String> pixabyImages = [];

    String url =
        'https://pixabay.com/api/?key=$pixabayApiKey&image_type=photo&per_page=20&category=nature&page=${_page + 1}';

    _page++;
    NetworkHelper networkHelper = NetworkHelper(url: url);

    Map<String, dynamic> data = await networkHelper.getData();

    for (var entry in data['hits']) {
      pixabyImages.add(entry['largeImageURL']);
    }
    _images.addAll(pixabyImages);

    status = GalleryStatus.loaded;

    update();
  }
}
