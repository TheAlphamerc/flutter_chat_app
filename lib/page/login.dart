import 'package:flutter/material.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:flutter_chat_app/theme/extentions.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: fullHeight(context),
        width: fullHeight(context),
        alignment: Alignment.center,
        color: Theme.of(context).backgroundColor,
        child: MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Provider.of<AuthState>(context,listen: false).loginViaGoogle();
          },
          child: Text("Google Login",style: TextStyles.title.white,),
        ),
      ),
    );
  }
}
