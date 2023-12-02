import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/authController.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user=ref.watch(userProvider)!;

    return Scaffold(
      body: Center(
        child: Text(user.karma.toString()),
      ),
    );
  }
}
