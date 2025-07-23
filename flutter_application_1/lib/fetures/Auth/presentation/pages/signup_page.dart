import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/pages/login_page.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/auth_field.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/richtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical:height*0.2 ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthSucess){
                  Navigator.push(context,MaterialPageRoute(builder: (_)=>const LoginPage()));
              }
            
            },
            builder: (context, state) {
              if(state is AuthFailure){
                return AlertDialog(
                  shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
                  backgroundColor: Colors.red,
                  titlePadding: const EdgeInsets.all(20),
                  title: Text(state.message),);
              }
              if(state is AuthLoading){
                return const Center(child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ));
              }
              return Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up.",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(
                      hintext: "email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintext: "name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintext: "password",
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthGradientButton(
                      buttonText: "sign up",
                      onpressed: () {
                        log("onpressed");
                        if (_form.currentState!.validate()) {
                          log("in formfield");
                          context.read<AuthBloc>().add(
                                AuthSignUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        child: const RichTexts(text: "signin")),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
