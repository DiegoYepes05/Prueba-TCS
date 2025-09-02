import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_event.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_state.dart';

class CustomFilledButtom extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLogin;

  const CustomFilledButtom({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(10);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green[200],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: radius,
                  bottomRight: radius,
                  topLeft: radius,
                ),
              ),
            ),
            onPressed: state is AuthLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        isLogin
                            ? AuthLoginRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              )
                            : AuthRegisterRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              ),
                      );
                    }
                  },
            child: state is AuthLoading
                ? CircularProgressIndicator(color: Colors.green[200])
                : Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
          ),
        );
      },
    );
  }
}
