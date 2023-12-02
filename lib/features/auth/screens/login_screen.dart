import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/common/loading.dart';
import 'package:reddit/core/common/signIn_button.dart';
import 'package:reddit/core/constants/constants.dart';
import 'package:reddit/features/auth/controller/authController.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isLoading=ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Constants.logoPath,height: 40,),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (){},
              child: const Text(
                  'Skip',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
          )
        ],
      ),
      body: isLoading ? const Loader() : Column(
        children: [
          const SizedBox(height: 30,),
          const Text(
            'Dive into anything',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 0.5
            ),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Constants.loginEmotePath,height: 400,),
          ),
          const SizedBox(height: 30,),
          const SignInButton()
        ],
      ),
    );
  }
}
