import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:plasma/domain/entities/blood_group.dart';
import 'package:plasma/domain/entities/city.dart';
import 'package:plasma/domain/entities/hospital.dart';
import 'package:plasma/domain/entities/note.dart';
import 'package:plasma/domain/entities/thana.dart';
import 'package:plasma/presentation/app/blood_group_input_field.dart';
import 'package:plasma/presentation/app/filled_Button.dart';
import 'package:plasma/presentation/add_request/logic/add_request_cubit.dart';
import 'package:plasma/presentation/add_request/logic/add_request_form_cubit.dart';
import 'package:plasma/presentation/app/input_field.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({Key? key}) : super(key: key);

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddRequestCubit(),
        ),
        BlocProvider(
          create: (context) => AddRequestFormCubit(),
        ),
      ],
      child: BlocListener<AddRequestCubit, AddRequestState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/add_request.svg",
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                  builder: (context, state) {
                    return InputField(
                      textInputType: TextInputType.text,
                      icon: Icons.local_hospital_outlined,
                      label: "Hospital Name",
                      onChanged: (String value) => context
                          .read<AddRequestFormCubit>()
                          .hospitalChanged(Hospital(name: value)),
                      errorText: state.hospitalErrorMessage,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                  builder: (context, state) {
                    return InputField(
                      textInputType: TextInputType.text,
                      icon: Icons.location_city_outlined,
                      label: "City",
                      onChanged: (String value) => context
                          .read<AddRequestFormCubit>()
                          .cityChanged(City(city: value)),
                      errorText: state.cityErrorMessage,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                  builder: (context, state) {
                    return InputField(
                      textInputType: TextInputType.text,
                      icon: Icons.location_on_outlined,
                      label: "Thana",
                      onChanged: (String value) => context
                          .read<AddRequestFormCubit>()
                          .thanaChanged(Thana(thana: value)),
                      errorText: state.thanaErrorMessage,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                  builder: (context, state) {
                    return BloodGroupInputField(
                      icon: Icons.bloodtype_outlined,
                      label: "Blood Group",
                      onChanged: (String? value) => context
                          .read<AddRequestFormCubit>()
                          .bloodGroupChanged(BloodGroup(group: value ?? "")),
                      errorText: state.bloodGroupErrorMessage,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                  builder: (context, state) {
                    return InputField(
                      textInputType: TextInputType.text,
                      icon: Icons.note_add_outlined,
                      label: "Note (Optional)",
                      onChanged: (String value) => context
                          .read<AddRequestFormCubit>()
                          .noteChanged(Note(note: value)),
                      errorText: state.noteErrorMessage,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                  builder: (context, state) {
                    return MyFilledButton(
                      child: Text(
                        "Post Request",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      size: const Size(0, 0),
                      onTap: () {
                        if (state.noteErrorMessage == null &&
                            state.bloodGroupErrorMessage == null &&
                            state.thanaErrorMessage == null &&
                            state.cityErrorMessage == null &&
                            state.hospitalErrorMessage == null) {
                          BloodRequest request = BloodRequest(
                            hospital: state.hospital,
                            city: state.city,
                            thana: state.thana,
                            bloodGroup: state.bloodGroup,
                            description: state.note,
                          );

                          context
                              .read<AddRequestCubit>()
                              .addRequest(request: request);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}