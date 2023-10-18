import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/extensions/build_context_extension.dart';
import 'package:movie_tickets/presentation/pages/profile_page/profile_page.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/bottom_nav_bar_item.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;
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
          children: const [
            Center(
              child: Text(
                "Movies Page",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                "Tickets Page",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
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
