import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plasma/data/models/featured_image.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'feature_images_event.dart';

part 'feature_images_state.dart';

class FeatureImagesBloc extends Bloc<FeatureImagesEvent, FeatureImagesState> {
  List<FeatureImage> _images = <FeatureImage>[];
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();

  FeatureImagesBloc() : super(FeatureImagesLoadingState()) {
    _firebaseDBRepo.featureImageStream().listen((List<FeatureImage> images) {
      _images = images;
      add(const LoadFeatureImagesEvent());
    });
    on<LoadFeatureImagesEvent>((event, emit) {
      if (event.searchKey == null) {
        emit(FeatureImagesLoadedState(featureImages: _images));
      } else {
        List<FeatureImage> searchedImages = <FeatureImage>[];
        for (FeatureImage images in _images) {
          if (images.username!.contains(event.searchKey!)) {
            searchedImages.add(images);
          }
        }
        emit(FeatureImagesLoadedState(featureImages: searchedImages));
      }
    });
  }
}
