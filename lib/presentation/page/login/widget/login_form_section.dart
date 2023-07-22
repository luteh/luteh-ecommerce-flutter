import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extention/context_extention.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../core/style/sizes.dart';
import '../../../core/widget/rounded_text_field.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.flutter_dash_rounded,
          size: Sizes.width100,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(height: Sizes.height32),
        RoundedTextField(
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(LoginEvent.usernameTextChanged(value));
          },
          labelText: context.localization.username,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: Sizes.height16),
        RoundedTextField(
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(LoginEvent.passwordTextChanged(value));
          },
          labelText: context.localization.password,
          isPasswordField: true,
        ),
      ],
    );
  }
}
