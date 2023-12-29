import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/presentation/msic/methods.dart';

List<Widget> movieShortInfo({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required BuildContext context,
}) =>
    [
      SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: Image.asset(
                'assets/duration.png',
              ),
            ),
            horizontalSpace(5),
            SizedBox(
              child: Text(
                '${asyncMovieDetail.when(data: (data) => data != null ? data.runtime : '-', error: (error, stackTrace) => '-', loading: () => '-')}',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            horizontalSpace(24),
            SizedBox(
              width: 14,
              height: 14,
              child: Image.asset('assets/genre.png'),
            ),
            horizontalSpace(8),
            Expanded(
              child: asyncMovieDetail.when(
                data: (data) {
                  String genres = data?.genres.join(', ') ?? '-';
                  return Text(
                    genres,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  );
                },
                error: (error, stackTrace) => const Text(
                  "-",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                loading: () => const Text(
                  "-",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 18,
            height: 18.0,
            child: Image.asset('assets/star.png'),
          ),
          horizontalSpace(5),
          Text((asyncMovieDetail.valueOrNull?.voteAverage ?? 0)
              .toStringAsFixed(1))
        ],
      ),
    ];
