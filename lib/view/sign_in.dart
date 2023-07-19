// ignore_for_file: must_be_immutable

import 'package:chat_app_flutter_firebase/constants/sign_in_page_constants.dart';
import 'package:chat_app_flutter_firebase/constants/titles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();

  SignIn({super.key});

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
                      height: 35,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 20),
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        value.updateEmailErrorString =
                            EmailValidator.validate(val);
                      },
                      decoration: const InputDecoration(labelText: "Email : "),
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
                      height: 10,
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
                        onPressed: () {},
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
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
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
          },
        ),
      ),
    );
  }
}
