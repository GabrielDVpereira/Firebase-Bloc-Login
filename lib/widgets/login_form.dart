import 'package:bloc_firebase/cubit/login/login_cubit.dart';
import 'package:bloc_firebase/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  void _showErrorSnackBar(String? message, BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message ?? 'Something went wrong')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (loginContext, loginState) {
        if (loginState.status.isSubmissionFailure) {
          _showErrorSnackBar(loginState.errorMessage, context);
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),
              const SizedBox(height: 16),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              _LoginButton(),
              const SizedBox(height: 8),
              _GoogleLoginButton(),
              const SizedBox(height: 4),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prevState, currentState) =>
          prevState.email != currentState.email,
      builder: (context, state) => TextField(
        key: const Key('loginForm_emailInput_textField'),
        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
          helperText: '',
          errorText: state.email.invalid ? 'invalid email' : null,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prevState, currentState) =>
          prevState.password != currentState.password,
      builder: (context, state) => TextField(
        key: const Key('loginForm_emailInput_textField'),
        onChanged: (password) =>
            context.read<LoginCubit>().emailChanged(password),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          helperText: '',
          errorText: state.email.invalid ? 'invalid password' : null,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state.status.isSubmissionInProgress) {
        return const CircularProgressIndicator();
      }

      return ElevatedButton(
        key: const Key('loginForm_continue_raisedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: const Color(0xFFFFD600),
        ),
        onPressed: state.status.isValidated
            ? () => context.read<LoginCubit>().loginWithCredentials()
            : null,
        child: const Text('LOGIN'),
      );
    });
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: theme.colorScheme.secondary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
