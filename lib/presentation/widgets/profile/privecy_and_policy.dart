import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),

        backgroundColor: Colors.white,
        title: const Text('Privacy Policy'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: October 7, 2025',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Introduction',
              'This Privacy Policy describes Our policies and procedures on the collection, '
                  'use and disclosure of Your information when You use the Service and tells You '
                  'about Your privacy rights and how the law protects You.\n\n'
                  'We use Your Personal data to provide and improve the Service. By using the '
                  'Service, You agree to the collection and use of information in accordance with '
                  'this Privacy Policy.',
            ),
            _buildSection(
              'Types of Data Collected',
              'Personal Data\n'
                  '• Email address\n'
                  '• First name and last name\n'
                  '• Phone number\n'
                  '• Usage Data\n\n'
                  'Usage Data is collected automatically when using the Service, including:\n'
                  '• Device\'s Internet Protocol address\n'
                  '• Browser type and version\n'
                  '• Pages visited and time spent\n'
                  '• Device identifiers and diagnostic data',
            ),
            _buildSection(
              'Use of Your Personal Data',
              'We may use Your Personal Data for:\n'
                  '• Providing and maintaining our Service\n'
                  '• Managing Your Account\n'
                  '• Contacting You\n'
                  '• Processing Your purchases\n'
                  '• Sending updates and offers\n'
                  '• Business transfers\n'
                  '• Data analysis and service improvement',
            ),
            _buildSection(
              'Data Retention',
              'We retain Your Personal Data only for as long as necessary for the purposes '
                  'set out in this Privacy Policy. We will retain and use Your Personal Data to '
                  'comply with our legal obligations, resolve disputes, and enforce our legal '
                  'agreements and policies.',
            ),
            _buildSection(
              'Children\'s Privacy',
              'Our Service does not address anyone under the age of 13. We do not knowingly '
                  'collect personally identifiable information from anyone under the age of 13.',
            ),
            _buildSection(
              'Contact Us',
              'If you have any questions about this Privacy Policy, You can contact us:\n\n'
                  'Email: kevinjobi.offical@gmail.com\n'
                  'Phone: 8086638332',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
