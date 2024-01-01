import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_tickets/data/repositories/movie_repository.dart';
import 'package:movie_tickets/domain/entities/actor.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/domain/entities/result.dart';

class TmdbMovieRepositoy implements MovieRepository {
  final Dio? _dio;
  final String _accesToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NDdiODY4NjY4NTQxZjFiMWJjNTA1ODllMjI4MDhiMiIsInN1YiI6IjY1MTdiZmI4OTNiZDY5MDBlMTJkOGI1NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gFzzeyW43RuL7tL-KEtoXNk9rAGdoAJsVKX1Qh8s7rU';
  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accesToken',
    'accept': 'application/json',
  });
  TmdbMovieRepositoy({Dio? dio}) : _dio = dio ?? Dio();
  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$id?language=en-US',
        options: _options,
      );
      log("response: $response");
      return Result.success(MovieDetail.fromJSON(response.data));
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) =>
      _getMovie(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpComing({int page = 1}) =>
      _getMovie(_MovieCategory.upcoming.toString(), page: page);

  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
        options: _options,
      );
      final result = List<Map<String, dynamic>>.from(response.data['cast']);
      return Result.success(result.map((e) => Actor.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    }
  }

  Future<Result<List<Movie>>> _getMovie(String category, {int page = 1}) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
        options: _options,
      );
      final result = List<Map<String, dynamic>>.from(
        response.data['results'],
      );
      return Result.success(result.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed("${e.message}");
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _instring;

  const _MovieCategory(String inString) : _instring = inString;

  @override
  String toString() => _instring;
}
