import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/transaction_card_widget.dart';

List<Widget> recentTransaction(WidgetRef ref) => [
      const Text(
        "Recent Transaction",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 24.0,
      ),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => (transactions
                  ..sort((a, b) =>
                      -a.transactionTime!.compareTo(b.transactionTime!)))
                .map(
              (transaction) => TransactionCardWidget(
                transaction: transaction,
              ),
            ),
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];
