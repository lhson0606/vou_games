// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:vou_games/features/authentication/data/datasources/auth_remote_data_source_contract.dart';
// import 'package:vou_games/features/authentication/data/models/sign_in_model.dart';
// import 'package:vou_games/features/authentication/data/models/sign_up_model.dart';
//
// import '../../../../core/error/exceptions.dart';
//
// class AuthFirebaseDataSource extends AuthDataSource {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   Future<UserCredential> googleAuthentication() {
//     // TODO: implement googleAuthentication
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<UserCredential> signIn(SignInModel signIn) async {
//     try {
//       firebaseAuth.currentUser?.reload();
//       var res = await firebaseAuth.signInWithEmailAndPassword(
//         email: signIn.email,
//         password: signIn.password,
//       );
//       return res;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         throw NoUserException();
//       } else if (e.code == 'wrong-password' || e.code =='invalid-credential' || e.code == 'invalid-email') {
//         throw WrongPasswordException();
//       } else if(e.code == 'too-many-requests'){
//         throw TooManyRequestsException();
//       }
//       else {
//         throw ServerException();
//       }
//     } on Exception {
//       throw ServerException();
//     }
//   }
//
//   @override
//   Future<UserCredential> signUp(SignUpModel signUp) {
//     // TODO: implement signUp
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Unit> verifyEmail() {
//     // TODO: implement verifyEmail
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Unit> logOut() {
//     try {
//       return firebaseAuth.signOut().then((value) => Future.value(unit));
//     } on FirebaseAuthException catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//       throw ServerException();
//     }
//   }
//
//   // return token of the user
//   @override
//   Future<String?> checkStoredUser() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         String? token = await user.getIdToken();
//         return token;
//       } else {
//         // User is not signed in
//         return null;
//       }
//     } catch (e) {
//       // Handle error
//       print('Error getting token: $e');
//       return null;
//     }
//   }
// }
