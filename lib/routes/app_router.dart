import 'package:go_router/go_router.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/forest_page.dart';
import '../presentation/pages/challenges_page.dart';
import '../presentation/pages/settings_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/forest', builder: (_, __) => const ForestPage()),
    GoRoute(path: '/challenges', builder: (_, __) => const ChallengesPage()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
  ],
);
