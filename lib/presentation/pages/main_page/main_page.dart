// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/domain/entities/user.dart';

import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/pages/movie_page/movie_page.dart';
import 'package:movie_tickets/presentation/pages/profile_page/profile_page.dart';
import 'package:movie_tickets/presentation/pages/ticket_page/ticket_page.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/bottom_nav_bar_item.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;
  const MainPage({
    super.key,
    this.imageFile,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    User? user = ref.read(userDataProvider).valueOrNull;

    if (widget.imageFile != null && user != null) {
      ref
          .read(userDataProvider.notifier)
          .uploadProfilePicture(user: user, imageFile: widget.imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (value) => setState(() {
            selectedPage = value;
          }),
          children: [
            Center(child: MoviePage()),
            const TicketPage(),
            const Center(
              child: ProfilePage(),
            )
          ],
        ),
        BottomNavBar(
          items: [
            BottomNavBarItem(
              index: 0,
              isSelected: selectedPage == 0,
              title: 'Home',
              image: 'assets/movie.png',
              selectedImage: 'assets/movie-selected.png',
            ),
            BottomNavBarItem(
              index: 1,
              isSelected: selectedPage == 1,
              title: 'Ticket',
              image: 'assets/ticket.png',
              selectedImage: 'assets/ticket-selected.png',
            ),
            BottomNavBarItem(
              index: 2,
              isSelected: selectedPage == 2,
              title: 'Profile',
              image: 'assets/profile.png',
              selectedImage: 'assets/profile-selected.png',
            ),
          ],
          onTap: (index) {
            selectedPage = index;
            pageController.animateToPage(selectedPage,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          },
          selectedIndex: 0,
        )
      ],
    ));
  }
}
