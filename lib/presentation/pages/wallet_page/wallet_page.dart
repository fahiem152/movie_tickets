import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/pages/wallet_page/methods/recent_transaction.dart';
import 'package:movie_tickets/presentation/pages/wallet_page/methods/wallet_card.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';
import 'package:movie_tickets/presentation/widgets/back_navigation_bar_widget.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(
            24,
          ),
          child: Column(
            children: [
              BackNavigationBarWidget(
                title: 'My Wallet',
                onTap: () => ref.read(routerProvider).pop(),
              ),
              const SizedBox(
                height: 24.0,
              ),
              // walletCard
              walletCard(ref),
              const SizedBox(
                height: 24.0,
              ),
              ...recentTransaction(ref)
            ],
          ),
        ),
      ],
    )));
  }
}
