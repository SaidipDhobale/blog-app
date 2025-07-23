
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import 'package:flutter_application_1/fetures/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/pages/signup_page.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/alert_dialogue.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/auth_field.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/myiconbutton.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/richtext.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/blog_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSucess || state is GoogleSignInSucess) {
            
            Navigator.push(
                context, MaterialPageRoute(builder: (_) =>const MyBlog()));
          }
        },
        builder: (context, state) {
          if (state is AuthFailure) {
            return CustomAlertDialog(
                title: state.message,
                message: "take suitable action",
                confirmText: "cancel",
                onConfirm: () {
                  context.read<AuthBloc>().add(AuthReset());
                  Navigator.popUntil(context, (route) => route.isFirst);
                  //Navigator.push(context,MaterialPageRoute(builder:(_)=>const SignUpPage()));
                });
          }
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SignIn.",
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
                  hintext: "password",
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthGradientButton(
                  buttonText: "sign in",
                  onpressed: () {
                    context.read<AuthBloc>().add(AuthSignIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));

                    emailController.clear();
                    passwordController.clear();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()));
                  },
                  child: const RichTexts(text: "signup"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyIconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthSignInGoogleEvent());
                      },
                      imageurl: 'assets/google_logo.png',
                    ),
                    MyIconButton(
                      onPressed: () {},
                      imageurl: "assets/facebook.jpg",
                    ),
                     MyIconButton(
                      onPressed: () {},
                      imageurl: "assets/twitter.png",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
