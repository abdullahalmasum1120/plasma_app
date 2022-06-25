import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:plasma/data/repositories/auth_repo.dart';
import 'package:plasma/domain/entities/blood_group.dart';
import 'package:plasma/domain/entities/city.dart';
import 'package:plasma/domain/entities/hospital.dart';
import 'package:plasma/domain/entities/note.dart';
import 'package:plasma/domain/entities/thana.dart';
import 'package:plasma/presentation/app/assets.dart';
import 'package:plasma/presentation/app/blood_group_input_field.dart';
import 'package:plasma/presentation/app/filled_button.dart';
import 'package:plasma/presentation/add_request/logic/add_request_cubit.dart';
import 'package:plasma/presentation/add_request/logic/add_request_form_cubit.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/app/loading_dialog.dart';
import 'package:uuid/uuid.dart';

class AddRequestScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddRequestScreen({Key? key}) : super(key: key);

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
          if (state is AddingRequestState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(),
            );
          }
          if (state is RequestAddedState) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is RequestExceptionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusScopeNode());
          },
          child: Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
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
                        Hero(
                          tag: "Add Request",
                          transitionOnUserGestures: true,
                          child: SvgPicture.asset(
                            Assets.addRequest,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                      builder: (context, state) {
                        return InputField(
                          autoValidateMode: AutovalidateMode.always,
                          textInputType: TextInputType.text,
                          prefixIcon: Icons.local_hospital_outlined,
                          label: "Hospital Name",
                          onChanged: (String value) => context
                              .read<AddRequestFormCubit>()
                              .hospitalChanged(Hospital(name: value)),
                          validator: (value) {
                            if (state.hasHospitalError && value != null) {
                              return state.hospitalErrorMessage;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                      builder: (context, state) {
                        return InputField(
                          autoValidateMode: AutovalidateMode.always,
                          textInputType: TextInputType.text,
                          prefixIcon: Icons.location_city_outlined,
                          label: "City",
                          onChanged: (String value) => context
                              .read<AddRequestFormCubit>()
                              .cityChanged(City(city: value)),
                          validator: (value) {
                            if (state.hasCityError && value != null) {
                              return state.cityErrorMessage;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                      builder: (context, state) {
                        return InputField(
                          autoValidateMode: AutovalidateMode.always,
                          textInputType: TextInputType.text,
                          prefixIcon: Icons.location_on_outlined,
                          label: "Thana",
                          onChanged: (String value) => context
                              .read<AddRequestFormCubit>()
                              .thanaChanged(Thana(thana: value)),
                          validator: (value) {
                            if (state.hasThanaError && value != null) {
                              return state.thanaErrorMessage;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                      builder: (context, state) {
                        return BloodGroupInputField(
                          autoValidateMode: AutovalidateMode.always,
                          icon: Icons.bloodtype_outlined,
                          label: "Blood Group",
                          onChanged: (String? value) => context
                              .read<AddRequestFormCubit>()
                              .bloodGroupChanged(
                                  BloodGroup(group: value ?? "")),
                          validator: (value) {
                            if (state.hasBloodGroupError && value != null) {
                              return state.bloodGroupErrorMessage;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AddRequestFormCubit, AddRequestFormState>(
                      builder: (context, state) {
                        return InputField(
                          autoValidateMode: AutovalidateMode.always,
                          textInputType: TextInputType.text,
                          prefixIcon: Icons.note_add_outlined,
                          label: "Note (Optional)",
                          onChanged: (String value) => context
                              .read<AddRequestFormCubit>()
                              .noteChanged(Note(note: value)),
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
                          onTap: (state.hasHospitalError ||
                                  state.hasBloodGroupError ||
                                  state.hasThanaError ||
                                  state.hasCityError)
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    BloodRequest request = BloodRequest(
                                      hospital: state.hospital,
                                      city: state.city,
                                      thana: state.thana,
                                      bloodGroup: state.bloodGroup,
                                      description: state.note,
                                      id: const Uuid().v1(),
                                      phone:
                                          AuthRepo().currentUser?.phoneNumber,
                                      uid: AuthRepo().currentUser?.uid,
                                      username:
                                          AuthRepo().currentUser?.displayName,
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
        ),
      ),
    );
  }
}
