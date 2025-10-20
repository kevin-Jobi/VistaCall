
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/ten_healthy_eating_habits_page/content.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/ten_healthy_eating_habits_page/health_habit_item.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/ten_healthy_eating_habits_page/intro_section.dart';
class TenHealthyEatingHabitsPage extends StatelessWidget {
  const TenHealthyEatingHabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of habit data
   

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '10 Healthy Eating Habits',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IntroSection(),
              const SizedBox(height: 16),
              // Map the list of habits into HealthHabitItem widgets
              ...habits.map((habit) {
                return HealthHabitItem(
                  number: habit['number'],
                  title: habit['title'],
                  description: habit['description'],
                  details: List<String>.from(habit['details']),
                ); 
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}