import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/domain/entities/phone_number.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/auth/logic/authentication_bloc.dart';
import 'package:plasma/presentation/auth/logic/phone_form_cubit.dart';
import 'package:plasma/presentation/auth/logic/timer_bloc.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        return BlocBuilder<PhoneFormCubit, PhoneFormState>(
          builder: (context, phoneFormState) {
            return InputField(
              onChanged: (String phone) {
                context
                    .read<PhoneFormCubit>()
                    .valueChanged(PhoneNumber(phone: "+88$phone"));
              },
              label: "Phone Number",
              textInputType: TextInputType.phone,
              errorText:
                  phoneFormState.isValid ? null : phoneFormState.errorMessage,
              prefixIcon: Icons.call_outlined,
              suffix: (phoneFormState.isValid)
                  ? InkWell(
                      onTap: (authenticationState is AuthInitialState ||
                              authenticationState is AuthExceptionState)
                          ? () {
                              FocusScope.of(context)
                                  .requestFocus(FocusScopeNode());
                              context
                                  .read<AuthenticationBloc>()
                                  .add(SendOtpEvent(
                                    phoneNumber: phoneFormState.phoneNumber,
                                  ));
                            }
                          : null,
                      child: BlocBuilder<TimerBloc, TimerState>(
                        builder: (context, timerState) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              (authenticationState is OtpSentState ||
                                      authenticationState is OtpExceptionState)
                                  ? timerState.duration.toString()
                                  : (authenticationState is OtpSendingState)
                                      ? "sending..."
                                      : "Send SMS",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: (authenticationState
                                                  is OtpSentState ||
                                              authenticationState
                                                  is OtpSendingState)
                                          ? Colors.grey
                                          : Theme.of(context).primaryColor),
                            ),
                          );
                        },
                      ),
                    )
                  : null,
              readOnly: authenticationState is OtpSentState ||
                  authenticationState is OtpExceptionState,
            );
          },
        );
      },
    );
  }
}
