import 'package:authbloc/cubit/authcubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<Authstate> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(Authinitialstate()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(Authlogedinstate(currentUser));
    } else {
      emit(Authlogoutstate());
    }
  }
  String? _verificationId;
  void sendOtp(String phoneNumber) async {
    emit(Authloadstate());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          signin(phoneAuthCredential);
        },
        verificationFailed: (error) {
          emit(Autherrorstate(error.message.toString()));
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(Authotpsenderstate());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        });
  }

  void verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signin(credential);
  }

  void signin(PhoneAuthCredential credential) async {
    try {
      UserCredential usercred = await _auth.signInWithCredential(credential);
      if (usercred.user != null) {
        emit(Authlogedinstate(usercred.user!));
      }
    } on FirebaseAuthException catch (er) {
      emit(Autherrorstate(er.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(Authlogoutstate());
  }
}
