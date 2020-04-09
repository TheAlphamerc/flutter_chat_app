import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/enum.dart';
import 'package:flutter_chat_app/page/login.dart';
import 'package:flutter_chat_app/page/welcomPage.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Provider.of<AuthState>(context,listen: false).loginStatus,
        builder: (context, AsyncSnapshot<AuthStatus> snapshot) {
          if(snapshot.data == AuthStatus.NOT_LOGGED_IN || snapshot.data == AuthStatus.NOT_DETERMINED){
            return LoginPage();
          }
          return WelcomePage();
        },
      ),
    );
  }
}