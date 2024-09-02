import 'package:blog_nest/core/common/widgets/loader.dart';
import 'package:blog_nest/core/common/widgets/snackbar.dart';
import 'package:blog_nest/core/theme/app_pallete.dart';
import 'package:blog_nest/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_nest/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_nest/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_nest/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  static const routeName = '/signin-page';
  @override
  State<SigninPage> createState() => _StateSigninPage();
}

class _StateSigninPage extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthFailure) {
              if (state.message == 'User not logged in') {
                return;
              }
              showSnackBar(context, state.message);
            }
          }, builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(controller: _emailController, hintText: 'Email'),
                  const SizedBox(height: 15),
                  AuthField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isObscureText: _isObscure,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  AuthGradientButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignIn(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      },
                      buttonText: 'Sign In'),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        GoRouter.of(context).pushNamed(SignupPage.routeName),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        )),
      ),
    );
  }
}
