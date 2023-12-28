import 'package:go_router/go_router.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/presentation/pages/detail_page/detail_page.dart';
import 'package:movie_tickets/presentation/pages/login/login_page.dart';
import 'package:movie_tickets/presentation/pages/main_page/main_page.dart';
import 'package:movie_tickets/presentation/pages/register/register_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/main',
          name: 'main',
          builder: (context, state) => const MainPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: '/detail',
          name: 'detail',
          builder: (context, state) => DetailPage(
            movie: state.extra as Movie,
          ),
        ),
      ],
    );
