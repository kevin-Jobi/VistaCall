import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';
import 'package:vistacall/utils/constants.dart';

void showPriceRangeDialog(BuildContext context) {
  final List<Map<String, dynamic>> priceRanges = [
    {'range': '100 - 500', 'icon': Icons.attach_money},
    {'range': '500 - 1000', 'icon': Icons.payments_outlined},
    {'range': '1000 - 2000', 'icon': Icons.account_balance_wallet_outlined},
    {'range': '2000 - 3000', 'icon': Icons.credit_card},
    {'range': '3000+', 'icon': Icons.diamond_outlined},
  ];

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(dialogContext).size.height * 0.7,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(dialogContext),
              Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 8),
                      child:
                          _buildContent(context, priceRanges, dialogContext))),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildHeader(BuildContext dialogContext) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppConstants.primaryColor.withOpacity(0.1),
          AppConstants.primaryColor.withOpacity(0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppConstants.primaryColor,
                AppConstants.primaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.filter_list_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Price',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Select your budget range',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(dialogContext),
            icon: Icon(
              Icons.close_rounded,
              color: Colors.grey[700],
              size: 22,
            ),
            padding: const EdgeInsets.all(6),
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildContent(BuildContext context,
    List<Map<String, dynamic>> priceRanges, BuildContext dialogContext) {
  return BlocBuilder<DoctorListBloc, DoctorListState>(
    builder: (context, state) {
      String? selected =
          (state is DoctorListLoaded) ? state.selectedPriceRange : null;

      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...priceRanges.map((item) {
              final range = item['range'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = selected == range;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildPriceOption(
                  context: context,
                  dialogContext: dialogContext,
                  range: range,
                  icon: icon,
                  isSelected: isSelected,
                ),
              );
            }).toList(),
            const SizedBox(height: 8),
            _buildResetButton(context, dialogContext),
          ],
        ),
      );
    },
  );
}

Widget _buildPriceOption({
  required BuildContext context,
  required BuildContext dialogContext,
  required String range,
  required IconData icon,
  required bool isSelected,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        context.read<DoctorListBloc>().add(FilteredDoctorsByPrice(range));
        Navigator.pop(dialogContext);
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryColor.withOpacity(0.1)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppConstants.primaryColor : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppConstants.primaryColor.withOpacity(0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color:
                    isSelected ? AppConstants.primaryColor : Colors.grey[600],
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                '₹$range',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppConstants.primaryColor
                      : const Color(0xFF2C2C2C),
                  letterSpacing: 0.2,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              )
            else
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[400]!,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildResetButton(BuildContext context, BuildContext dialogContext) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.grey[100]!,
          Colors.grey[50]!,
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Colors.grey[300]!,
        width: 1,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<DoctorListBloc>().add(FilteredDoctorsByPrice(''));
          Navigator.pop(dialogContext);
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh_rounded,
                color: Colors.grey[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Reset Filter',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
// import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';

// void showPriceRangeDialog(BuildContext context) {
//   final List<String> priceRanges = [
//     '100 - 500',
//     '500 - 1000',
//     '1000 - 2000',
//     '2000 - 3000',
//     '3000+',
//   ];

//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               const Expanded(child: Text('Select Price Range')),
//               IconButton(
//                   onPressed: () {
//                     context.read<DoctorListBloc>().add(FilteredDoctorsByPrice(''));
//                     Navigator.pop(context);
//                   },
//                   tooltip: 'Reset',
//                   icon: const Icon(Icons.refresh))
//             ],
//           ),
//           content: BlocBuilder<DoctorListBloc, DoctorListState>(
//               builder: (context, state) {
//             String? selected =
//                 (state is DoctorListLoaded) ? state.selectedPriceRange : null;
//             return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: priceRanges.map((range) {
//                   return RadioListTile<String>(
//                       title: Text(range),
//                       value: range,
//                       groupValue: selected,
//                       onChanged: (value) {
//                         if (value != null) {
//                           context
//                               .read<DoctorListBloc>()
//                               .add(FilteredDoctorsByPrice(value));
//                           Navigator.pop(context);
//                         }
//                       });
//                 }).toList());
//           }),
//         );
//       });
// }
