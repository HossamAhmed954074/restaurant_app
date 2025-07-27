import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';


class AlertDaialogCustomUpdateUserName extends StatefulWidget {
  const AlertDaialogCustomUpdateUserName({super.key});

  @override
  State<AlertDaialogCustomUpdateUserName> createState() =>
      _AlertDaialogCustomUpdateUserNameState();
}

class _AlertDaialogCustomUpdateUserNameState
    extends State<AlertDaialogCustomUpdateUserName> {
  final TextEditingController _userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _formKey.currentState?.dispose();
  }

  resetUserName() {
    BlocProvider.of<ProfileCubit>(
      context,
    ).resetUserName(newUserName: _userNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileResetUserNameFailure) {
          showSnakBarFaluire(context, state.message.userFriendlyMessage);
        }
        if (state is ProfileResetUserNameSuccess) {
          showSnakBarSuccess(context, 'Username updated successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AlertDialog(
              backgroundColor: Colors.blueAccent,
              title: Text(
                'Update username',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Form(
                key: _formKey,
                child: TextFieldCustomWidget(
                  controller: _userNameController,
                  hintText: 'user name',
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      resetUserName();
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
            if (state is ProfileResetUserNameLoading)
              circleIndeactorCustom(context),
          ],
        );
      },
    );
  }
}
