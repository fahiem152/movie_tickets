import 'package:movie_tickets/data/repositories/authentication.dart';
import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;
  @override
  Future<Result<void>> call(void _) {
    return _authentication.logOut();
  }
}
