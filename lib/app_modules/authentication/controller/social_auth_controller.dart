// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison, avoid_print, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_flow/app_modules/authentication/model/social_login_user_data.dart';
import 'package:zen_flow/data/data_sources/remote/api_manager.dart';
import 'package:zen_flow/utils/constants/app_constants.dart';
import '../../../utils/app_imports/app_imports.dart';

class SocialAuthController extends GetxController {
  var isLoading = false.obs;
  var isLoadingFacebook = false.obs;
  var isLoadingGoogle = false.obs;
  var isLoadingApple = false.obs;

  final _isPassObscure = true.obs;
  set setIsPassObscure(value) => _isPassObscure.value = value;
  get getIsPassObscure => _isPassObscure.value;
  final _isConfirmPassObscure = true.obs;
  set setIsConfirmPassObscure(value) => _isConfirmPassObscure.value = value;
  get getIsConfirmPassObscure => _isConfirmPassObscure.value;

  userSocialLogin({
    String? socialType,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? socialId,
  }) async {
    print(
        '=========================start social Login=========================');
    try {
      isLoading(true);
      var fcmToken = await FirebaseMessaging.instance.getToken();
      var response = await ApiManager().requestAPi(ApiConstant.socialLoginUrl,
          data: phone == ''
              ? {
                  'social_id':
                      socialId ?? FirebaseAuth.instance.currentUser!.uid,
                  'social_type': socialType,
                  'role': '2',
                  'fcm_token': fcmToken,
                  'first_name': firstName,
                  'last_name': lastName,
                  'email': email,
                }
              : {
                  'social_id':
                      socialId ?? FirebaseAuth.instance.currentUser!.uid,
                  // 'social_id': FirebaseAuth.instance.currentUser!.uid,
                  'social_type': socialType,
                  'role': '2',
                  'fcm_token': fcmToken,
                  'first_name': firstName,
                  'last_name': lastName,
                  'email': email,
                  'phone': phone,
                });
      var jsonData = jsonDecode(response.toString());
      print('response from controller $jsonData');
      if (response != null) {
        if (jsonData['statusCode'] == 200) {
          // Save in Local Storage
          storageBox.write(StorageConstants.loggedInData, jsonData);
          storageBox.write(StorageConstants.profileImageUrl,
              jsonData['data']['user']['profile_pic'] ?? '');

          appToastView(title: 'Login Success');
          // Get.offAllNamed(
          //   Routes.dashBoard,
          // );

          isLoading(false);
        } else {
          isLoading(false);
          appToastView(title: jsonData['message'].toString());
        }
      }
    } catch (e) {
      isLoading(false);
      print(e.toString());
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ////////////////////////////////// - Log in with Google
  Future<User> loginInWithGoogle(
      {bool isLogin = false, var loginType, var subscriptionType}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      isLoadingGoogle(true);
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      // Sign out of any previous Google accounts
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign in aborted by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      bool isGoogleAuthenticated =
          await isGoogleAccountExists(userCredential.user!.email!);

      if (isGoogleAuthenticated) {
        bool isNewUser = await checkIfNewUser(userCredential);
        if (isNewUser) {
          // New user, perform additional actions
          // e.g., navigate to a registration form or questionnaire
          Get.toNamed(Routes.questionView, arguments: {
            'subscriptionType': subscriptionType,
            'loginType': loginType
          });
        } else {
          // Existing user, navigate to the home view
          getUserData();
          prefs.setString(AppConstants.isLogin, 'true');
          Get.toNamed(Routes.homeView);
        }
      } else {
        // Google account not authenticated with Firebase
        // Handle the error or prompt the user to authenticate
        // TODO: Handle the case when the Google account is not authenticated
      }

      return userCredential.user!; // Return the user object directly
    } on FirebaseAuthException catch (e) {
      appToastView(title: e.message.toString());
      throw e; // Re-throw the exception to handle it outside
    } catch (e) {
      isLoadingGoogle(false);
      print(e.toString());
      throw e; // Re-throw the exception to handle it outside
    }
  }

  Future<bool> isGoogleAccountExists(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty && signInMethods.contains('google.com');
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<bool> checkIfNewUser(UserCredential userCredential) async {
    return userCredential.additionalUserInfo?.isNewUser ?? false;
  }

  Future<void> signOutId() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {});
    } catch (e) {}
  }

  signOut() {
    FirebaseAuth.instance.signOut().then((value) {});
  }

  // - Log in with Apple

  late final FirebaseAuth? _firebaseAuth;

  AuthenticationProvider(_firebaseAuth) {
    // TODO: implement AuthenticationProvider
    throw UnimplementedError();
  }

  Stream<User?> get authStateChanges => _firebaseAuth!.authStateChanges();

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

//   Future<User?> loginWithApple() async {
//     print('loginWithApple');
//     FirebaseAuth.instance.signOut().then((value) async {
//       // To prevent replay attacks with the credential returned from Apple, we
//       // include a nonce in the credential request. When signing in in with
//       // Firebase, the nonce in the id token returned by Apple, is expected to
//       // match the sha256 hash of `rawNonce`.
//       final rawNonce = generateNonce();
//       final nonce = sha256ofString(rawNonce);
//       try {
//         // Request credential for the currently signed in Apple account.
//         final appleCredential = await SignInWithApple.getAppleIDCredential(
//           scopes: [
//             AppleIDAuthorizationScopes.email,
//             AppleIDAuthorizationScopes.fullName,
//           ],
//           nonce: nonce,
//         );
//         if (kDebugMode) {
//           print('kDebugMode: ' + appleCredential.authorizationCode);
//         }
//         // Create an `OAuthCredential` from the credential returned by Apple.
//         final oauthCredential = OAuthProvider("apple.com").credential(
//           idToken: appleCredential.identityToken,
//           rawNonce: rawNonce,
//         );
//         // Sign in the user with Firebase. If the nonce we generated earlier does
//         // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//         final authResult = await _auth.signInWithCredential(oauthCredential);
//         final displayName =
//             '${appleCredential.givenName} ${appleCredential.familyName}';
//         print('userEmail: ${_auth.currentUser?.email ?? ''}');
//         print('displayName: ${_auth.currentUser?.displayName ?? ''}');
//         print('givenName: ${appleCredential.givenName ?? ''}');
//         print('familyName: ${appleCredential.familyName ?? ''}');
//         final fixDisplayNameFromApple = [
//           appleCredential.givenName ?? 'Guest',
//           appleCredential.familyName ?? '',
//         ].join(' ').trim();
// // ... once the authentication is complete
//         if (fixDisplayNameFromApple != null &&
//             _auth.currentUser?.displayName == null) {
//           await _auth.currentUser?.updateDisplayName(fixDisplayNameFromApple);
//           _auth.currentUser?.reload();
//         }
//         userSocialLogin(
//             firstName: appleCredential.givenName ?? 'Guest',
//             lastName: appleCredential.familyName ?? ' -',
//             socialType: '4',
//             email: _auth.currentUser?.email ?? '',
//             phone: '');
//         return null;
//       } catch (exception) {
//         print('exception ');
//         print(exception);
//       }
//       return null;
//     });
//     return null;
//   }

  // Login with Facebook

  final FacebookAuth _facebookAuth = FacebookAuth.i;

  Future<void> loginWithFacebook(BuildContext context) async {
    debugPrint('----------------loginWithFacebook ----------');
    isLoadingFacebook(true);
    final result = await _facebookAuth.login();
    if (result.status == LoginStatus.success) {
      // final user = await _getFacebookUser;

      // if (user != null) {
      if (await _facebookAuth.accessToken != null) {
        final userData = await _facebookAuth.getUserData();
        debugPrint('Facebook Data: ${userData}');
        if (userData.isNotEmpty) {
          // final user = SocialLoginUserData(
          //   userId: userData['id'],
          //   name: userData['name'],
          //   email: userData['email'],
          //   profilePicture: userData['picture']?['data']?['url'],
          // );
          // return user;
        }

        // }
        // _updateFacebookUser(user);
      }
    } else {
      appToastView(title: result.status.name);
    }

    isLoadingFacebook(false);
  }

  Future<void> logOutFromFacebook() {
    return _facebookAuth.logOut();
  }

//////////////////////////set user data on firebase
  setUserDataOnFireBase({
    String subscriptionType = '',
    String loginType = '',
    String username = '',
    String email = '',
    String password = '',
  }) async {
    try {
      isLoading(true);
      var user = FirebaseAuth.instance.currentUser;
      final prefs = await SharedPreferences.getInstance();
      var userData;
      if (loginType == 'simple') {
        userData = UserModel(
          userId: FirebaseAuth.instance.currentUser!.uid,
          userName: username,
          profilePicture: '',
          userEmail: email,
          subscriptionDate: DateTime.now().toString(),
          subscriptionType: subscriptionType,
          createdAt: DateTime.now().toString(),
          loginType: loginType,
          password: password,
        );
      } else {
        userData = UserModel(
          userId: FirebaseAuth.instance.currentUser!.uid,
          userName: user!.displayName!,
          profilePicture: user.photoURL,
          userEmail: user.email.toString(),
          subscriptionDate: DateTime.now().toString(),
          subscriptionType: subscriptionType,
          createdAt: DateTime.now().toString(),
          loginType: loginType,
          password: '',
        );
      }
      // ignore: unrelated_type_equality_checks
      if (prefs.getString(AppConstants.isLogin) == 'true') {
        Get.toNamed(Routes.homeView);
      } else {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(userData.toJson())
            .then((value) => {
                  if (loginType == 'simple')
                    {
                      Get.toNamed(Routes.questionView, arguments: {
                        'subscriptionType': subscriptionType,
                        'loginType': loginType
                      }),
                    },
                  prefs.setString(AppConstants.isLogin, 'true'),
                });
        isLoading(false);
      }
    } catch (e) {}

    // } else {
    // prefs.setString(AppConstants.isLogin, 'true');
    // Get.toNamed(Routes.homeView);
    // }
  }

  updateSubscription({String? type}) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'subscriptionDate': DateTime.now().toString(),
      'subscriptionType': type,
    }).then((value) {
      getUserData();
      Get.toNamed(Routes.homeView);
    });
  }

//////////////////////
  var userName = ''.obs;
  var userEmail = ''.obs;
  var createdAt = ''.obs;
  var userId = ''.obs;
  var profilePicture = ''.obs;
  var loginType = ''.obs;
  var subscriptionDate = ''.obs;
  var subscriptionType = ''.obs;

  getUserData() async {
    try {
      isLoading(true);
      print('isLoading $isLoading');

      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get()
          .then((value) {
        userName.value = value.data()!["userName"];
        userEmail.value = value.data()!["userEmail"];
        userId.value = value.data()!["userId"];
        profilePicture.value = value.data()!["profilePicture"];
        loginType.value = value.data()!["loginType"];
        subscriptionDate.value = value.data()!["subscriptionDate"];
        subscriptionType.value = value.data()!["subscriptionType"];
        createdAt.value = value.data()!["createdAt"];
        print('subscriptionDate.value ${subscriptionDate.value}');
        // print('${}');
        isLoading(false);
        update();
      });
    } catch (e) {
      print(e.toString());
    }
  }
////////
}
