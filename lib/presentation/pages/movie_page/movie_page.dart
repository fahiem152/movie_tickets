import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/pages/movie_page/methods/movie_list.dart';
import 'package:movie_tickets/presentation/pages/movie_page/methods/promotion_list.dart';
import 'package:movie_tickets/presentation/pages/movie_page/methods/search_bar.dart';
import 'package:movie_tickets/presentation/pages/movie_page/methods/user_info.dart';

import 'package:movie_tickets/presentation/providers/movie/now_playing_provider.dart';
import 'package:movie_tickets/presentation/providers/movie/up_coming_provider.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFileNames = ['popcorn.jpg', 'buy1get1.jpg'];
  MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        userInfo(ref),
        const SizedBox(height: 40),
        searchBar(context),
        const SizedBox(height: 24),
        ...movieList(
          title: 'Now Playing',
          movies: ref.watch(nowPlayingProvider),
          onTap: (movie) {
            ref.read(routerProvider).pushNamed('detail', extra: movie);
          },
        ),
        const SizedBox(height: 30),
        ...promotionList(promotionImageFileNames),
        const SizedBox(height: 30),
        ...movieList(
          title: 'Up Coming',
          movies: ref.watch(upComingProvider),
          onTap: (movie) {},
        ),
      ],
    );
  }
}
