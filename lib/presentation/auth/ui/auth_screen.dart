import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plasma/domain/entities/otp_code.dart';
import 'package:plasma/domain/entities/phone_number.dart';
import 'package:plasma/presentation/app/filled_Button.dart';
import 'package:plasma/presentation/app/input_field.dart';
import 'package:plasma/presentation/auth/logic/authentication_bloc.dart';
import 'package:plasma/presentation/auth/logic/otp_form_cubit.dart';
import 'package:plasma/presentation/auth/logic/phone_form_cubit.dart';
import 'package:plasma/presentation/auth/logic/timer_bloc.dart';
import 'package:plasma/presentation/home/ui/home_screen.dart';
import 'package:plasma/presentation/update_user_data/ui/update_user_info.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => PhoneFormCubit(),
        ),
        BlocProvider(
          create: (context) => OtpFormCubit(),
        ),
        BlocProvider(
          create: (context) => TimerBloc(ticker: const Ticker()),
        ),
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, authenticationState) async {
          if (authenticationState is OtpSentState) {
            context.read<TimerBloc>().add(const TimerStarted(duration: 60 * 2));
          } else {
            context.read<TimerBloc>().add(const TimerReset());
          }
          if (authenticationState is OtpTimeOutState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Otp code expired"),
              duration: Duration(seconds: 5),
            ));
            // context.read<AuthenticationBloc>().add(AuthInitialEvent());
          }
          if (authenticationState is AuthExceptionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authenticationState.message),
              duration: const Duration(seconds: 5),
            ));
          }
          if (authenticationState is OtpVerifiedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Verified"),
              duration: Duration(seconds: 2),
            ));
            context.read<TimerBloc>().add(const TimerReset());
            await Future.delayed(const Duration(seconds: 2));
            if (authenticationState.userCredential.user!.displayName != null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateUserDataScreen()),
                (route) => false,
              );
            }
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusScopeNode());
          },
          child: Scaffold(
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authenticationState) {
                return SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      const SizedBox(
                        height: 56.0,
                      ),
                      SvgPicture.asset(
                        "assets/icons/auth_otp.svg",
                        color: Theme.of(context).primaryColor,
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Verify your phone",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "We ${(authenticationState is OtpSentState) ? "have sent" : "will send"} you a 6-digits verification code to this number",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      BlocBuilder<PhoneFormCubit, PhoneFormState>(
                        builder: (context, phoneFormState) {
                          return InputField(
                            onChanged: (String phone) {
                              context
                                  .read<PhoneFormCubit>()
                                  .valueChanged(PhoneNumber(phone: phone));
                            },
                            label: "Phone Number",
                            textInputType: TextInputType.phone,
                            errorText: phoneFormState.hasError
                                ? phoneFormState.errorMessage
                                : null,
                            prefixIcon: Icons.call_outlined,
                            suffix: (phoneFormState.hasError)
                                ? null
                                : InkWell(
                                    onTap: (authenticationState
                                                is AuthInitialState ||
                                            authenticationState
                                                is AuthExceptionState)
                                        ? () {
                                            context
                                                .read<AuthenticationBloc>()
                                                .add(SendOtpEvent(
                                                  phoneNumber: phoneFormState
                                                      .phoneNumber,
                                                ));
                                          }
                                        : null,
                                    child: BlocBuilder<TimerBloc, TimerState>(
                                      builder: (context, timerState) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12.0),
                                          child: Text(
                                            (authenticationState
                                                    is OtpSentState)
                                                ? timerState.duration.toString()
                                                : (authenticationState
                                                        is OtpSendingState)
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
                                                        : Theme.of(context)
                                                            .primaryColor),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            readOnly: authenticationState is OtpSentState,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      BlocBuilder<OtpFormCubit, OtpFormState>(
                        builder: (context, otpFormState) {
                          return Visibility(
                            visible: authenticationState is OtpSentState,
                            child: InputField(
                              onChanged: (String otp) {
                                context
                                    .read<OtpFormCubit>()
                                    .valueChanged(OtpCode(code: otp));
                              },
                              prefixIcon: Icons.sms_outlined,
                              textInputType: TextInputType.number,
                              errorText: otpFormState.hasError
                                  ? otpFormState.errorMessage
                                  : null,
                              label: "Verification Code",
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      BlocBuilder<OtpFormCubit, OtpFormState>(
                        builder: (context, otpFormState) {
                          return MyFilledButton(
                            child: Text(
                              (authenticationState is OtpVerifyingState)
                                  ? "Verifying"
                                  : "Confirm",
                            ),
                            size: const Size(double.infinity, 0),
                            onTap: (authenticationState is OtpSentState &&
                                    (!otpFormState.hasError))
                                ? () {
                                    context.read<AuthenticationBloc>().add(
                                          VerifyOtpEvent(
                                            otpCode: otpFormState.otpCode,
                                            verificationId: authenticationState
                                                .verificationId,
                                          ),
                                        );
                                  }
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
