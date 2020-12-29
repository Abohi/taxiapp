import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_bloc.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/screen_controllers/hitchyke_dashboard_ui_controller.dart';
import 'package:hitchyke/ui/views/complete_profile/driverbio_data.dart';
import 'package:hitchyke/ui/views/complete_profile/vehicle_information.dart';
import 'package:hitchyke/ui/views/login_view/login_view.dart';
import 'package:hitchyke/ui/views/register_view/register_role_view.dart';
import 'package:hitchyke/ui/views/splash.dart';
import 'package:hitchyke/ui/views/verification_view/verification_view.dart';
import 'package:provider/provider.dart';

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Authenticated:
        return  BlocProvider(
          create: (context) => HitchykeDashBoardBloc(),
          child: HitchykeDashBoardUIController(),
        );

      case Status.Unauthenticated:
        return LoginView();
        break;
      case Status.EmailNotVerified:
        return  VerificationView();
        break;
      case Status.BioDataNotSet:
        return  RegisterRoleView();
      case Status.OtherBioDataNotSet:
        return  VehicleInformation(name: auth.name, roleType: auth.roleType, profilePhoto: auth.profilePhoto);
        break;
      default:
        return LoginView();
    }
  }
}