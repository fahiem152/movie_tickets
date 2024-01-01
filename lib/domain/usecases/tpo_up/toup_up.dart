import 'package:movie_tickets/data/repositories/transaction_repository.dart';
import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/entities/transaction.dart';
import 'package:movie_tickets/domain/usecases/create_transaction/create_transaction.dart';
import 'package:movie_tickets/domain/usecases/create_transaction/create_transaction_params.dart';
import 'package:movie_tickets/domain/usecases/tpo_up/top_up_param.dart';
import 'package:movie_tickets/domain/usecases/usecase.dart';

class TopUp implements UseCase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<void>> call(TopUpParam params) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var createTransactionResult = await createTransaction(
      CreateTransactionParams(
        transaction: Transaction(
            id: 'mvtk-tp-$transactionTime-${params.userId}',
            uid: params.userId,
            title: "Top Up",
            adminFee: 0,
            total: -params.amount,
            transactionTime: transactionTime),
      ),
    );
    return switch (createTransactionResult) {
      Success(value: _) => const Result.success(null),
      Failed(message: _) => const Result.failed("Failed to top up")
    };
  }
}
