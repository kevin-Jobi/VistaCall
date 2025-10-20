import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/10_health_eating_habits.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/fitness_tips_and_busy_people.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/mental_health.dart';

class HealthNewsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String readTime;
  final int index;

  const HealthNewsCard({
    required this.title,
    required this.imageUrl,
    required this.readTime,
    required this.index,
  });

  void _navigateToArticle(int index) {
    switch (index) {
      case 0:
        Get.to(() => TenHealthyEatingHabitsPage());
        break;
      case 1:
        Get.to(() => MentalHealthPage());
        break;
      case 2:
        Get.to(() => FitnessTipsPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      readTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _navigateToArticle(index),
                      child: Text(
                        'Read More',
                        style: TextStyle(
                          color: Color(0xFF4A78FF),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
