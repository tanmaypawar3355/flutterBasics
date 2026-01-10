import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_38/services/navigation_service.dart';

class AlertService {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  AlertService() {
    _navigationService = _getIt.get<NavigationService>();
  }

  void showToast({required String text, IconData icon = Icons.info}) {
    DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      builder: (context) {
        return ToastCard(
          title: Text(text),
          color: Colors.white,
          shadowColor: Colors.grey[300],
          leading: Icon(icon),
        );
      },
    ).show(_navigationService.navigationKey.currentContext!);
  }
}
