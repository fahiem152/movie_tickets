import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/ticket._widget.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ref.watch(transactionDataProvider).when(
                    data: (transaction) => (transaction
                            .where((element) =>
                                element.title != 'Top Up' &&
                                element.watchingTime! >=
                                    DateTime.now().millisecondsSinceEpoch)
                            .toList()
                          ..sort(
                            (a, b) =>
                                a.watchingTime!.compareTo(b.watchingTime!),
                          ))
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TicketWidget(transaction: e),
                            ))
                        .toList(),
                    error: (error, stackTrace) => [],
                    loading: () => [const CircularProgressIndicator()],
                  ),
            ),
          ),
        ],
      )),
    );
  }
}
