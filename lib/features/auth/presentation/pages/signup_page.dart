import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/widgets/loader.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_field.dart';
import 'login_page.dart';
import '../bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSignUpSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                LoginPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign Up.',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: KSizes.xl),
                  AuthField(
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: KSizes.md),
                  AuthField(
                    labelText: 'Password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: KSizes.md),
                  AuthButton(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: KSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, SignUpPage.route());
                          },
                          child: const Text('Sign In')),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
