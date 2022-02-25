import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/domain/entities/otp_code.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/auth/logic/authentication_bloc.dart';
import 'package:plasma/presentation/auth/logic/otp_form_cubit.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        return BlocBuilder<OtpFormCubit, OtpFormState>(
          builder: (context, otpFormState) {
            return Visibility(
              visible: authenticationState is OtpSentState || authenticationState is OtpExceptionState,
              child: InputField(
                onChanged: (String otp) {
                  context.read<OtpFormCubit>().valueChanged(OtpCode(code: otp));
                },
                prefixIcon: Icons.sms_outlined,
                textInputType: TextInputType.number,
                errorText:
                    otpFormState.isValid ? null : otpFormState.errorMessage,
                label: "Verification Code",
              ),
            );
          },
        );
      },
    );
  }
}
