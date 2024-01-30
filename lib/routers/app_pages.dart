import 'package:evalutation_zens/routers/app_routes.dart';
import 'package:evalutation_zens/screen/home/home_screen.dart';
import 'package:evalutation_zens/screen/order/order_screen.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return customPageRoute(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen());
      case Routes.order:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;

        final item = args['item'];
        final count = args['count'];
        return customPageRoute(
            pageBuilder: (context, animation, secondaryAnimation) =>
                OrderScreen(
                  itemDrink: item,
                  count: count,
                ));
      default:
        return null;
    }
  }
}

customPageRoute(
    {required Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) pageBuilder,
    RouteSettings? settings}) {
  return PageRouteBuilder(
      settings: settings,
      pageBuilder: pageBuilder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
      transitionDuration: const Duration(milliseconds: 200));
}
