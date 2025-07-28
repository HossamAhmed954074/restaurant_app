import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/features/auth/view/widgets/auth_button_custom.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';

class RessetPassord extends StatefulWidget {
  const RessetPassord({super.key, this.onBackToLogin});

  final VoidCallback? onBackToLogin;

  @override
  State<RessetPassord> createState() => _RessetPassordState();
}

class _RessetPassordState extends State<RessetPassord>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isFormValid = false;
  bool _emailSent = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid =
        _emailController.text.trim().isNotEmpty &&
        _emailController.text.contains('@');

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // Hide keyboard
      FocusScope.of(context).unfocus();

      context.read<AuthCubit>().resetPassword(
        email: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() {
            _emailSent = true;
          });
          // Switch to login tab after 3 seconds
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              widget.onBackToLogin?.call();
            }
          });
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return _buildResetForm(isLoading);
        },
      ),
    );
  }

  Widget _buildResetForm(bool isLoading) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Header text
            _buildHeaderText(),
            const SizedBox(height: 32),

            if (_emailSent) ...[
              // Success message
              _buildSuccessMessage(),
            ] else ...[
              // Email field
              TextFieldCustomWidget(
                hintText: 'Email',
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),

              // Reset button
              AuthButtonCustomWidget(
                text: 'Reset Password',
                onPressed: (_isFormValid && !isLoading)
                    ? _handleResetPassword
                    : null,
                isLoading: isLoading,
                backgroundColor: const Color(0xFFE74C3C),
              ),
              const SizedBox(height: 16),

              // Back to login link
              _buildBackToLoginLink(isLoading),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _emailSent ? 'Check Your Email' : 'Reset Password',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _emailSent
              ? 'We\'ve sent password reset instructions to your email'
              : 'Enter your email and we\'ll send you reset instructions',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(
            Icons.mark_email_read_outlined,
            color: Colors.green.shade300,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Email Sent Successfully!',
            style: TextStyle(
              color: Colors.green.shade300,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your email and spam folder for password reset instructions.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Redirecting to login in 3 seconds...',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackToLoginLink(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Remember your password? ',
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
                    widget.onBackToLogin?.call();
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
