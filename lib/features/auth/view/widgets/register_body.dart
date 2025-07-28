import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/features/auth/view/widgets/auth_button_custom.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key, this.onSwitchToLogin});

  final VoidCallback? onSwitchToLogin;

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _acceptTerms = false;
  bool _isFormValid = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _setupFormValidation();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _setupFormValidation() {
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        _nameController.text.trim().length >= 2 &&
        _emailController.text.trim().isNotEmpty &&
        _emailController.text.contains('@') &&
        _passwordController.text.length >= 6 &&
        _confirmPasswordController.text == _passwordController.text &&
        _acceptTerms;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      // Hide keyboard
      FocusScope.of(context).unfocus();

      context.read<AuthCubit>().register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
      );
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      _isFormValid = false;
      _acceptTerms = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _clearForm();
          // Switch to login tab after successful registration
          widget.onSwitchToLogin?.call();
        } else if (state is AuthFailure) {
          // Don't clear form on failure, let user correct the error
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return _buildRegisterForm(isLoading);
        },
      ),
    );
  }

  Widget _buildRegisterForm(bool isLoading) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),

            // Welcome text
            _buildWelcomeText(),
            const SizedBox(height: 24),

            // Name field
            TextFieldCustomWidget(
              hintText: 'Full Name',
              controller: _nameController,
              prefixIcon: Icons.person_outline,
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // Email field
            TextFieldCustomWidget(
              hintText: 'Email',
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // Password field
            TextFieldCustomWidget(
              hintText: 'Password',
              controller: _passwordController,
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // Confirm Password field
            TextFieldCustomWidget(
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Terms and conditions
            _buildTermsCheckbox(isLoading),
            const SizedBox(height: 24),

            // Register button
            AuthButtonCustomWidget(
              text: 'Create Account',
              onPressed: (_isFormValid && !isLoading) ? _handleRegister : null,
              isLoading: isLoading,
              backgroundColor: const Color(0xFF2ECC71),
            ),
            const SizedBox(height: 16),

            // Login link
            _buildLoginLink(isLoading),
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
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Join us and start your journey',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(bool isLoading) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: isLoading
                ? null
                : (value) {
                    setState(() {
                      _acceptTerms = value ?? false;
                      _validateForm();
                    });
                  },
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return _acceptTerms ? Colors.white : Colors.transparent;
            }),
            checkColor: Colors.black87,
            side: BorderSide(color: Colors.white.withValues(alpha: 0.7), width: 1.5),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: isLoading
                ? null
                : () {
                    // Switch to login tab
                    widget.onSwitchToLogin?.call();
                  },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign In',
              style: TextStyle(
                color: isLoading ? Colors.grey : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
