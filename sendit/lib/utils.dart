import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:sendit/main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SendIt()),
    GoRoute(path: "/intro_page", builder: (context, state) => const SendIt()),
  ],
);

//currrent theme mode - light or dark
final lightmode = StateProvider<bool>((ref) {
  return true;
});
