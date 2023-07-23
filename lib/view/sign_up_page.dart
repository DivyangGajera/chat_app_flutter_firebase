// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:chat_app_flutter_firebase/controller/firebase_auth_helper.dart';
import 'package:chat_app_flutter_firebase/utilities/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../utilities/sign_up_page_variables.dart';

class SignUp extends StatelessWidget {
  List<User> ls;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  bool canSignUp = false;

  SignUp({super.key, required this.ls});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupPageVariables(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text(signUpTitle),
        ),
        body: Consumer<SignupPageVariables>(
          builder: (context, value, child) {
            if (!value.isLoading) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 220,
                        child: Icon(
                          Icons.account_circle,
                          size: 200,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            value.errorString,
                            style: errorStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: fullnameController,
                        style: const TextStyle(fontSize: 20),
                        textInputAction: TextInputAction.next,
                        onTap: () => value.updateFNameErrorString = false,
                        onChanged: (val) {
                          value.updateFNameErrorString =
                              val.isEmpty ? false : true;
                        },
                        decoration:
                            const InputDecoration(labelText: "Full Name : "),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 20),
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          value.updateEmailErrorString =
                              EmailValidator.validate(val);
                        },
                        decoration:
                            const InputDecoration(labelText: "Email : "),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (temp) =>
                            value.changePasswordValidationVisiblity,
                        controller: passwordController,
                        obscureText: value.isSignupPassVisible,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Password : ",
                          suffixIcon: GestureDetector(
                              onTap: () {
                                value.changeSignupPassVisibility =
                                    !value.isSignupPassVisible;
                              },
                              child: Icon(
                                value.isSignupPassVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 25,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: value.isPasswordValidationVisible,
                        child: FlutterPwValidator(
                          successColor: Colors.green,
                          failureColor: Colors.red,
                          width: MediaQuery.sizeOf(context).width - 20,
                          height: 150,
                          minLength: 8,
                          onSuccess: () => canSignUp = true,
                          controller: passwordController,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Visibility(
                        visible: !value.isPasswordValidationVisible,
                        child: const SizedBox(
                          height: 100,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (value.errorString.isEmpty && canSignUp) {
                              value.changeLoadingState = true;
                              await FirebaseAuthHelper.signUp(
                                  context: context,
                                  email: emailController.text,
                                  fullName: fullnameController.text,
                                  password: passwordController.text);
                              emailController.clear();
                              passwordController.clear();
                              fullnameController.clear();
                              Future.delayed(const Duration(seconds: 2));
                              Navigator.pushReplacementNamed(
                                  context, '/sign_in');
                            } else {
                              value.changeLoadingState = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                      mesej:
                                          'Please fill every details properly',
                                      bgColor: Colors.red));
                            }
                          },
                          child: const Text(
                            "Sign Up Now",
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already a User ? ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, "/sign_in",
                                arguments: {'userData': ls}),
                            child: const Text(
                              "Sign in",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ),
                          const Text(
                            " Now ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
