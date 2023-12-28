import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/domain/entities/movie_detail.dart';

List<Widget> movieOverview(AsyncValue<MovieDetail?> asyncMovieDetail) => [
      const Text(
        "Overview",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      asyncMovieDetail.when(
        data: (data) => Text(
          data != null ? data.overview : '-',
          textAlign: TextAlign.justify,
        ),
        error: (error, stackTrace) => const Text(
          "Failed to load movie`s overview. Please try again later",
          textAlign: TextAlign.justify,
        ),
        loading: () => const CircularProgressIndicator(),
      ),
    ];
