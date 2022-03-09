import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/core/exceptions/auth_exception.dart';
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
      phoneNumber: phoneNumber.phone,
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
  }) async {
    try {
      return await _firebaseAuth.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.code);
    }
  }

  @override
  Future<void> signOut() async => await FirebaseAuth.instance.signOut();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authState() {
    return _firebaseAuth.authStateChanges();
  }
}
