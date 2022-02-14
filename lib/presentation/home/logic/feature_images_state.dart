part of 'feature_images_bloc.dart';

abstract class FeatureImagesState extends Equatable {
  const FeatureImagesState();
}

class FeatureImagesLoadingState extends FeatureImagesState {
  @override
  List<Object> get props => [];
}

class FeatureImagesLoadedState extends FeatureImagesState {
  final List<FeatureImage> featureImages;

  const FeatureImagesLoadedState({required this.featureImages});

  @override
  List<Object?> get props => [featureImages];
}
