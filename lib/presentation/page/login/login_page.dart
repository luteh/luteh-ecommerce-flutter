import 'package:flutter/material.dart';

import '../../core/style/sizes.dart';
import '../../core/widget/my_scaffold.dart';
import 'widget/login_footer.dart';
import 'widget/login_form_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.all(Sizes.width20),
                  child: Column(
                    children: [
                      const Expanded(
                        child: LoginFormSection(),
                      ),
                      SizedBox(height: Sizes.height32),
                      const LoginFooter(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
