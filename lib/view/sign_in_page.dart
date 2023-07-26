// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/controller/firebase_auth_helper.dart';
import 'package:chat_app_flutter_firebase/utilities/sign_in_page_variables.dart';
import 'package:chat_app_flutter_firebase/utilities/titles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class SignIn extends StatelessWidget {
  List<User> ls;
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  SignIn({required this.ls, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SigninPageVariables(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text(signInTitle),
        ),
        body: Consumer<SigninPageVariables>(
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
                        height: 240,
                        child: Icon(
                          Icons.account_circle,
                          size: 200,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: Text(
                              value.errorString,
                              style: errorStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
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
                        height: 20,
                      ),
                      TextField(
                        onChanged: (temp) => value.updatePassErrorString =
                            temp.isEmpty ? false : true,
                        controller: passwordController,
                        obscureText: value.isSigninPassVisible,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Password : ",
                          suffixIcon: GestureDetector(
                              onTap: () {
                                value.changeSigninPassVisibility =
                                    !value.isSigninPassVisible;
                              },
                              child: Icon(
                                value.isSigninPassVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 25,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 180,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            value.changeLoadingState = true;
                            List loginInfo = await FirebaseAuthHelper.signIn(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text);

                            if (loginInfo[0]) {
                              Future.delayed(
                                const Duration(seconds: 1),
                                () => Navigator.pushReplacementNamed(
                                    context, "/chats",
                                    arguments: {'userData': ls}),
                              );
                            } else {
                              value.changeLoadingState = false;
                              value.setErrorString = loginInfo[1];
                            }
                          },
                          child: const Text(
                            "Sign In Now",
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New to App ? ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, "/sign_up",
                                arguments: {'userData': ls}),
                            child: const Text(
                              "Sign up",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ),
                           Text(
                            " Now ",
                            style: Theme.of(context).textTheme.bodyLarge,
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
