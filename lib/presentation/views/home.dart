import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vistacall/bloc/home/home_bloc.dart';
import 'package:vistacall/bloc/doctor_list/doctor_list_bloc.dart';
import 'package:vistacall/presentation/views/home/home_body.dart';
import 'package:vistacall/presentation/widgets/custom_widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/views/home/home_app_bar.dart';
import 'package:vistacall/viewmodels/home_viewmodel.dart';
import 'package:vistacall/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        BlocProvider.of<HomeBloc>(context),
        BlocProvider.of<DoctorListBloc>(context),
      ),
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: const HomeBody(),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 0,
          onTap: (index) => _handleNavigation(index, context),
        ),
      ),
    );
  }

  static void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 1:
        Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppConstants.messagesRoute);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
        break;
    }
  }
}
