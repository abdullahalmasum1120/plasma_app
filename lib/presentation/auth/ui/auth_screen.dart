import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plasma/presentation/auth/logic/authentication_bloc.dart';
import 'package:plasma/presentation/auth/logic/otp_form_cubit.dart';
import 'package:plasma/presentation/auth/logic/phone_form_cubit.dart';
import 'package:plasma/presentation/auth/logic/timer_bloc.dart';
import 'package:plasma/presentation/auth/ui/widgets/otp_input.dart';
import 'package:plasma/presentation/auth/ui/widgets/phone_input.dart';
import 'package:plasma/presentation/auth/ui/widgets/otp_verify_button.dart';

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
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, authenticationState) async {
          if (authenticationState is OtpSentState) {
            context.read<TimerBloc>().add(const TimerStarted(duration: 60 * 2));
          }
          if (authenticationState is AuthExceptionState ||
              authenticationState is OtpVerifiedState) {
            context.read<TimerBloc>().add(const TimerReset());
          }
          if (authenticationState is AuthExceptionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authenticationState.message),
              duration: const Duration(seconds: 5),
            ));
          }
          if (authenticationState is OtpExceptionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authenticationState.message),
              duration: const Duration(seconds: 5),
            ));
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusScopeNode());
          },
          child: Scaffold(
            body: DoubleBackToCloseApp(
              snackBar:
                  const SnackBar(content: Text("Press again to exit this App")),
              child: SafeArea(
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
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return Text(
                          "We ${(state is OtpSentState) ? "have sent" : "will send"} you a 6-digits verification code to this number",
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const PhoneInput(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const OtpInput(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const OtpVerifyButton(),
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
