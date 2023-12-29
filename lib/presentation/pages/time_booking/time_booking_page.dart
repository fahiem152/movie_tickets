// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:movie_tickets/domain/entities/movie_detail.dart';
import 'package:movie_tickets/domain/entities/transaction.dart';
import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/msic/constans.dart';
import 'package:movie_tickets/presentation/pages/time_booking/methods/options.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:movie_tickets/presentation/widgets/nerwork_image_card.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;
  const TimeBookingPage({
    Key? key,
    required this.movieDetail,
  }) : super(key: key);

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'XXI',
    'CGV',
    'Cinemaxx',
    'Platinum Cineplex',
    'FLIX Cinema',
    'New Star Cineplex',
    'Grand Cinemas',
    'Cinépolis',
    'Movimax',
    'Empire XXI',
  ];

  final List<DateTime> dates = List.generate(14, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });
  final List<int> hours = List.generate(14, (index) => index + 10);
  String? selectedTheater;
  DateTime? selectedDate;
  int? selectedHour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                24,
              ),
              child: BackNavigationBarWidget(
                title: widget.movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: NetworkImageCard(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.width - 48) * 0.6,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            ...options(
              title: 'Select a theater',
              options: theaters,
              selectedItem: selectedTheater,
              onTap: (object) => setState(() {
                selectedTheater = object;
              }),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ...options(
              title: 'Select date',
              options: dates,
              coverter: (date) => DateFormat('EEE, d MMM y').format(date),
              selectedItem: selectedDate,
              onTap: (object) => setState(() {
                selectedDate = object;
              }),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ...options(
              title: 'Select show time',
              options: hours,
              selectedItem: selectedHour,
              coverter: (object) => '$object:00',
              isOptionEnable: (hour) =>
                  selectedDate != null &&
                  DateTime(selectedDate!.year, selectedDate!.month,
                          selectedDate!.day, hour)
                      .isAfter(DateTime.now()),
              onTap: (object) => setState(() {
                selectedHour = object;
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: SizedBox(
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
                    if (selectedDate == null ||
                        selectedHour == null ||
                        selectedDate == null) {
                      context.showSnackBar('Please selcet all options');
                    } else {
                      Transaction transaction = Transaction(
                        uid: ref.read(userDataProvider).value!.uid,
                        title: widget.movieDetail.title,
                        adminFee: 3000,
                        total: 0,
                        watchingTime: DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedHour!,
                        ).millisecondsSinceEpoch,
                        transactionImage: widget.movieDetail.posterPath,
                        theaterName: selectedTheater,
                      );
                      ref.read(routerProvider).pushNamed('seat-booking',
                          extra: (widget.movieDetail, transaction));
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            )
          ],
        ),
      ],
    )));
  }
}
