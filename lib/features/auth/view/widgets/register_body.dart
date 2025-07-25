import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/auth/view/widgets/auth_button_custom.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
  }

  void _register() async {
    BlocProvider.of<AuthCubit>(context).register(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
    );
  }

  void clear() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        
        if(state is AuthSuccess){
          showSnakBarSuccess(context, 'Register Success');
          clear();
        }
         if(state is AuthFailure){
          showSnakBarFaluire(context, state.message.faliure());
        }
       
      },
      builder: (context, state) {
        return Stack(
          children: [

            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 
                    TextFieldCustomWidget(
                      hintText: 'Name',
                      controller: _nameController,
                    ),
            
                    SizedBox(height: 10),
                    TextFieldCustomWidget(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    SizedBox(height: 10),
                    TextFieldCustomWidget(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                    SizedBox(height: 20),
                    
                    AuthButtonCustomWidget(
                      text: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _register();
                          
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
           if(state is AuthLoading)
           circleIndeactorCustom(context),
          ],
        );
      },
    );
  }
}
