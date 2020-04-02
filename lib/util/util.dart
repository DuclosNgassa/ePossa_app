import 'package:epossa_app/model/userRole.dart';
import 'package:epossa_app/model/user_status.dart';
import 'package:flutter/material.dart';

class Util {
  static fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String convertStatusToString(UserStatus value) {
    switch (value) {
      case UserStatus.active:
        {
          return 'active';
        }
        break;
      case UserStatus.blocked:
        {
          return 'blocked';
        }
        break;
      case UserStatus.pending:
        {
          return 'pending';
        }
        break;
    }
    return 'blocked';
  }

  static UserStatus convertStringToStatus(String value) {
    switch (value) {
      case 'active':
        {
          return UserStatus.active;
        }
        break;
      case 'blocked':
        {
          return UserStatus.blocked;
        }
        break;
      case 'pending':
        {
          return UserStatus.pending;
        }
        break;
    }
    return UserStatus.blocked;
  }

  static String convertRoleToString(UserRole value) {
    switch (value) {
      case UserRole.admin:
        {
          return 'admin';
        }
        break;
      case UserRole.user:
        {
          return 'user';
        }
        break;
    }
    return 'user';
  }

  static UserRole convertStringToRole(String value) {
    switch (value) {
      case 'admin':
        {
          return UserRole.admin;
        }
        break;
      case 'user':
        {
          return UserRole.user;
        }
        break;
    }
    return UserRole.user;
  }
}
