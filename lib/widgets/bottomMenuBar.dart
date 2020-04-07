// import 'package:fancy_bottom_navigation/internal/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/state/app_state.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:provider/provider.dart';
// import 'customBottomNavigationBar.dart';

class BottomMenubar extends StatefulWidget {
  _BottomMenubarState createState() => _BottomMenubarState();
}

class _BottomMenubarState extends State<BottomMenubar> {
  @override
  void initState() {
    super.initState();
  }

  Widget _iconRow() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, -.1), blurRadius: 0)
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _icon(Icons.home, 0),
          _icon(Icons.message, 1),
          _icon(Icons.people, 3),
          _icon(Icons.settings, 4),
        ],
      ),
    );
  }

  Widget _icon(IconData iconData, int index) {
    var state = Provider.of<AppState>(context,listen:false);

    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: AnimatedAlign(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          alignment: Alignment(0, 0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: 1,
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              alignment: Alignment(0, 0),
              icon: StreamBuilder(
                stream: state.pageIndex,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Icon(iconData,
                      color: index == snapshot.data
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).bottomAppBarTheme.color);
                },
              ),
              onPressed: () {
                state.setpageIndex = index;
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iconRow();
  }
}
