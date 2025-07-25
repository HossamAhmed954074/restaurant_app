import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';


class AlertDialogCustomWidget extends StatefulWidget {
  const AlertDialogCustomWidget({super.key});

  @override
  State<AlertDialogCustomWidget> createState() =>
      _AlertDialogCustomWidgetState();
}

class _AlertDialogCustomWidgetState extends State<AlertDialogCustomWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  resetPasswordWithEmail() {
    BlocProvider.of<ProfileCubit>(context).resetPasswordWithEmail(
      email: _emailController.text,
      currentPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileReSetPassowrdFailure) {
          showSnakBarFaluire(context, state.message.message);
        }
        if (state is ProfileResetPassowrdSuccess) {
          showSnakBarSuccess(context, 'Password changed successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AlertDialog(
              backgroundColor: Colors.blueAccent,
              title: Text(
                'Change Password',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldCustomWidget(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    SizedBox(height: 10),
                    TextFieldCustomWidget(
                      controller: _oldPasswordController,
                      hintText: 'Old Password',
                    ),
                    SizedBox(height: 10),
                    TextFieldCustomWidget(
                      controller: _newPasswordController,
                      hintText: 'New Password',
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                               resetPasswordWithEmail();
                            }

                           
                          },
                          child: Text('Change'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
             if (state is ProfileReSetPassowrdLoading)
                circleIndeactorCustom(context),
          ],
        );
      },
    );
  }
}
