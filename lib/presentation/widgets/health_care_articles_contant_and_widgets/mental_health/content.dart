import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  final String text;

  const ContentText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }
}
 final List<Map<String, dynamic>> content = const [
    {
      'title': 'Mental Health Awareness: Understanding and Breaking the Stigma',
      'text': 'Mental health is a crucial aspect of our overall well-being, yet it is often overlooked or misunderstood. Many people fail to recognize its importance until they face challenges themselves.',
    },
    {
      'title': 'What is Mental Health?',
      'text': 'Mental health refers to a person\'s emotional, psychological, and social well-being. It affects how we think, feel, and act. Mental health also influences how we handle stress, relate to others, and make choices.',
    },
    {
      'title': 'Common Mental Health Disorders',
      'disorders': [
        {
          'name': 'Anxiety Disorders',
          'description': 'Anxiety is one of the most common mental health issues globally. It can manifest in different forms, such as generalized anxiety disorder, panic disorder, and social anxiety.',
        },
        {
          'name': 'Depression',
          'description': 'Depression is a persistent feeling of sadness or hopelessness that affects a person\'s ability to function in daily life. It can lead to a lack of energy and difficulty concentrating.',
        },
        {
          'name': 'Bipolar Disorder',
          'description': 'Bipolar disorder involves extreme mood swings that include periods of depression and episodes of mania or hypomania (elevated mood).',
        },
      ]
    },
    {
      'info_card': {
        'title': 'Breaking the Stigma',
        'content': 'Mental health stigma prevents people from seeking help. By understanding and supporting those with mental health challenges, we can create a more compassionate society.',
      },
    },
    {
      'title': 'Why Mental Health Awareness Matters',
      'bullet_points': [
        'Promotes Early Intervention',
        'Reduces Social Stigma',
        'Encourages Empathy and Support',
        'Creates Supportive Environments',
      ],
    },
    {
      'title': 'Steps to Promote Mental Health Awareness',
      'bullet_points': [
        'Engage in Education and Training',
        'Encourage Open Conversations',
        'Support Mental Health Initiatives',
        'Check-In with Loved Ones',
        'Practice and Promote Self-Care',
      ],
    },
    {
      'info_card': {
        'title': 'Final Thought',
        'content': 'Mental health is just as important as physical health. By promoting awareness, we contribute to a more inclusive, empathetic, and healthier society.',
      },
    },
    {
      'title': 'Practical Tips for Mental Well-Being',
      'bullet_points': [
        'Maintain a regular sleep schedule.',
        'Practice mindfulness and meditation.',
        'Stay connected with loved ones.',
        'Engage in regular physical activity.',
        'Seek professional help when needed.',
      ],
    },
  ];