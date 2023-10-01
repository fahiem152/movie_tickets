import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';

import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.error.toString())));
        }
      },
    );
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
        ),
        onPressed: () {
          ref
              .read(userDataProvider.notifier)
              .login(email: 'ahmad@gmail.com', password: '12345678');
        },
        child: const Text("Login"),
      ),
    ));
  }
}
