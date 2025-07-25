import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/generated/assets.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.getStartedGetstarted2,
              height: 150,
              fit: BoxFit.contain,
            ),
            Image.asset(Assets.getStartedGetStarted, height: 300),
            SizedBox(height: 32),
            Text(
              'Your New Food Buddy.',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Discover, order, and enjoy meals anytime, anywhere.',
              style: GoogleFonts.lobster(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            InkWell(
              onTap: ()=> GoRouter.of(context).pushReplacement(AppRouter.kAuthScreen),
              hoverColor: Colors.transparent,
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'GeT Started',
                    style: GoogleFonts.lora(
                      textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
