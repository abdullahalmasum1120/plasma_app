import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/app/filled_Button.dart';
import 'package:plasma/presentation/auth/logic/authentication_bloc.dart';
import 'package:plasma/presentation/auth/logic/otp_form_cubit.dart';

class OtpVerifyButton extends StatelessWidget {
  const OtpVerifyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        return BlocBuilder<OtpFormCubit, OtpFormState>(
          builder: (context, otpFormState) {
            return MyFilledButton(
              child: Text(
                (authenticationState is OtpVerifyingState)
                    ? "Verifying..."
                    : "Confirm",
              ),
              size: const Size(double.infinity, 0),
              onTap: (otpFormState.isValid)
                  ? () {
                      if (authenticationState is OtpSentState ||
                          authenticationState is OtpExceptionState) {
                        context
                            .read<AuthenticationBloc>()
                            .add(VerifyOtpEvent(otpCode: otpFormState.otpCode));
                      }
                    }
                  : null,
            );
          },
        );
      },
    );
  }
}
