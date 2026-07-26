import 'package:flutter/material.dart';

/// Centralised navigation. Views must not call `Navigator.push` directly.
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return _navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  void pop<T extends Object?>([T? result]) {
    _navigator?.pop(result);
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return _navigator!.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }
}
