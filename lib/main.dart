import 'package:flutter/material.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/state/app_state.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/state/chat_state.dart';
import 'package:flutter_chat_app/theme/theme.dart';
import 'package:provider/provider.dart';

import 'helper/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<ChatState>(create: (_) => ChatState()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          routes: Routes.route(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        ),
    );
  }
}
