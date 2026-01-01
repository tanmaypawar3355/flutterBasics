import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import "package:delightful_toast/delight_toast.dart";
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_31/services/navigation_service.dart';

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
          shadowColor: Colors.grey[400],
          title: Text(text),
          leading: Icon(icon),
        );
      },
    ).show(_navigationService.navigationKey.currentContext!);
  }
}
