// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vistacall/presentation/views/see_all_options/see_all_health_care_article_option.dart';
// import 'package:vistacall/presentation/widgets/section_header.dart';
// import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/health_article_home_page_section/health_news_card.dart';

// class HealthCareArticles extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SectionHeader(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           title: 'Health Care Articles',
//           actionLabel: 'See All',
//           onAction: () {
//             Get.to(() => SeeAllHealthArticles(),
//                 transition: Transition.rightToLeftWithFade);
//           },
//         ),
//         const SizedBox(height: 16),
//         const SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 HealthNewsCard(
//                   title: '10 Healthy Eating Habits',
//                   imageUrl: 'assets/images/healthy food.jpeg',
//                   readTime: '5 min read',
//                   index: 0,
//                 ),
//                 SizedBox(width: 16),
//                 HealthNewsCard(
//                   title: 'Mental Health Awareness',
//                   imageUrl: 'assets/images/mental_health_image.jpeg',
//                   readTime: '4 min read',
//                   index: 1,
//                 ),
//                 SizedBox(width: 16),
//                 HealthNewsCard(
//                   title: 'Fitness Tips for Busy People',
//                   imageUrl: 'assets/images/fitness.jpeg',
//                   readTime: '3 min read',
//                   index: 2,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistacall/presentation/views/see_all_options/see_all_health_care_article_option.dart';
import 'package:vistacall/utils/premium_theme.dart';

class HealthCareArticles extends StatelessWidget {
  /// Hook for opening an article. Wire this to whatever HealthNewsCard
  /// did on tap (its code wasn't shared), e.g. (i) => Get.to(...).
  final void Function(int index)? onArticleTap;

  HealthCareArticles({super.key, this.onArticleTap});

  // Original data kept; the small gold label per article is static.
  final List<_Article> _articles = const [
    _Article(
      title: '10 Healthy Eating Habits',
      imageUrl: 'assets/images/healthy food.jpeg',
      readTime: '5 min read',
      label: 'NUTRITION',
    ),
    _Article(
      title: 'Mental Health Awareness',
      imageUrl: 'assets/images/mental_health_image.jpeg',
      readTime: '4 min read',
      label: 'MENTAL HEALTH',
    ),
    _Article(
      title: 'Fitness Tips for Busy People',
      imageUrl: 'assets/images/fitness.jpeg',
      readTime: '3 min read',
      label: 'FITNESS',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumSectionTitle(
          title: 'Health Care Articles',
          actionLabel: 'See All',
          onAction: () {
            Get.to(() => SeeAllHealthArticles(),
                transition: Transition.rightToLeftWithFade);
          },
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              for (int i = 0; i < _articles.length; i++)
                _ArticleCard(
                  article: _articles[i],
                  onTap: onArticleTap == null ? null : () => onArticleTap!(i),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Article {
  final String title;
  final String imageUrl;
  final String readTime;
  final String label;
  const _Article({
    required this.title,
    required this.imageUrl,
    required this.readTime,
    required this.label,
  });
}

class _ArticleCard extends StatelessWidget {
  final _Article article;
  final VoidCallback? onTap;
  const _ArticleCard({required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: PremiumColors.line),
        ),
        child: Row(
          children: [
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                gradient: PremiumColors.navyGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  article.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.article_rounded,
                    color: PremiumColors.accent,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.label,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: PremiumColors.accent,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      color: PremiumColors.ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.readTime,
                    style: const TextStyle(
                        fontSize: 11.5, color: PremiumColors.muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}