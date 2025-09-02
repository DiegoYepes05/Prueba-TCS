import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/config/helpers/validators.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prueba_tcs/features/auth/presentation/bloc/auth_state.dart';
import 'package:prueba_tcs/features/auth/presentation/widgets/custom_filled_buttom.dart';
import 'package:prueba_tcs/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:prueba_tcs/features/auth/presentation/widgets/register_link.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

                    const Icon(
                      Icons.person_add_outlined,
                      color: Colors.white,
                      size: 100,
                    ),
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
                      child: _RegisterForm(
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        obscurePassword: _obscurePassword,
                        obscureConfirmPassword: _obscureConfirmPassword,
                        togglePassword: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        toggleConfirmPassword: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
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

class _RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback togglePassword;
  final VoidCallback toggleConfirmPassword;

  const _RegisterForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.togglePassword,
    required this.toggleConfirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),

            Text(
              'Registrarse',
              style: textStyles.titleLarge?.copyWith(
                color: Colors.green[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 90),

            CustomTextFormField(
              prefixIcon: const Icon(Icons.email),
              label: 'Correo electrónico',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            const SizedBox(height: 30),

            CustomTextFormField(
              label: 'Contraseña',
              controller: passwordController,
              obscureText: obscurePassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: togglePassword,
              ),
              validator: Validators.validatePassword,
            ),
            const SizedBox(height: 30),

            CustomTextFormField(
              label: 'Confirmar Contraseña',
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: toggleConfirmPassword,
              ),
              validator: Validators.validatePassword,
            ),
            const SizedBox(height: 30),

            CustomFilledButtom(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
              isLogin: false,
            ),

            const Spacer(flex: 2),

            RegisterLink(
              route: '/login',
              text: '¿Ya tienes cuenta? ',
              secondaryText: 'INICIA SESIÓN',
              onPressed: () => context.pop(),
            ),

            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
