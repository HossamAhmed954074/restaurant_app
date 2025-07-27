import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';

import 'package:resturant_app/features/auth/view/widgets/auth_button_custom.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';

class RessetPassord extends StatefulWidget {
  const RessetPassord({super.key});

  @override
  State<RessetPassord> createState() => _RessetPassordState();
}

class _RessetPassordState extends State<RessetPassord> {
  final TextEditingController _emailController = TextEditingController();

  resetPassowrd() async {
    BlocProvider.of<AuthCubit>(
      context,
    ).resetPassword(email: _emailController.text);
  }

  @override
  void dispose() {

    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showSnakBarSuccess(
            context,
            'Check Your Email & Spam Emails to Resset Password',
          );
        }
        if (state is AuthFailure) {
         showSnakBarFaluire(context, state.message.userFriendlyMessage);
          // showSnakBarFaluire(context, state.message.failure());
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextFieldCustomWidget(
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  SizedBox(height: 15),

                  SizedBox(height: 20),
                  AuthButtonCustomWidget(
                    text: 'resset',
                    onPressed: () {
                      resetPassowrd();
                    },
                  ),
                ],
              ),
            ),
            if (state is AuthLoading) circleIndeactorCustom(context),
          ],
        );
      },
    );
  }
}
