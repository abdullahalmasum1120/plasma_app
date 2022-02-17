import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/domain/entities/phone_number.dart';
import 'package:plasma/domain/interfaces/i_auth.dart';

class AuthRepo extends IAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  @override
  Future<void> sendOtp({
    int? forceResendingToken,
    Duration duration = const Duration(minutes: 2),
    required PhoneNumber phoneNumber,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      timeout: duration,
      phoneNumber: "+88${phoneNumber.phone}",
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  @override
  Future<UserCredential> signIn({
    required AuthCredential authCredential,
  }) async =>
      await _firebaseAuth.signInWithCredential(authCredential);

  @override
  Future<void> signOut() async => await FirebaseAuth.instance.signOut();
}
