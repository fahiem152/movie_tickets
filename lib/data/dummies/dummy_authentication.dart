import 'package:movie_tickets/data/repositories/authentication.dart';
import 'package:movie_tickets/domain/entities/result.dart';

class DummyAuthentication implements Authentication {
  @override
  String? getLoggedInUserId() {
    // TODO: implement getLoggedInUserId
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    // return const Result.success('UID123456789');
    return const Result.failed("Gagal Login Dummy");
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
