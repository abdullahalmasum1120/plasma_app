import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/home/logic/feature_images_bloc.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureImagesBloc, FeatureImagesState>(
      builder: (context, state) {
        if (state is FeatureImagesLoadedState &&
            state.featureImages.isNotEmpty) {
          return CarouselSlider.builder(
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 8),
              viewportFraction: 1.0,
              autoPlay: true,
            ),
            itemCount: state.featureImages.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(4, 8),
                        blurRadius: 8,
                      ),
                    ]),
                height: 240,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    state.featureImages[index].image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
