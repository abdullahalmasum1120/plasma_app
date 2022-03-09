import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/find_donors/logic/donors_cubit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0,
      floating: true,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InputField(
            hint: "Search",
            prefixIcon: Icons.search_outlined,
            onChanged: (String value) {
              context.read<DonorsCubit>().searchDonors(searchKey: value);
            },
          ),
        ),
      ),
    );
  }
}
