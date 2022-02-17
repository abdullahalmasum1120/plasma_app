import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/find_donors/logic/users_bloc.dart';
import 'package:plasma/presentation/find_donors/ui/widgets/donor_list_item.dart';

class FindDonor extends StatelessWidget {
  const FindDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Find Donor",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                toolbarHeight: 0,
                elevation: 0,
                floating: true,
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 70),
                  child: InputField(
                    hint: "Search",
                    prefixIcon: Icons.search_outlined,
                    onChanged: (String value) {
                      context
                          .read<UsersBloc>()
                          .add(LoadUserEvent(searchKey: value));
                    },
                  ),
                ),
              ),
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UsersLoadingState) {
                    //TODO: Loading
                  }
                  if (state is UserLoadedState) {
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
      ),
    );
  }
}
