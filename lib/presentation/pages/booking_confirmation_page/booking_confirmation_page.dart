// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/domain/entities/result.dart';
import 'package:movie_tickets/domain/entities/transaction.dart';
import 'package:movie_tickets/domain/usecases/create_transaction/create_transaction.dart';
import 'package:movie_tickets/domain/usecases/create_transaction/create_transaction_params.dart';
import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/extensions/int_extension.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';
import 'package:movie_tickets/presentation/pages/booking_confirmation_page/methods/transaction_row.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:movie_tickets/presentation/providers/usecases/create_transaction_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:movie_tickets/presentation/widgets/nerwork_image_card.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const BookingConfirmationPage({
    super.key,
    required this.transactionDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;
    transaction = transaction.copyWith(
        total: transaction.ticketAmount! * transaction.ticketPrice! +
            transaction.adminFee);
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackNavigationBarWidget(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 16,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Divider(
                  color: ghostWhite,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                transactionRow(
                  title: 'Showing Date',
                  value: DateFormat('EEEE, d MMMM y').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      (transaction.watchingTime ?? 0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                transactionRow(
                    title: 'Theater', value: '${transaction.theaterName}'),
                const SizedBox(
                  height: 5.0,
                ),
                transactionRow(
                  title: 'Seat Numbers',
                  value: transaction.seats.join(', '),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                transactionRow(
                    title: '# of Tickets',
                    value: '${transaction.ticketAmount} ticket(s)'),
                const SizedBox(
                  height: 5.0,
                ),
                transactionRow(
                    title: 'Ticket Price',
                    value: '${transaction.ticketPrice?.toIDRCurrencyFormat()}'),
                const SizedBox(
                  height: 5.0,
                ),
                transactionRow(
                    title: 'Adm. Fee',
                    value: transaction.adminFee.toIDRCurrencyFormat()),
                const SizedBox(
                  height: 5.0,
                ),
                const Divider(
                  color: ghostWhite,
                ),
                transactionRow(
                    title: 'Total Price',
                    value: transaction.total.toIDRCurrencyFormat()),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      int transactionTime =
                          DateTime.now().millisecondsSinceEpoch;

                      transaction = transaction.copyWith(
                          transactionTime: transactionTime,
                          id: 'mv-$transactionTime-${transaction.uid}');
                      CreateTransaction createTransaction =
                          ref.read(createTransactionProvider);
                      await createTransaction(
                              CreateTransactionParams(transaction: transaction))
                          .then((result) {
                        switch (result) {
                          case Success(value: _):
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();
                            ref.read(routerProvider).goNamed('main');
                          case Failed(:final message):
                            context.showSnackBar(message);
                        }
                      });
                    },
                    child: const Text("Pay Now"),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
