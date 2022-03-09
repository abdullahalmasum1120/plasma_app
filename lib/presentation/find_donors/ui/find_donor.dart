import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plasma/presentation/find_donors/logic/donors_cubit.dart';
import 'package:plasma/presentation/find_donors/ui/widgets/donor_list_item.dart';
import 'package:plasma/presentation/find_donors/ui/widgets/search_bar.dart';

class FindDonorScreen extends StatelessWidget {
  const FindDonorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DonorsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Find Donor"),
        ),
        body: CustomScrollView(
          slivers: [
            const SearchBar(),
            BlocBuilder<DonorsCubit, DonorsState>(
              builder: (context, state) {
                if (state is DonorsLoadingState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: SpinKitPumpingHeart(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }
                if (state is DonorsLoadedState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        return DonorListItem(
                          user: state.users[index],
                        );
                      }),
                      childCount: state.users.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
