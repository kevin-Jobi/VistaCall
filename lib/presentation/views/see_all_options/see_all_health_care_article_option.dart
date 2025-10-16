
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistacall/presentation/10_health_eating_habits.dart';
import 'package:vistacall/presentation/fitness_tips_and_busy_people.dart';
import 'package:vistacall/presentation/mental_health.dart';
import 'package:vistacall/utils/app.theme.dart';

class SeeAllHealthArticles extends StatelessWidget {
  final List<Map<String, String>> widgets = [
    {
      'title': '10 Healthy Eating Habits',
      'description':
          "Healthy eating habits include consuming a variety of fruits, vegetables, whole grains, and lean proteins, practicing portion control, and staying hydrated. Limit processed foods and added sugars. Eat mindfully, maintain regular meal times, cook at home, and listen to your body's hunger cues for a balanced and nourishing diet.",
      'assetImage': 'assets/images/healthy food.jpeg',
    },
    {
      'title': 'Fitness Tips for Busy People',
      'description':
          "Fitness tips for busy people include prioritizing short, effective workouts like HIIT or yoga, incorporating physical activity into daily routines, such as walking during calls or taking stairs, and staying consistent with a schedule. Focus on balanced nutrition, stay hydrated, and aim for quality sleep to maintain energy and overall health.",
      'assetImage': 'assets/images/fitness.jpeg',
    },
    {
      'title': 'Mental Health Awareness',
      'description':
          "Mental health awareness promotes understanding and reduces stigma around mental well-being. It encourages open conversations, early intervention, and support for those struggling with anxiety, depression, or other conditions. Raising awareness fosters empathy, educates communities, and emphasizes the importance of seeking help, self-care, and creating a supportive, stigma-free environment for all.",
      'assetImage': 'assets/images/mental_health_image.jpeg',
    },
  ];

  SeeAllHealthArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Health Care Articles',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 230, 236, 255),
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        widgets[index]['assetImage']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, size: 50),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widgets[index]['title']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widgets[index]['description']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                if (index == 0) {
                                  Get.to(TenHealthyEatingHabitsPage(),
                                  transition: Transition.rightToLeftWithFade);
                                } else if (index == 1) {
                                  Get.to(FitnessTipsPage(),
                                  transition: Transition.rightToLeftWithFade);
                                } else if (index == 2) {
                                  Get.to(MentalHealthPage(),  
                                  transition: Transition.rightToLeftWithFade); 
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Read More',
                                    style: TextStyle(
                                      color: AppColors.mainTheme,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}