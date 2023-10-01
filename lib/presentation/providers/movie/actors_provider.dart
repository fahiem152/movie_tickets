import 'package:movie_tickets/domain/entities/actor.dart';

import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/usecases/get_actors/get_actors.dart';
import 'package:movie_tickets/domain/usecases/get_actors/get_actors.prams.dart';
import 'package:movie_tickets/presentation/providers/usecases/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActor = ref.read(getActorsProvider);
  var actorResult = await getActor(GetActorsParams(movieId: movieId));
  return switch (actorResult) {
    Success(value: final actors) => actors,
    Failed(message: _) => []
  };
}
