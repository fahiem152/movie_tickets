import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/presentation/widgets/nerwork_image_card.dart';

List<Widget> movieList(
        {required String title,
        void Function(Movie movie)? onTap,
        required AsyncValue<List<Movie>> movies}) =>
    [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 15,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
          height: 228,
          child: movies.when(
            data: (data) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data
                      .map(
                        (movie) => Padding(
                          padding: EdgeInsets.only(
                            left: movie == data.first ? 24 : 10,
                          ),
                          child: NetworkImageCard(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.contain,
                            onTap: () => onTap?.call(movie),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            },
            error: (error, stackTrace) => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ))
    ];
