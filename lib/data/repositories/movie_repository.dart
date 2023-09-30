import 'package:movie_tickets/domain/entities/actor.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/domain/entities/result.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getNowPlaying({
    int page = 1,
  });
  Future<Result<List<Movie>>> getUpComing({
    int page = 1,
  });

  Future<Result<MovieDetail>> getDetail({
    required int id,
  });

  Future<Result<List<Actor>>> sgetActors({
    required int id,
  });
}
