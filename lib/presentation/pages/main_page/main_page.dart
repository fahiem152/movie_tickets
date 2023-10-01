import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_tickets/presentation/providers/routes/router_provider.dart';
import 'package:movie_tickets/presentation/providers/user_data/user_data_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main"),
          actions: const [],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(ref.watch(userDataProvider).when(
                    data: (data) => data.toString(),
                    error: (error, stackTrace) => error.toString(),
                    loading: () => "Loading..",
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  ref.read(userDataProvider.notifier).logout();
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ));
  }
}
