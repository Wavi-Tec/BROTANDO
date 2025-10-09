import 'package:go_router/go_router.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/principal/principal_page.dart';
import '../presentation/pages/perfil/perfil_page.dart';
import '../presentation/pages/cupones/cupones_page.dart';
// import '../presentation/pages/profile_page.dart';
import '../presentation/pages/add_page.dart';
import '../presentation/pages/search_page.dart';
import '../presentation/pages/chat_page.dart';
import '../presentation/pages/screens/home_screen.dart';
import '../presentation/chat/chat_screen.dart';
import 'page_transitions.dart';

final appRouter = GoRouter(
  initialLocation: '/inicio',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/inicio',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const PrincipalPage(),
          ),
        ),
        GoRoute(
          path: '/cupon',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const CuponesPage(),
          ),
        ),
        GoRoute(
          path: '/bosque',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const AddPage(),
          ),
        ),
        GoRoute(
          path: '/cuestionario',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const SearchPage(),
          ),
        ),
        GoRoute(
          path: '/donacion',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const ChatPage(),
          ),
        ),
        GoRoute(
          path: '/chat-screen',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const ChatScreen(),
          ),
        ),
        GoRoute(
          path: '/perfil',
          pageBuilder: (context, state) => PageTransitions.buildFadeTransition(
            context,
            state,
            const PerfilPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          PageTransitions.buildFadeTransition(context, state, const HomePage()),
    ),
  ],
);
