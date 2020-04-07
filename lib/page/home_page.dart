import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:flutter_chat_app/widgets/bottomMenuBar.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app/theme/extentions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _appBar() {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Chats',
            style: TextStyles.title,
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }

  Widget _favouriteList() {
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

  

  Widget _userList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _userTile();
      },
      itemCount: 100,
    );
  }

  Widget _userTile() {
    return ListTile(
      leading: userAvatar(null),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "John",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _appBar(),
            _favouriteList(),
            _userList().extended,
          ],
        ),
      ),
    );
  }
}
