import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/home/logic/feature_images_bloc.dart';
import 'package:plasma/presentation/home/logic/requests_bloc.dart';
import 'package:plasma/presentation/home/ui/widgets/appbar.dart';
import 'package:plasma/presentation/home/ui/widgets/blood_requests.dart';
import 'package:plasma/presentation/home/ui/widgets/grid_menu.dart';
import 'package:plasma/presentation/home/ui/widgets/image_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeatureImagesBloc(),
        ),
        BlocProvider(
          create: (context) => RequestsBloc(),
        ),
      ],
      child: Scaffold(
        appBar: const MyAppBar(),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const SliverToBoxAdapter(
              child: ImageSlider(),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(4.0),
              sliver: GridMenu(),
            ),
            SliverAppBar(
              pinned: true,
              floating: true,
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              automaticallyImplyLeading: false,
              title: GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: BlocBuilder<RequestsBloc, RequestsState>(
                  builder: (context, state) {
                    return Text(
                      "Donation Requests",
                      style: state is RequestsLoadedState &&
                              state.requests.isEmpty
                          ? TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor)
                          : Theme.of(context).textTheme.titleMedium,
                    );
                  },
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(4.0),
              sliver: BloodRequests(),
            ),
          ],
        ),
      ),
    );
  }
}
