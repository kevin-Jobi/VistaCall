
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/fitness_tips_and_busy_people/intro_section.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_pages_and_content_widgets/content.dart';



class FitnessTipsPage extends StatelessWidget {
  const FitnessTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF4A78FF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Fitness Tips for Busy People',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FitnessTipsBusyPoepleIntroSection(primaryColor: primaryColor),
                const SizedBox(height: 16),
                ...buildFitnessTips(context, primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}