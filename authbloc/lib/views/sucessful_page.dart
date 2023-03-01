import 'package:authbloc/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/authcubit.dart';
import '../cubit/authcubit_state.dart';

class SucessPage extends StatelessWidget {
  const SucessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Text("Welcome",
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            BlocConsumer<AuthCubit, Authstate>(listener: (context, state) {
              if (state is Authlogoutstate) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => const AuthHome()));
              }
            }, builder: (context, state) {
              return Container(
                color: Colors.teal,
                child: CupertinoButton(
                    child: const Text("Logout"),
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logOut();
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}
