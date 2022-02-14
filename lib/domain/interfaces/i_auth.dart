import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/domain/entities/phone_number.dart';

abstract class IAuth {
  Future<void> sendOtp({
    int? forceResendingToken,
    Duration duration = const Duration(minutes: 2),
    required PhoneNumber phoneNumber,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  });

  Future<UserCredential> signIn({
    required AuthCredential authCredential,
  });

  Future<void> signOut();

  bool get isSignedIn;
}
