import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/usecases/get_nmovie_list/get_movie_list.dart';
import 'package:movie_tickets/domain/usecases/get_nmovie_list/get_movie_list_paramas.dart';
import 'package:movie_tickets/presentation/providers/usecases/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'up_coming_provider.g.dart';

@Riverpod(keepAlive: true)
class UpComing extends _$UpComing {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();
    GetMovieList getMovieList = ref.read(getMovieListProvider);
    var result = await getMovieList(
        GetMovieListParams(category: MovieListCategories.upcoming, page: page));
    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}
