import 'package:flutter/material.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:flutter_chat_app/theme/extentions.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context, listen: false);
    final user = state.userModel;
    return SafeArea(
      top: false,
      child: Container(
        padding: MediaQuery.of(context).viewPadding,
        height: fullHeight(context),
        width: fullHeight(context),
        alignment: Alignment.center,
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userAvatar(state.userModel).p16,
            Text(
              user.displayName,
              style: TextStyles.title,
            ),
            Text(
              user.userName ?? "",
              style: TextStyles.title,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Provider.of<AuthState>(context, listen: false).logout();
              },
              child: Text(
                "Log out",
                style: TextStyles.title.white,
              ),
            ).p(16),
          ],
        ),
      ),
    );
  }
}
