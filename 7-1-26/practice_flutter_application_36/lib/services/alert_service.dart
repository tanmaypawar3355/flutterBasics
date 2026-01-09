import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_36/services/navigation_service.dart';

class AlertService {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;

  AlertService() {
    _navigationService = _getIt.get<NavigationService>();
  }

  void showToast({required String message, IconData icon = Icons.info}) {
    DelightToastBar(
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) {
        return ToastCard(
          title: Text(message, style: TextStyle(fontSize: 20)),
          leading: Icon(icon),
        );
      },
    ).show(_navigationService.navigationKey.currentContext!);
  }
}
