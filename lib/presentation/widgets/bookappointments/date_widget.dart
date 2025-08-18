import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget{
  final DateTime date;
  final int availableSlots;
  final bool isSelected;

const DateWidget({
  Key? key,
  required this.date,
  required this.availableSlots,
  this.isSelected = false
}) :super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
    width: 150,
    margin:  EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isSelected ? Colors.blue : Colors.transparent,
        width: 2 
      )
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _getDayDescription(date),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black
          ),
        ),
        const SizedBox(height: 4,),
        Text('${date.day} ${_getMonthAbbreviation(date.month)}',
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black
        ),
        ),
        const SizedBox(height: 8,),
        Text('$availableSlots slots available',
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.white : Colors.grey[600]
        ),
        )
      ],
    )
    
   );
   
  }
}

  String _getDayDescription(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Today';
    } else if (date.day == now.day + 1 && date.month == now.month && date.year == now.year) {
      return 'Tomorrow';
    } else {
      return _getWeekdayAbbreviation(date.weekday);
    }
  }

    String _getWeekdayAbbreviation(int weekday) {
    const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbreviations[weekday - 1];
  }

    String _getMonthAbbreviation(int month) {
    const abbreviations = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return abbreviations[month - 1];
  }