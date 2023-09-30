import 'package:movie_tickets/domain/entities/result.dart';

abstract interface class Authentication {
  Future<Result<String>> register({
    required String email,
    required String password,
  });

  Future<Result<String>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logOut();
  String? getLoggedInUserId();
}
