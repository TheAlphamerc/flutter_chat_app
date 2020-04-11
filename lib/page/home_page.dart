import 'package:flutter/material.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/repository.dart';
import 'package:flutter_chat_app/state/app_state.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/state/chat_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:flutter_chat_app/widgets/bottomMenuBar.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app/theme/extentions.dart';

class HomePage extends StatelessWidget {
  Widget _appBar(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Chats'),
        ],
      ),
    );
  }

  Widget _favouriteList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Favourites',
            style: TextStyles.bodySm.bold,
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return userAvatar(null).p(8);
            },
            itemCount: 25,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(
          height: 0,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }

  Widget _userList(BuildContext context) {
    var myId = Provider.of<AuthState>(context).userModel.userId;
    return StreamBuilder(
      stream: Provider.of<AppState>(context).getAllUSerList(myId),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _userTile(context, snapshot.data[index]);
            },
            itemCount: snapshot.data.length,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Text("No Users Available");
        } else {
          return loader();
        }
      },
    );
  }

  Widget _userTile(BuildContext context, User model) {
    return ListTile(
      leading: userAvatar(model),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            model.displayName,
            style: TextStyles.titleMedium.white,
          ),
          Text(
            '1:04am',
            style: TextStyles.bodySm.lighGrey,
          )
        ],
      ),
      subtitle: Text(
          description(
              "Is it possible to create an “extension methods” for the Widgets? Is it possible to create an “extension methods” for the Widgets?"),
          style: TextStyles.bodySm.dimWhite),
    ).vP4.ripple(() {
      var state = Provider.of<AuthState>(context, listen: false);
      Provider.of<ChatState>(context, listen: false)
          .selectUserToChat(model, state.userModel.userId);
      Navigator.of(context).pushNamed('/ChatScreenPage');
    });
  }

  String description(String msg) {
    if (msg.isNotEmpty && msg.length > 50) {
      return msg.substring(0, 38) + "...";
    } else if (msg.isNotEmpty) {
      return msg;
    } else {
      return msg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: _appBar(context),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // _appBar(),
            _favouriteList(context),
            _userList(context).extended,
          ],
        ),
      ),
    );
  }
}
