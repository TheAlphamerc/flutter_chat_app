import 'package:flutter_chat_app/service/auth_service.dart';
import 'package:get_it/get_it.dart';
GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerSingleton(AuthService());
}
