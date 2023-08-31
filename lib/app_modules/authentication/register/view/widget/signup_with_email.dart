import '../../../../../utils/app_imports/app_imports.dart';

class SignUpWithEmail extends StatefulWidget {
  SocialAuthController socialAuthController;
  SignUpWithEmail({super.key, required this.socialAuthController});

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmwordController = TextEditingController();
  @override
  void initState() {
    widget.socialAuthController.setIsPassObscure = true;
    widget.socialAuthController.setIsConfirmPassObscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: usernameController,
          hint: 'username'.tr,
        ),
        vSizedBox(),
        AppTextField(
          controller: emailController,
          hint: 'email'.tr,
        ),
        vSizedBox(),
        Obx(() => AppTextField(
              controller: passwordController,
              hint: 'password'.tr,
              obscureText: widget.socialAuthController.getIsPassObscure,
              isSuffix: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  widget.socialAuthController.setIsPassObscure =
                      widget.socialAuthController.getIsPassObscure
                          ? false
                          : true;
                },
                child: Icon(
                  !widget.socialAuthController.getIsPassObscure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.WHITE_COLOR,
                ),
              ),
            )),
        vSizedBox(),
        Obx(() => AppTextField(
              controller: confirmwordController,
              hint: 'confirmPassword'.tr,
              obscureText: widget.socialAuthController.getIsConfirmPassObscure,
              isSuffix: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  widget.socialAuthController.setIsConfirmPassObscure =
                      widget.socialAuthController.getIsConfirmPassObscure
                          ? false
                          : true;
                },
                child: Icon(
                  !widget.socialAuthController.getIsConfirmPassObscure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.WHITE_COLOR,
                ),
              ),
            )),
        vSizedBox(height: Get.height * 0.05),
        AppButton(
            buttonWidth: Get.width,
            buttonName: 'signUp'.tr,
            buttonColor: AppColors.PRIMARY_COLOR,
            textColor: AppColors.WHITE_COLOR,
            onTap: () {
              registerWithEmail();
            }),
        vSizedBox(height: Get.height * 0.04),
      ],
    );
    ;
  }

  registerWithEmail() {
    if (emailController.text == '' ||
        passwordController.text == '' ||
        usernameController.text == '' ||
        confirmwordController.text == '') {
      customSnackBar(title: "prequalified".tr);
    } else {
      if (!GetUtils.isEmail(emailController.text)) {
        customSnackBar(title: "emailNotValid".tr);
      } else {
        if (passwordController.text != confirmwordController.text) {
          customSnackBar(title: "passwordShouldSame".tr);
        } else {
          _signUp();
        }
      }
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);

      // If signInMethods is not empty, it means the email is already registered
      return signInMethods.isNotEmpty;
    } catch (e) {
      print('Failed to check email registration: $e');
      // Show an error message or handle the error
      return false;
    }
  }

  Future<void> _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (await isEmailRegistered(email)) {
      customSnackBar(title: 'emailAlready'.tr);

      // Show an error message or handle accordingly
    } else {
      try {
        await signUpWithEmailAndPassword(email, password);
        // Navigate to another screen or perform additional actions after successful sign-up
      } catch (e) {
        print('Failed to sign up: $e');
        // Show an error message or handle the error
      }
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User successfully signed up
      User? user = userCredential.user;
      widget.socialAuthController.setUserDataOnFireBase(
        subscriptionType: SubscriptionType.free.name.toString(),
        loginType: LoginType.simple.name.toString(),
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      usernameController.text = '';
      passwordController.text = '';
      confirmwordController.text = '';
      emailController.text = '';
      print('Signed up: ${user!.uid}');

      // Perform additional actions after successful sign-up
    } catch (e) {
      print('Failed to sign up: $e');
      // Show an error message or handle the error
    }
  }
}
