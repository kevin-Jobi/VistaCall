
import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/bullet_points.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/content.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/disorder_section.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/info_card.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/mental_health/section_title.dart';


class MentalHealthPage extends StatelessWidget {
  const MentalHealthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Mental Health Awareness',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.map((item) {
              if (item.containsKey('title') && item.containsKey('text')) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: item['title']),
                    ContentText(text: item['text']),
                    const SizedBox(height: 16),
                  ],
                );
              } else if (item.containsKey('disorders')) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: item['title']),
                    ...item['disorders'].map<Widget>((disorder) {
                      return DisorderSection(
                        disorder: disorder['name'],
                        description: disorder['description'],
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                  ],
                );
              } else if (item.containsKey('info_card')) {
                return Column(
                  children: [
                    InfoCard(
                      title: item['info_card']['title'],
                      content: item['info_card']['content'],
                      color: const Color(0xFF4A78FF).withOpacity(0.1),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              } else if (item.containsKey('bullet_points')) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: item['title']),
                    BulletPoints(points: item['bullet_points']),
                    const SizedBox(height: 16),
                  ],
                );
              }
              return const SizedBox.shrink();
            }).toList(),
          ),
        ),
      ),
    );
  }
}