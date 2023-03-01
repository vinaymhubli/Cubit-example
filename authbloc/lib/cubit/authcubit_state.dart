import 'package:firebase_auth/firebase_auth.dart';

abstract class Authstate {}

class Authinitialstate extends Authstate {}

class Authloadstate extends Authstate {}

class Authotpsenderstate extends Authstate {}

class Authverifierstate extends Authstate {}

class Authlogedinstate extends Authstate {
  final User firebaseuser;
  Authlogedinstate(this.firebaseuser);
}

class Authlogoutstate extends Authstate {}

class Autherrorstate extends Authstate {
  final String error;
  Autherrorstate(this.error);
}
