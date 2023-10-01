import 'package:movie_tickets/data/repositories/movie_repository.dart';
import 'package:movie_tickets/domain/entities/actor.dart';
import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/usecases/get_actors/get_actors.prams.dart';
import 'package:movie_tickets/domain/usecases/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParams> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<Result<List<Actor>>> call(GetActorsParams params) async {
    var actorListResult = await _movieRepository.getActors(id: params.movieId);
    return switch (actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
