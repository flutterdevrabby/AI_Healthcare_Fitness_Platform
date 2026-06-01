// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class SocialLoginServices {
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await googleSignIn.s

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth = googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//   static final GoogleSignIn googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//   );

//   static Future<User?> signInWithGoogle(BuildContext context) async {
//     try {
//       // await InternetAddress.lookup('google.com');

//       // Trigger the Google Sign In flow
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();

//       // Obtain the GoogleSignInAuthentication object
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           googleSignInAccount!.authentication;

//       // Create a new credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       log('access token is : ${credential.accessToken}');

//       // Once signed in, return the UserCredential
//       var authResult = await _auth.signInWithCredential(credential);
//       // ToastUtil.showLongToast(authResult.toString());
//       if (authResult.user != null) {
//         log('auth user not null ');
//         await socialLoginRx.login(
//           token: credential.accessToken.toString(),
//           provider: "google",
//           role: 'renter',
//         );
//         log('accesstoken is : ${credential.accessToken}');
//         NavigationService.navigateToReplacementUntil(
//           Routes.navigationbarScreen,
//         );
//         ToastUtil.showSuccessToast(message: 'Login Sussessfully');
//       }
//       log("google sing in info$authResult");
//       // Return the current user
//       return authResult.user;
//     } catch (error) {
//       // ToastUtil.showLongToast(error.toString());
//       log("error type cast ${error.toString()}");
//       return null;
//     }
//   }

//   static Future<UserCredential?> signInWithApple(BuildContext context) async {
//     try {
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );

//       final String? identityToken = appleCredential.identityToken;
//       final String authorizationCode = appleCredential.authorizationCode;

//       if (identityToken == null || identityToken.isEmpty) {
//         debugPrint("❌ identityToken is null or empty. Aborting login.");
//         ToastUtil.showErrorToast(message: "Apple login failed. Try again.");
//         return null;
//       }

//       final oauthCredential = OAuthProvider(
//         "apple.com",
//       ).credential(idToken: identityToken, accessToken: authorizationCode);

//       debugPrint("🆔 ID Token: $identityToken");
//       debugPrint("🔑 Auth Code: $authorizationCode");

//       // Firebase authentication
//       final userCredential = await _auth.signInWithCredential(oauthCredential);
//       final user = userCredential.user;

//       if (user != null) {
//         // Extract full name and email if available
//         final String? fullName =
//             (appleCredential.givenName != null)
//                 ? "${appleCredential.givenName} ${appleCredential.familyName}"
//                 : user.displayName;

//         final String? email = appleCredential.email ?? user.email;

//         debugPrint("✅ Apple Login Success:");
//         debugPrint("👤 Name: $fullName");
//         debugPrint("📧 Email: $email");
//         debugPrint("🆔 UID: ${user.uid}");

//         // 🧪 Optional: Use UID or token for RevenueCat or backend
//         debugPrint("📤 Sending login to API...");

//         await socialLoginRx.login(
//           token: identityToken,
//           provider: "apple",
//           role: 'renter',
//         );

//         // Navigate to home
//         NavigationService.navigateTo(Routes.navigationbarScreen);
//         ToastUtil.showSuccessToast(message: 'Login Successfully');

//         return userCredential;
//       } else {
//         debugPrint("❌ Firebase User is null after Apple Sign-In.");
//         ToastUtil.showErrorToast(message: "Login failed. Please try again.");
//         return null;
//       }
//     } catch (e, stack) {
//       debugPrint("❌ Apple Sign-In Error: $e");
//       log("Apple Sign-In Exception", error: e, stackTrace: stack);
//       // ToastUtil.showLongToast("An error occurred during login.");
//       return null;
//     }
//   }
// }
