import 'package:flutter/material.dart';
import 'package:movie_tickets/data/dummies/dummy_authentication.dart';
import 'package:movie_tickets/data/dummies/dummy_user_repository.dart';
import 'package:movie_tickets/domain/usecases/logn/login.dart';
import 'package:movie_tickets/presentation/pages/main_page/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
        ),
        onPressed: () {
          Login login = Login(
            authentication: DummyAuthentication(),
            userRepository: DummyUserRepository(),
          );
          login
              .call(
            LoginParams(
              email: "email",
              password: "password",
            ),
          )
              .then((result) {
            if (result.isSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    user: result.resultValue!,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result.errorMessage!),
                ),
              );
            }
          });
        },
        child: const Text("Login"),
      ),
    ));
  }
}
