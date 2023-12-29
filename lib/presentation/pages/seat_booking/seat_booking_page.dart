// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/domain/entities/transaction.dart';
import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';
import 'package:movie_tickets/presentation/pages/seat_booking/methods/legend.dart';
import 'package:movie_tickets/presentation/pages/seat_booking/methods/movie_screen.dart';
import 'package:movie_tickets/presentation/pages/seat_booking/methods/seat_section.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:movie_tickets/presentation/widgets/seat_widget.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const SeatBookingPage({
    Key? key,
    required this.transactionDetail,
  }) : super(key: key);

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;
    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            24,
          ),
          child: Column(
            children: [
              BackNavigationBarWidget(
                title: movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              movieScreen(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 1),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 19),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              legend(),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                '${selectedSeats.length} seats selected',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                  onPressed: () {
                    if (selectedSeats.isEmpty) {
                      context.showSnackBar('Please select at least one seat');
                    } else {
                      var updateTransaction = transaction.copyWith(
                        seats:
                            (selectedSeats..sort()).map((e) => '$e').toList(),
                        ticketAmount: selectedSeats.length,
                        ticketPrice: 25000,
                      );
                      ref.read(routerProvider).pushNamed('booking-confirmation',
                          extra: (movieDetail, updateTransaction));
                    }
                  },
                  child: const Text("Next"),
                ),
              )
            ],
          ),
        ),
      ],
    )));
  }

  void onSeatTap(seatNumber) {
    if (!selectedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selceted
          : SeatStatus.available;
}
