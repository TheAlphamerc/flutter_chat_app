import 'package:flutter/material.dart';
import 'package:flutter_chat_app/page/home_page.dart';
import 'package:flutter_chat_app/page/profile_page.dart';
import 'package:flutter_chat_app/state/app_state.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/widgets/bottomMenuBar.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);
  void _login(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    state.loginViaGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenubar(),
      body: StreamBuilder(
        stream: Provider.of<AppState>(context).pageIndex,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return snapshot.data == 0 ? HomePage() :  snapshot.data == 2 ? ProfilePage() : HomePage();
        },
      ),
    );
  }
}
