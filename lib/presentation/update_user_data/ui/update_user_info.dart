import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plasma/data/models/my_user.dart';
import 'package:plasma/domain/entities/blood_group.dart';
import 'package:plasma/domain/entities/city.dart';
import 'package:plasma/domain/entities/thana.dart';
import 'package:plasma/domain/entities/username.dart';
import 'package:plasma/presentation/app/assets.dart';
import 'package:plasma/presentation/app/blocs/app_bloc.dart';
import 'package:plasma/presentation/app/blood_group_input_field.dart';
import 'package:plasma/presentation/app/filled_button.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/app/loading_dialog.dart';
import 'package:plasma/presentation/update_user_data/logic/update_user_data_cubit.dart';
import 'package:plasma/presentation/update_user_data/logic/update_user_form_cubit.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateUserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateUserDataFormCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateUserDataCubit(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: BlocListener<UpdateUserDataCubit, UpdateUserDataState>(
          listener: (context, state) async {
            if (state is UpdatedUserDataExceptionState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is UpdatingUserDataState) {
              showDialog(
                context: context,
                builder: (context) => const LoadingDialog(),
                barrierDismissible: false,
              );
            }
            if (state is UpdatedUserDataState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Done")));
              Future.delayed(const Duration(seconds: 2));
              context.read<AppBloc>().add(AppAuthenticatedEvent());
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
            child: Scaffold(
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      const SizedBox(
                        height: 56.0,
                      ),
                      SvgPicture.asset(
                        Assets.userData,
                        height: 150.0,
                        width: 150.0,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dare ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "To ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "Donate ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      BlocBuilder<UpdateUserDataFormCubit,
                          UpdateUserDataFormState>(
                        builder: (context, state) {
                          return InputField(
                            validator: (value) {
                              if (state.isValidName) {
                                return null;
                              }
                              return state.usernameErrorMessage;
                            },

                            textInputType: TextInputType.text,
                            prefixIcon: Icons.account_circle_outlined,
                            label: "Name",
                            onChanged: (String value) => context
                                .read<UpdateUserDataFormCubit>()
                                .usernameChanged(Username(name: value.trim())),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      BlocBuilder<UpdateUserDataFormCubit,
                          UpdateUserDataFormState>(
                        builder: (context, state) {
                          return InputField(
                            validator: (value) {
                              if (state.isValidCity) {
                                return null;
                              }
                              return state.cityErrorMessage;
                            },

                            textInputType: TextInputType.text,
                            prefixIcon: Icons.location_city_outlined,
                            label: "City",
                            onChanged: (String value) => context
                                .read<UpdateUserDataFormCubit>()
                                .cityChanged(City(city: value.trim())),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      BlocBuilder<UpdateUserDataFormCubit,
                          UpdateUserDataFormState>(
                        builder: (context, state) {
                          return InputField(
                            validator: (value) {
                              if (state.isValidThana) {
                                return null;
                              }
                              return state.thanaErrorMessage;
                            },

                            textInputType: TextInputType.text,
                            prefixIcon: Icons.location_on_outlined,
                            label: "Thana",
                            onChanged: (String value) => context
                                .read<UpdateUserDataFormCubit>()
                                .thanaChanged(Thana(thana: value.trim())),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      BlocBuilder<UpdateUserDataFormCubit,
                          UpdateUserDataFormState>(
                        builder: (context, state) {
                          return BloodGroupInputField(
                            validator: (value) {
                              if (state.isValidBloodGroup) {
                                return null;
                              }
                              return state.bloodGroupErrorMessage;
                            },

                            icon: Icons.bloodtype_outlined,
                            label: "Blood Group",
                            onChanged: (String? value) => context
                                .read<UpdateUserDataFormCubit>()
                                .bloodGroupChanged(
                                    BloodGroup(group: value?.trim() ?? "")),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 56.0,
                      ),
                      BlocBuilder<UpdateUserDataFormCubit,
                          UpdateUserDataFormState>(
                        builder: (context, state) {
                          bool isValid = state.isValidName &&
                              state.isValidCity &&
                              state.isValidThana &&
                              state.isValidBloodGroup;
                          return MyFilledButton(
                            child: const Text(
                              "Finish",
                            ),
                            size: const Size(double.infinity, 0),
                            onTap: (isValid)
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      MyUser myUser = MyUser(
                                        username: state.username,
                                        bloodGroup: state.bloodGroup,
                                        city: state.city,
                                        thana: state.thana,
                                        phone: FirebaseAuth
                                            .instance.currentUser!.phoneNumber,
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                      );

                                      context
                                          .read<UpdateUserDataCubit>()
                                          .createUserData(myUser);
                                    }
                                  }
                                : null,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
