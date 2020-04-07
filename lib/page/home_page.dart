import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app/theme/extentions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _login() {
    var state = Provider.of<AuthState>(context, listen: false);
    state.loginViaGoogle();
  }

  Widget _appBar() {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Chat',
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
          child: Text('Favourites', style: TextStyles.bodySm.bold,),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _avatar(null).p(8);
            },
            itemCount: 25,
          ),
        ),
        SizedBox(height: 16,),
        Divider(
          height: 0,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }

  Widget _avatar(User user) {
    user = User(
      profilePic:
          'http://www.azembelani.co.za/wp-content/uploads/2016/07/20161014_58006bf6e7079-3.png',
    );
    return CircleAvatar(radius: 30, child: Image.network(user.profilePic));
  }

  Widget _userList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _userTile();
      },
      itemCount: 100,
    );
  }
  Widget _userTile(){
    return ListTile(
          leading: _avatar(null),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: <Widget>[
              Text(
                "John",
                style: TextStyles.titleFont.white,
              ),
              Text('1:04am', style: TextStyles.bodySm.lighGrey,)
            ],
          ),
          subtitle: Text(description("Is it possible to create an “extension methods” for the Widgets? Is it possible to create an “extension methods” for the Widgets?"), style: TextStyles.bodySm.dimWhite),
        ).vP4;
  }
  String description(String msg){
    if(msg.isNotEmpty && msg.length > 50){
      return msg.substring(0,38) + "...";
    }
    else if(msg.isNotEmpty){
      return msg;
    }
    else{
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
