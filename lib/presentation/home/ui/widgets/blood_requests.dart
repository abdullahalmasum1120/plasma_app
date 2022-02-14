import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/home/logic/requests_bloc.dart';
import 'package:plasma/presentation/home/ui/widgets/blood_request_item.dart';

class BloodRequests extends StatelessWidget {
  const BloodRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsBloc, RequestsState>(
      builder: (context, state) {
        if (state is RequestsLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is RequestsLoadedState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BloodRequestItem(
                  request: state.requests[index],
                );
              },
              childCount: state.requests.length,
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
