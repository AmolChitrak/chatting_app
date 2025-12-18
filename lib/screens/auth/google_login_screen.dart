import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'create_account_screen.dart';
import '../../core/constants/app_colors.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GooglesAuthProvider>();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/image/splash.png",
            fit: BoxFit.cover,
          ),

          Center(
            child: auth.loading
                ? const CircularProgressIndicator(
              color: AppColors.white,
            )
                : ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Image.asset(
                "assets/image/google.png",
                height: 22,
              ),
              label:  Text(
                "Sign in with Google",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                final success = await context
                    .read<GooglesAuthProvider>()
                    .signInWithGoogle();

                if (success && context.mounted) {
                  final auth =
                  context.read<GooglesAuthProvider>();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateAccountScreen(
                        googleName: auth.fullName,
                        googleEmail: auth.email,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
