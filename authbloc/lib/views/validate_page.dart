import 'package:authbloc/cubit/authcubit.dart';
import 'package:authbloc/cubit/authcubit_state.dart';
import 'package:authbloc/views/sucessful_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidateAuth extends StatelessWidget {
  ValidateAuth({super.key});
  TextEditingController otpContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.teal,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title: const Text(
          'OTP Verifier',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: TextField(
              controller: otpContoller,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "enter 6 digit otp ", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 20.0),
          BlocConsumer<AuthCubit, Authstate>(listener: (context, state) {
            if (state is Authlogedinstate) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => const SucessPage()));
            } else if (state is Autherrorstate) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 300),
              ));
            }
          }, builder: (context, state) {
            if (state is Authloadstate) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left: 78.0, right: 78.0),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      fixedSize: const Size(25, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0))),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .verifyOtp(otpContoller.text);
                  },
                  icon: const Icon(Icons.verified),
                  label: const Text(
                    "verify",
                    style: TextStyle(fontSize: 20),
                  )),
            );
          })
        ],
      )),
    );
  }
}
