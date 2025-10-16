import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/health_care_articles_contant_and_widgets/fitness_tips_and_busy_people/fitness_tip_card.dart';

List<Widget> buildFitnessTips(BuildContext context, Color primaryColor) {
  final tips = [
    {
      'number': '1',
      'title': 'Prioritize Your Health',
      'description': 'Recognize that your health is a priority, just like work and family commitments.',
      'details': [
        'Schedule fitness like you schedule meetings',
        'Commit to making time for your health',
        'Start with small, consistent efforts',
      ],
    },
    {
      'number': '2',
      'title': 'Set Realistic Goals',
      'description': 'Create achievable fitness goals that fit your lifestyle.',
      'details': [
        'Begin with 20-30 minute workouts',
        'Gradually increase intensity',
        'Celebrate progress, not perfection',
      ],
    },
    {
      'number': '3',
      'title': 'Incorporate Activity Into Your Routine',
      'description': 'Find ways to stay active throughout the day.',
      'details': [
        'Take the stairs instead of the elevator',
        'Walk or bike to work if possible',
        'Stretch during breaks to reduce stiffness',
      ],
    },
    {
      'number': '4',
      'title': 'Plan and Prepare Meals',
      'description': 'Healthy eating is an essential part of fitness.',
      'details': [
        'Prepare meals ahead of time to avoid fast food',
        'Choose balanced meals with proteins, carbs, and veggies',
        'Stay hydrated by drinking plenty of water',
      ],
    },
    {
      'number': '5',
      'title': 'Utilize Short Workouts',
      'description': 'Even short workouts can be effective.',
      'details': [
        'Try 10-15 minute high-intensity interval training (HIIT)',
        'Use online fitness apps for quick routines',
        'Focus on consistency over length',
      ],
    },
    {
      'number': '6',
      'title': 'Get Enough Sleep',
      'description': 'Rest and recovery are vital for overall health.',
      'details': [
        'Aim for 7-8 hours of sleep every night',
        'Establish a consistent sleep schedule',
        'Avoid screens before bedtime to improve sleep quality',
      ],
    },
    {
      'number': '7',
      'title': 'Stay Hydrated',
      'description': 'Proper hydration supports your energy and overall health.',
      'details': [
        'Drink at least 8 glasses of water daily',
        'Carry a water bottle to stay hydrated on the go',
        'Limit sugary and caffeinated drinks',
      ],
    },
    {
      'number': '8',
      'title': 'Warm Up and Cool Down',
      'description': 'Prepare your body for workouts and aid recovery.',
      'details': [
        'Do 5-10 minutes of light cardio before exercising',
        'Stretch after workouts to prevent soreness',
        'Focus on mobility exercises for joint health',
      ],
    },
    {
      'number': '9',
      'title': 'Use Technology to Stay on Track',
      'description': 'Leverage fitness apps and devices to monitor progress.',
      'details': [
        'Track steps with a pedometer or smartwatch',
        'Set reminders to move or exercise',
        'Join online fitness challenges for motivation',
      ],
    },
    {
      'number': '10',
      'title': 'Find a Workout Buddy',
      'description': 'Exercising with a friend can keep you accountable.',
      'details': [
        'Plan workout sessions together',
        'Encourage each other to stay consistent',
        'Share fitness goals and celebrate milestones',
      ],
    },
    {
      'number': '11',
      'title': 'Focus on Functional Fitness',
      'description': 'Enhance your ability to perform daily activities with ease.',
      'details': [
        'Incorporate exercises like squats and lunges',
        'Work on core strength for better stability',
        'Practice balance and coordination drills',
      ],
    },
    {
      'number': '12',
      'title': 'Make Fitness Fun',
      'description': 'Enjoy your workouts to stay consistent.',
      'details': [
        'Try dance classes or group sports',
        'Experiment with outdoor activities like hiking',
        'Switch up routines to avoid boredom',
      ],
    },
    {
      'number': '13',
      'title': 'Limit Sedentary Time',
      'description': 'Sitting for long periods can negatively affect your health.',
      'details': [
        'Stand up and stretch every hour',
        'Use a standing desk if possible',
        'Incorporate short walks into your day',
      ],
    },
    {
      'number': '14',
      'title': 'Practice Mindful Eating',
      'description': 'Be conscious of what and how much you eat.',
      'details': [
        'Eat slowly to savor your meals',
        'Avoid distractions like TV while eating',
        'Focus on whole, nutrient-dense foods',
      ],
    },
    {
      'number': '15',
      'title': 'Strengthen Your Mental Fitness',
      'description': 'Mental health is as important as physical health.',
      'details': [
        'Practice mindfulness or meditation',
        'Set aside time for relaxation',
        'Seek support if you feel overwhelmed',
      ],
    },
    {
      'number': '16',
      'title': 'Stay Flexible',
      'description': 'Incorporate stretching to maintain flexibility.',
      'details': [
        'Do yoga or Pilates regularly',
        'Stretch major muscle groups daily',
        'Focus on improving range of motion',
      ],
    },
    {
      'number': '17',
      'title': 'Take Breaks from Screens',
      'description': 'Reduce eye strain and improve posture.',
      'details': [
        'Follow the 20-20-20 rule: Look at something 20 feet away every 20 minutes for 20 seconds',
        'Adjust your workstation for ergonomic support',
        'Incorporate eye and neck exercises',
      ],
    },
    {
      'number': '18',
      'title': 'Invest in Quality Gear',
      'description': 'The right equipment can make workouts safer and more enjoyable.',
      'details': [
        'Wear proper shoes for your activity',
        'Use resistance bands or weights for strength training',
        'Choose comfortable, breathable clothing',
      ],
    },
    {
      'number': '19',
      'title': 'Learn Proper Form',
      'description': 'Avoid injuries by doing exercises correctly.',
      'details': [
        'Watch tutorials or hire a trainer for guidance',
        'Focus on quality over quantity',
        'Listen to your body to prevent overexertion',
      ],
    },
    {
      'number': '20',
      'title': 'Stay Consistent',
      'description': 'Consistency is key to long-term success.',
      'details': [
        'Create a fitness schedule and stick to it',
        'Track your progress to stay motivated',
        'Remember that small efforts add up over time',
      ],
    },
  ];

  return tips
      .map((tip) => FitnessTipCard(
            tip: tip,
            primaryColor: primaryColor,
          ))
      .toList();
}