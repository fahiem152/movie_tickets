import 'package:movie_tickets/data/repositories/movie_repository.dart';
import 'package:movie_tickets/data/tmdb/tmdb_movie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_repository_provider.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) => TmdbMovieRepositoy();
