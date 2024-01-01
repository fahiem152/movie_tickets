import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';
import 'package:movie_tickets/presentation/msic/methods.dart';
import 'package:movie_tickets/presentation/pages/detail_page/methods/background.dart';
import 'package:movie_tickets/presentation/pages/detail_page/methods/cast_and_crew.dart';
import 'package:movie_tickets/presentation/pages/detail_page/methods/movie_overview.dart';
import 'package:movie_tickets/presentation/pages/detail_page/methods/movie_short_info.dart';
import 'package:movie_tickets/presentation/providers/movie/movie_detail_provider.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:movie_tickets/presentation/widgets/nerwork_image_card.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;
  const DetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(MovieDetailProvider(movie: movie));
    return Scaffold(
      body: Stack(
        children: [
          ...background(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackNavigationBarWidget(
                      title: movie.title,
                      onTap: () => ref.watch(routerProvider).pop(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      borderRadius: 16,
                      imageUrl: asyncMovieDetail.valueOrNull != null
                          ? 'https://image.tmdb.org/t/p/w500${asyncMovieDetail.value!.backdropPath ?? movie.posterPath}'
                          : null,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ...movieShortInfo(
                      asyncMovieDetail: asyncMovieDetail,
                      context: context,
                    ),
                    SizedBox(height: 20),
                    ...movieOverview(
                      asyncMovieDetail,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              ...castAndCrew(movie: movie, ref: ref),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    MovieDetail? movieDetail = asyncMovieDetail.valueOrNull;
                    if (movieDetail != null) {
                      ref
                          .read(routerProvider)
                          .pushNamed('time-booking', extra: movieDetail);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: backgroundColor,
                    backgroundColor: saffron,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Book this movie',
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
