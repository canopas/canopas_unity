import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'error_const.dart';

extension ExceptionMessage on String {
  String errorMessage(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context);
    String msg = '';
    switch (this) {
      case userNotFoundError:
        msg = appLocale.user_not_found_error_message;
        break;
      case userDataNotUpdateError:
        msg = appLocale.user_data_not_update_error_message;
        break;
      case firesbaseAuthError:
        msg = appLocale.firebase_auth_error_message;
        break;
      case firestoreFetchDataError:
        msg = appLocale.firestore_fetch_data_error_message;
        break;
      case signOutError:
        msg = appLocale.sign_out_error_message;
        break;
      case invalidLeaveDateError:
        msg = appLocale.invalid_date_selection_error;
        break;
      case fillDetailsError:
        msg = appLocale.fill_all_details_error;
        break;
      case applyMinimumHalfDay:
        msg = appLocale.apply_leave_minimum_one_hour_error;
        break;
      case userAlreadyExists:
        msg = appLocale.add_member_employee_exists_error;
        break;
      case somethingWentWrongError:
        msg = appLocale.error_something_went_wrong;
        break;
      default:
        msg = appLocale.error_something_went_wrong;
        break;
    }
    return msg;
  }
}
