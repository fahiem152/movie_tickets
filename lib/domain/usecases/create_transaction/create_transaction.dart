import 'package:movie_tickets/data/repositories/transaction_repository.dart';
import 'package:movie_tickets/domain/entities/result.dart';

import 'package:movie_tickets/domain/usecases/create_transaction/create_transaction_params.dart';
import 'package:movie_tickets/domain/usecases/usecase.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParams> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<void>> call(params) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var result = await _transactionRepository.createTransaction(
        transaction: params.transaction.copyWith(
      transactionTime: transactionTime,
      id: (params.transaction.id == null)
          ? 'mvtk-$transactionTime-${params.transaction.uid}'
          : params.transaction.id,
    ));
    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(message: final message) => Result.failed(message)
    };
  }
}
