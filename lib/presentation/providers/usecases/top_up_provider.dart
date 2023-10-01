import 'package:movie_tickets/domain/usecases/tpo_up/toup_up.dart';
import 'package:movie_tickets/presentation/providers/repositories/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_up_provider.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) =>
    TopUp(transactionRepository: ref.watch(transactionRepositoryProvider));
