import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistacall/presentation/views/see_all_options/see_all_health_care_article_option.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/health_article_home_page_section/health_news_card.dart';


class HealthCareArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Health Care Articles',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => SeeAllHealthArticles(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF4A78FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                HealthNewsCard(
                  title: '10 Healthy Eating Habits',
                  imageUrl: 'assets/images/healthy food.jpeg',
                  readTime: '5 min read',
                  index: 0,
                ),
                SizedBox(width: 16),
                HealthNewsCard(
                  title: 'Mental Health Awareness',
                  imageUrl: 'assets/images/mental_health_image.jpeg',
                  readTime: '4 min read',
                  index: 1,
                ),
                SizedBox(width: 16),
                HealthNewsCard(
                  title: 'Fitness Tips for Busy People',
                  imageUrl: 'assets/images/fitness.jpeg',
                  readTime: '3 min read',
                  index: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}