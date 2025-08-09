import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/custom_textfield.dart';
import 'package:vistacall/presentation/widgets/home/price_range_dialog.dart';
import 'package:vistacall/utils/constants.dart';

class SearchSection extends StatelessWidget {
  final Function(String)? onSearchChanged;
  const SearchSection({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FIND YOUR DOCTOR',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 275,
              child: CustomTextField(
                hintText: 'Search doctors, specialties...',
                prefixIcon: Icons.search,
                onChanged: onSearchChanged,
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  size: 36,
                ),
                onPressed: () {
                  showPriceRangeDialog(context);
                })
          ],
        ),
      ],
    );
  }
}
