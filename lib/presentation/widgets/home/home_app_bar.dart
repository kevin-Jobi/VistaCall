import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConstants.primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 55),
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 5),
              DropdownButton<String>(
                value: 'Bangalore',
                dropdownColor: AppConstants.primaryColor,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                underline: Container(),
                items:
                    <String>[
                      'Bangalore',
                      'Mumbai',
                      'Delhi',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(
              icon: const Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.profileRoute);
              },
            ),
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
