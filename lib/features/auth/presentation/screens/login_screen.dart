import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/config/helpers/validators.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_state.dart';
import 'package:prueba_tcs/features/auth/presentation/widgets/widgets.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color scaffoldBackgroundColor = Theme.of(
      context,
    ).scaffoldBackgroundColor;

    return BlocProvider<AuthBloc>(
      create: (BuildContext context) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Container(
              height: size.height,
              width: double.infinity,
              color: Colors.green[200],
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 80),

                    const Icon(Icons.lock, color: Colors.white, size: 100),
                    const SizedBox(height: 80),

                    Container(
                      height: size.height - 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),

                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      child: _LoginForm(
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Text(
              'Inicia Sesión',
              style: TextStyle(
                color: Colors.green[200],
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 90),
            CustomTextFormField(
              label: 'Correo electrónico',
              controller: emailController,
              prefixIcon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              label: 'Contraseña',
              controller: passwordController,
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
              validator: Validators.validatePassword,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomFilledButtom(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
            ),

            const Spacer(flex: 2),

            RegisterLink(
              route: '/register',
              text: '¿No tienes cuenta? ',
              secondaryText: 'REGISTRATE',
              onPressed: () => context.push('/register'),
            ),

            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
