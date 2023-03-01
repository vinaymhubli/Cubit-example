import 'package:authbloc/cubit/authcubit.dart';
import 'package:authbloc/cubit/authcubit_state.dart';
import 'package:authbloc/views/validate_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title: const Text(
          'Authentication',
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
              controller: controller,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter Phone Number", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 20.0),
          BlocConsumer<AuthCubit, Authstate>(listener: (context, state) {
            if (state is Authotpsenderstate) {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => ValidateAuth()));
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
                    String phoneNumber = "+91";
                    BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                  },
                  icon: const Icon(Icons.login),
                  label: const Text(
                    "login",
                    style: TextStyle(fontSize: 20),
                  )),
            );
          })
        ],
      )),
    );
  }
}
