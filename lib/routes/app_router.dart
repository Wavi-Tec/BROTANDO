import 'package:go_router/go_router.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/forest_page.dart';
import '../presentation/pages/challenges_page.dart';
import '../presentation/pages/settings_page.dart';
import '../presentation/pages/people_page.dart';
import '../presentation/pages/profile_page.dart';
import '../presentation/pages/add_page.dart';
import '../presentation/pages/search_page.dart';
import '../presentation/pages/chat_page.dart';
import '../presentation/pages/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/people', // Inicia en la página de people
  routes: [
    // Shell route que mantiene el HomeScreen como layout principal
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/people',
          builder: (context, state) => const PeoplePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(path: '/add', builder: (context, state) => const AddPage()),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
      ],
    ),
    // Rutas adicionales fuera del shell
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    GoRoute(path: '/forest', builder: (_, __) => const ForestPage()),
    GoRoute(path: '/challenges', builder: (_, __) => const ChallengesPage()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
  ],
);
