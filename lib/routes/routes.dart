import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

GoRoute route(
  String path,
  BuildContext context,
  GoRouterState state,
  Widget widget,
) {
  return GoRoute(
    path: path,
    builder: (BuildContext context, GoRouterState state) {
      return widget;
    },
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Text('Home Screen');
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const Text('Details Screen');
          },
        ),
      ],
    ),
  ],
);
