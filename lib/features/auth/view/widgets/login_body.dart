import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/features/auth/view/widgets/auth_button_custom.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key, this.onSwitchToResetPassword});

  final VoidCallback? onSwitchToResetPassword;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _isFormValid = false;

  @override
  bool get wantKeepAlive => true; // Keep state when switching tabs

  @override
  void initState() {
    super.initState();
    _setupFormValidation();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _setupFormValidation() {
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _emailController.text.contains('@') &&
        _passwordController.text.length >= 6;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // Hide keyboard
      FocusScope.of(context).unfocus();

      context.read<AuthCubit>().logIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _isFormValid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          _clearForm();
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return _buildLoginForm(isLoading);
        },
      ),
    );
  }

  Widget _buildLoginForm(bool isLoading) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),

            // Welcome back text
            _buildWelcomeText(),
            const SizedBox(height: 32),

            // Email field
            TextFieldCustomWidget(
              hintText: 'Email',
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              enabled: !isLoading,
            ),
            const SizedBox(height: 20),

            // Password field
            TextFieldCustomWidget(
              hintText: 'Password',
              controller: _passwordController,
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // Remember me checkbox
            _buildRememberMe(isLoading),
            const SizedBox(height: 24),

            // Login button
            AuthButtonCustomWidget(
              text: 'Sign In',
              onPressed: (_isFormValid && !isLoading) ? _handleLogin : null,
              isLoading: isLoading,
            ),
            const SizedBox(height: 16),

            // Forgot password link
            _buildForgotPasswordLink(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Please sign in to your account',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRememberMe(bool isLoading) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: _rememberMe,
            onChanged: isLoading
                ? null
                : (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return _rememberMe ? Colors.white : Colors.transparent;
            }),
            checkColor: Colors.black87,
            side: BorderSide(color: Colors.white.withValues(alpha: 0.7), width: 1.5),
          ),
        ),
        Text(
          'Remember me',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink(bool isLoading) {
    return TextButton(
      onPressed: isLoading
          ? null
          : () {
              // Switch to reset password tab
              widget.onSwitchToResetPassword?.call();
            },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: isLoading ? Colors.grey : Colors.white.withValues(alpha: 0.9),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
