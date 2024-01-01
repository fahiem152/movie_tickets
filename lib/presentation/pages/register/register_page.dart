import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/text_input_widget.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reTypePasswordController =
      TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    reTypePasswordController.dispose();
    super.dispose();
  }

  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref.read(routerProvider).goNamed('main', extra: xFile!= null?File(xFile!.path):null);
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
            GestureDetector(
              onTap: () async {
                xFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(() {});
              },
              child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      xFile == null ? null : FileImage(File(xFile!.path)),
                  child: xFile == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: ghostWhite,
                        )
                      : null),
            ),
            const SizedBox(height: 24),
            TextInpuWidget(
              controller: nameController,
              labelText: 'Name',
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
              // obscureText: true,
            ),
            const SizedBox(height: 24),
            TextInpuWidget(
              controller: reTypePasswordController,
              labelText: 'Retype Password',
              // obscureText: true,
            ),
            const SizedBox(height: 24),
            switch (ref.watch(userDataProvider)) {
              AsyncData(:final value) => value == null
                  ? ElevatedButton(
                      onPressed: () {
                        if (passwordController.text ==
                            reTypePasswordController.text) {
                          ref.read(userDataProvider.notifier).register(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        } else {
                          context.showSnackBar('Please ReType your Password');
                        }
                      },
                      child: const Text("Register"),
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
                  'Already  have an account? ',
                ),
                TextButton(
                  onPressed: () {
                    ref.watch(routerProvider).goNamed('login');
                  },
                  child: const Text(
                    "Login here",
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
