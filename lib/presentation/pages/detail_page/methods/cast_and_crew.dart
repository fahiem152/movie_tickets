import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/domain/entities/movie.dart';
import 'package:movie_tickets/presentation/msic/methods.dart';
import 'package:movie_tickets/presentation/providers/movie/actors_provider.dart';
import 'package:movie_tickets/presentation/widgets/nerwork_image_card.dart';

List<Widget> castAndCrew({
  required Movie movie,
  required WidgetRef ref,
}) =>
    [
      const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Text(
          "Cast and crew",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpace(24),
            ...ref.watch(actorsProvider(movieId: movie.id)).whenOrNull(
                      data: (data) => data
                          .where((element) => element.profilePath != null)
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: Column(
                                children: [
                                  NetworkImageCard(
                                    width: 100,
                                    height: 152,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${e.profilePath}',
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 100.0,
                                    child: Text(
                                      e.name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ) ??
                [],
            horizontalSpace(14)
          ],
        ),
      )
    ];
