import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_event.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_state.dart';

void showPriceRangeDialog(BuildContext context) {
  final List<String> priceRanges = [
    '100 - 500',
    '500 - 1000',
    '1000 - 2000',
    '2000 - 3000',
    '3000+',
  ];

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Expanded(child: Text('Select Price Range')),
              IconButton(
                  onPressed: () {
                    context.read<DoctorListBloc>().add(FilteredDoctorsByPrice(''));
                    Navigator.pop(context);
                  },
                  tooltip: 'Reset',
                  icon: const Icon(Icons.refresh))
            ],
          ),
          content: BlocBuilder<DoctorListBloc, DoctorListState>(
              builder: (context, state) {
            String? selected =
                (state is DoctorListLoaded) ? state.selectedPriceRange : null;
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: priceRanges.map((range) {
                  return RadioListTile<String>(
                      title: Text(range),
                      value: range,
                      groupValue: selected,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<DoctorListBloc>()
                              .add(FilteredDoctorsByPrice(value));
                          Navigator.pop(context);
                        }
                      });
                }).toList());
          }),
        );
      });
}
