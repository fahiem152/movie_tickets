import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';

import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/text_input_widget.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
            context.showSnackBar('Login Success');
          }
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 160,
                child: Image.asset(
                  "assets/movie-ticket-logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextInpuWidget(
              controller: emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 24),
            TextInpuWidget(
              controller: passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            switch (ref.watch(userDataProvider)) {
              AsyncData(:final value) => value == null
                  ? ElevatedButton(
                      onPressed: () {
                        ref.read(userDataProvider.notifier).login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      },
                      child: const Text("Login"),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              _ => const Center(
                  child: CircularProgressIndicator(
                    color: ghostWhite,
                  ),
                ),
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont\'t have an account? ',
                ),
                TextButton(
                  onPressed: () {
                    ref.watch(routerProvider).goNamed('register');
                  },
                  child: const Text(
                    "Register here",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
