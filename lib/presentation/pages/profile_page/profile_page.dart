import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/msic/methods.dart';
import 'package:movie_tickets/presentation/pages/profile_page/methods/profile_item.dart';
import 'package:movie_tickets/presentation/pages/profile_page/methods/user_info.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          verticalSpace(20),
          ...userInfo(ref),
          verticalSpace(20),
          const Divider(),
          verticalSpace(20),
          profileItem('Update Profile'),
          verticalSpace(20),
          profileItem('My Wallet'),
          verticalSpace(20),
          profileItem('Change Password'),
          verticalSpace(20),
          profileItem('Change Language'),
          verticalSpace(20),
          const Divider(),
          verticalSpace(20),
          profileItem('Contact Us'),
          verticalSpace(20),
          profileItem('Privacy Policy'),
          verticalSpace(20),
          profileItem('Terms and Conditions'),
          verticalSpace(60),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                ref.read(userDataProvider.notifier).logout();
              },
              child: const Text("Save"),
            ),
          ),
          verticalSpace(20),
          const Text(
            "Version 0.0.1",
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          verticalSpace(100)
        ],
      ),
    );
  }
}
