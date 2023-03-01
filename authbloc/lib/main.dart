import 'package:authbloc/cubit/authcubit.dart';
import 'package:authbloc/views/home.dart';
import 'package:authbloc/views/sucessful_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/authcubit_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            BlocBuilder<AuthCubit, Authstate>(buildWhen: (oldState, newState) {
          return oldState is Authinitialstate;
        }, builder: (context, state) {
          if (state is Authlogedinstate) {
            return const SucessPage();
          } else if (state is Authlogoutstate) {
            return const AuthHome();
          } else {
            return const Scaffold();
          }
        }),
      ),
    );
  }
}
