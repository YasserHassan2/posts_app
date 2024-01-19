import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/presentation/home/home_view.dart';
import 'package:posts_app/utils/resources/strings_manager.dart';

import '../../app/di.dart';
import '../../presentation/main/view/main_view.dart';

class Routes {
  static const String mainRoute = "/main";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.homeRoute:
        initMainModule();
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound.tr()),
              ),
              body: Center(child: Text(AppStrings.noRouteFound.tr())),
            ));
  }
}
