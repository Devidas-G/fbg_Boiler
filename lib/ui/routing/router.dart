import 'package:fbg/ui/routing/routes.dart';
import 'package:fbg/ui/views/homepage.dart';
import 'package:fbg/ui/views/root_p.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case root:
      return MaterialPageRoute(builder: (BuildContext context) {
        return const RootPage();
      });
    case home:
      return MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      });
  }
}
