import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_34/services/navigation_service.dart';

class AlertService {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  AlertService() {
    _navigationService = _getIt.get<NavigationService>();
  }

  Future<void> showToast({
    required String text,
    IconData icon = Icons.info,
  }) async {
    DelightToastBar(
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) {
        return ToastCard(
          title: Text(text, style: TextStyle(fontSize: 15)),
          leading: Icon(icon),
        );
      },
    ).show(_navigationService.navigationKey.currentContext!);
  }
}
