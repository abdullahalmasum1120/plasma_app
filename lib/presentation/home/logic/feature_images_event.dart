part of 'feature_images_bloc.dart';

abstract class FeatureImagesEvent extends Equatable {
  const FeatureImagesEvent();
}

class LoadFeatureImagesEvent extends FeatureImagesEvent {
  final String? searchKey;

  const LoadFeatureImagesEvent({this.searchKey});

  @override
  List<Object?> get props => [searchKey];
}
