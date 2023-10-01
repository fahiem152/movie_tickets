import 'package:movie_tickets/data/repositories/movie_repository.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/usecases/get_nmovie_list/get_movie_list_paramas.dart';
import 'package:movie_tickets/domain/usecases/usecase.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParams> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<Result<List<Movie>>> call(GetMovieListParams params) async {
    var movieResult = switch (params.category) {
      MovieListCategories.nowPlaying =>
        await _movieRepository.getNowPlaying(page: params.page),
      MovieListCategories.upcoming =>
        await _movieRepository.getUpComing(page: params.page),
    };
    return switch (movieResult) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message)
    };
  }
}
