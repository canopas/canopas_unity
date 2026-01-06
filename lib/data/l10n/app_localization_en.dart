// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get appTitle => 'Unity';

  @override
  String get sign_in_description_text =>
      'Help you to manage your office leaves and employees easily with unity.';

  @override
  String get sign_in_title_text => 'Effortless Leave\nManagement with Unity';

  @override
  String get google_login_button_text => 'Sign in with Google';

  @override
  String get apple_login_button_text => 'Sign in with Apple';

  @override
  String get settings_tag => 'Settings';

  @override
  String get members_tag => 'Members';

  @override
  String get leaves_tag => 'Leaves';

  @override
  String get recent_tag => 'Recent';

  @override
  String get past_tag => 'Past';

  @override
  String get upcoming_tag => 'Upcoming';

  @override
  String get deactivate_tag => 'Deactivate';

  @override
  String get activate_tag => 'Activate';

  @override
  String get delete_button_tag => 'Delete';

  @override
  String get save_tag => 'Save';

  @override
  String get edit_tag => 'Edit';

  @override
  String get reason_tag => 'Reason';

  @override
  String get details_tag => 'Details';

  @override
  String get sign_out_tag => 'Sign Out';

  @override
  String get update_tag => 'Update';

  @override
  String get or_tag => 'OR';

  @override
  String get space_tag => 'Space';

  @override
  String get next_tag => 'Next';

  @override
  String get back_tag => 'Back';

  @override
  String get add_tag => 'Add';

  @override
  String get request_tag => 'Requests';

  @override
  String get alert_cancel_action => 'Cancel';

  @override
  String get all_tag => 'All';

  @override
  String get ok_tag => 'OK';

  @override
  String get profile_tag => 'Profile';

  @override
  String get view_all_tag => 'View All';

  @override
  String get spaces_title => 'Spaces';

  @override
  String get delete_space_text => 'Delete Space';

  @override
  String get delete_dialog_description_text =>
      'Are you sure you want to permanently delete space?';

  @override
  String get change_space_tag => 'Change Space';

  @override
  String get company_name_tag => 'Company Name';

  @override
  String get create_space_Website_url_label => 'Website URL (Optional)';

  @override
  String get create_new_space_title => 'Create New Space';

  @override
  String get create_own_space_title => 'Want to create your own space?';

  @override
  String get welcome_to_unity_text => 'Welcome To Unity';

  @override
  String spaces_list_title(String email) {
    return 'Spaces for $email';
  }

  @override
  String get edit_space_button_tag => 'Edit Space';

  @override
  String get view_profile_button_tag => 'View Profile';

  @override
  String get empty_space_list_msg =>
      'Looks like you haven\'t been added to any organizations yet. Please contact your administrator to get started.';

  @override
  String get create_space_tag => 'Create Space';

  @override
  String get create_space_tab_1_tag => 'Space Details';

  @override
  String get create_space_tab_2_tag => 'Space SetUp';

  @override
  String get create_space_tab_3_tag => 'Personal Details';

  @override
  String get create_space_enter_space_details_text => 'Enter Space Details';

  @override
  String get create_space_set_up_your_space_text => 'Set up Your Space';

  @override
  String get create_space_enter_your_details_text => 'Enter Your Details';

  @override
  String get create_space_enter_your_name_hint_text => 'Your Name';

  @override
  String get create_space_invalid_time_off_error => 'Please enter valid input';

  @override
  String get create_space_invalid_name_error => 'Please enter valid name';

  @override
  String get create_space_invalid_website_url_error =>
      'Please enter valid website url';

  @override
  String get empty_change_space_title => 'No spaces';

  @override
  String get empty_change_space_description =>
      'You don\'t have any other space.';

  @override
  String days_placeholder_leave(int leave) {
    String _temp0 = intl.Intl.pluralLogic(
      leave,
      locale: localeName,
      other: '$leave Days Application',
      one: '$leave Day Application',
      zero: '$leave Day Application',
    );
    return '$_temp0';
  }

  @override
  String get page_not_found_error_code => '404';

  @override
  String get page_not_found_error_title => 'page not found!';

  @override
  String get page_not_found_error_message =>
      'It looks like we can\'t find the page you\'re looking for!';

  @override
  String leave_type_placeholder_text(String leaveType) {
    String _temp0 = intl.Intl.selectLogic(
      leaveType,
      {
        '0': 'Casual Leave',
        '1': 'Urgent Leave',
        'other': 'other',
      },
    );
    return '$_temp0';
  }

  @override
  String leave_status_placeholder_text(String leaveStatus) {
    String _temp0 = intl.Intl.selectLogic(
      leaveStatus,
      {
        '1': 'Pending',
        '2': 'Approved',
        '3': 'Rejected',
        '4': 'Cancelled',
        'other': 'other',
      },
    );
    return '$_temp0';
  }

  @override
  String user_detail_role_type(String role) {
    String _temp0 = intl.Intl.selectLogic(
      role,
      {
        'admin': 'Admin',
        'employee': 'Employee',
        'hr': 'HR',
        'other': 'other',
      },
    );
    return '$_temp0';
  }

  @override
  String get dateFormatter_yesterday => 'Yesterday';

  @override
  String get dateFormatter_today => 'Today';

  @override
  String get dateFormatter_just_now => 'Just now';

  @override
  String get dateFormatter_first_half_day => 'First Half Day';

  @override
  String get dateFormatter_second_half_day => 'Second Half Day';

  @override
  String get dateFormatter_full_day => 'Full Day';

  @override
  String dateFormatter_placeholder_other_days(double totalLeave) {
    final intl.NumberFormat totalLeaveNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalLeaveString = totalLeaveNumberFormat.format(totalLeave);

    return '$totalLeaveString Days';
  }

  @override
  String get year_tag => 'Year';

  @override
  String get year_ago_tag => 'year ago';

  @override
  String get years_ago_tag => 'years ago';

  @override
  String get month_ago_tag => 'month ago';

  @override
  String get months_ago_tag => 'months ago';

  @override
  String get week_ago_tag => 'week ago';

  @override
  String get weeks_ago_tag => 'weeks ago';

  @override
  String get day_ago_tag => 'day ago';

  @override
  String get days_ago_tag => 'days ago';

  @override
  String get hour_ago_tag => 'hour ago';

  @override
  String get hours_ago_tag => 'hours ago';

  @override
  String get minute_ago_tag => 'minute ago';

  @override
  String get minutes_ago_tag => 'minutes ago';

  @override
  String get dateFormatter_tomorrow => 'Tomorrow';

  @override
  String get date_formatter_leave_request_total_half_day_text =>
      'Total leave duration: half day';

  @override
  String get date_formatter_leave_request_total_zero_day_text =>
      'Total leave duration: 0 day';

  @override
  String get date_formatter_leave_request_total_one_day_text =>
      'Total leave duration 1 day';

  @override
  String date_formatter_leave_request_total_days_text(double day) {
    final intl.NumberFormat dayNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String dayString = dayNumberFormat.format(day);

    return 'Total leave duration: $dayString days';
  }

  @override
  String date_format_yMMMd(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String date_format_MMMd(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String date_format_yMMMM(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMM(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String leave_day_duration_tag(String dayDuration) {
    String _temp0 = intl.Intl.selectLogic(
      dayDuration,
      {
        'fullLeave': 'Full Leave',
        'firstHalfLeave': 'First-half',
        'secondHalfLeave': 'Second-half',
        'noLeave': 'No Leave',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String get leave_calendar_title => 'Leave Calendar';

  @override
  String get range_leave_calendar_title => 'User Leave Calendar';

  @override
  String calendar_no_leave_msg(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'There is no leave on $dateString';
  }

  @override
  String range_calendar_no_leave_msg(DateTime startDate, DateTime endDate) {
    final intl.DateFormat startDateDateFormat =
        intl.DateFormat.yMMMd(localeName);
    final String startDateString = startDateDateFormat.format(startDate);
    final intl.DateFormat endDateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String endDateString = endDateDateFormat.format(endDate);

    return 'There is no leave on\n$startDateString to $endDateString';
  }

  @override
  String get who_is_out_card_no_leave_present_title => 'All Hands on Deck';

  @override
  String get who_is_out_card_no_leave_present_message =>
      'Not a single beach umbrella in sight, all workstations full!';

  @override
  String get who_is_out_card_see_all_button_tag => 'See All';

  @override
  String get who_is_out_card_title => 'Who is out of office?';

  @override
  String get state_controller_access_revoked_alert_dialogue_title =>
      'Access revoked';

  @override
  String get state_controller_access_revoked_alert_dialogue_subtitle =>
      'You no longer have access to this space';

  @override
  String get empty_request_message => 'Everything is sorted out! Relax!!';

  @override
  String get empty_request_title => 'No Pending Leave Requests';

  @override
  String get admin_home_absence_tag => 'Absence';

  @override
  String get admin_home_invite_member_appbar_tag => 'Invite Member';

  @override
  String get invite_tag => 'Invite';

  @override
  String get admin_home_invite_member_hint_text => 'Add member by email';

  @override
  String get admin_home_invite_member_error_email => 'Please enter valid email';

  @override
  String get member_already_invited_error => 'Member already invited!';

  @override
  String get admin_home_add_member_error_email => 'Please enter valid email';

  @override
  String get admin_home_add_member_error_name => 'Name is too short!!';

  @override
  String get admin_home_add_member_complete_mandatory_field_error =>
      'Please complete this mandatory field';

  @override
  String get admin_home_add_member_employee_added_message =>
      'An employee has been added successfully!!';

  @override
  String get admin_home_add_member_submit_button_tag => 'Submit';

  @override
  String get admin_home_add_member_designation_tag => 'Designation';

  @override
  String get admin_home_add_member_addMember_tag => 'Add Member';

  @override
  String get admin_home_add_member_name_hint_text => 'Andrew Jhone';

  @override
  String get admin_home_add_member_employee_id_hint_text => 'CA 1001';

  @override
  String get admin_home_add_member_email_hint_text => 'andrew@canopas.com';

  @override
  String get admin_home_add_member_designation_hint_text => 'Android developer';

  @override
  String get admin_home_add_member_level_hint_text => 'SW-L1 Junior engineer';

  @override
  String get admin_home_add_member_mobile_number_hint_text => '+91 123456-7890';

  @override
  String get admin_home_add_member_blood_group_hint_text => 'B+';

  @override
  String get admin_home_add_member_address_hint_text =>
      '552_554, Laxmi Enclave-2, Katargam, surat-395004';

  @override
  String get event_card_title => 'Celebrations of the Week';

  @override
  String get birthdays_tag => 'Birthdays';

  @override
  String get work_anniversaries_tag => 'Work Anniversary';

  @override
  String get no_event_text => 'No festivities on the calendar this week';

  @override
  String upcoming_birthday_text(String name) {
    return '$name\'s birthday is coming up on';
  }

  @override
  String present_birthday_text(String name) {
    return 'Today is $name\'s birthday 🥳🥳! Let\'s make it sparkle with cheerful wishes!';
  }

  @override
  String upcoming_anniversary_text(String name, int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$name will have successfully completed $years years with us on',
      one: '$name will have successfully completed $years year with us on',
    );
    return '$_temp0';
  }

  @override
  String present_anniversary_text(String name, int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other:
          'Congratulations on $years years with us $name 💐💐! Keep up the good work!',
      one:
          'Congratulations on $years year with us $name 💐💐! Keep up the good work!',
    );
    return '$_temp0';
  }

  @override
  String get search_employee_tag => 'Search employee';

  @override
  String get empty_leaves_message => 'There is no any leaves, yet';

  @override
  String get admin_leave_detail_enter_reason_tag => 'Enter Message';

  @override
  String get admin_leave_detail_note_tag => 'Note';

  @override
  String get admin_leave_detail_reject_button_tag => 'Reject';

  @override
  String get admin_leave_detail_approve_button_tag => 'Approve';

  @override
  String get admin_employee_detail_profile_tag => 'Profile';

  @override
  String get admin_employees_detail_time_off_tag => 'Time Off';

  @override
  String get invited_members_title => 'Invited members';

  @override
  String get inactive_members_title => 'Inactive members';

  @override
  String get admin_setting_update_leave_total_leaves_tag => 'Total Leaves';

  @override
  String get yearly_paid_time_off_tag => 'Yearly Paid Time-Off';

  @override
  String get hr_leave_record_tag => 'Leave Record';

  @override
  String get leave_notification_email_tag => 'Leave notification email';

  @override
  String get user_leave_apply_tag => 'Apply';

  @override
  String get user_leave_used_leaves_tag => 'Used Leaves';

  @override
  String get user_leave_past_leaves_tag => 'Past Leaves';

  @override
  String get user_leave_upcoming_leaves_tag => 'Upcoming Leaves';

  @override
  String get user_leave_show_less_tag => 'Show less';

  @override
  String get user_leave_view_more_tag => 'View more';

  @override
  String get no_leaves_tag => 'No Leaves!';

  @override
  String get user_leave_empty_screen_message => 'Are you secretly a superhero?';

  @override
  String get user_leaves_apply_appbar_tag => 'Leave Request';

  @override
  String get user_leaves_apply_enter_reason_tag => 'Enter reason';

  @override
  String get user_leaves_apply_leave_type_tag => 'Type';

  @override
  String get user_leaves_apply_leave_start_tag => 'Start';

  @override
  String get user_leaves_apply_leave_end_tag => 'End';

  @override
  String get user_leaves_apply_leave_button_tag => 'Apply Leave';

  @override
  String get user_leaves_apply_leave_error_message_fill_details =>
      'Please fill all details';

  @override
  String get user_leaves_apply_leave_error_valid_reason =>
      ' • Please enter valid reason';

  @override
  String get user_leaves_apply_leave_success_message =>
      'You\'ve successfully applied!';

  @override
  String get cancel_button_tag => 'Cancel';

  @override
  String get cancel_leave_message => 'Leave is cancelled successfully!';

  @override
  String get user_settings_edit_select_tag => 'Select';

  @override
  String get user_setting_camera_tag => 'Camera';

  @override
  String get user_setting_gallery_tag => 'Gallery';

  @override
  String get employee_designation_tag => 'Designation';

  @override
  String get employee_blood_group_tag => 'Blood Group';

  @override
  String get employee_role_tag => 'Role';

  @override
  String get employee_mobile_tag => 'Mobile';

  @override
  String get employee_email_tag => 'Email';

  @override
  String get employee_address_tag => 'Address';

  @override
  String get employee_gender_tag => 'Gender';

  @override
  String get employee_dateOfBirth_tag => 'Date Of Birth';

  @override
  String get employee_dateOfJoin_tag => 'Date of Joining';

  @override
  String get employee_level_tag => 'Level';

  @override
  String get employee_employeeID_tag => 'Employee ID';

  @override
  String get employee_name_tag => 'Name';

  @override
  String get admin_leave_detail_button_reject => 'Reject';

  @override
  String get admin_leave_detail_button_approve => 'Approve';

  @override
  String get admin_leave_detail_button_ok => 'OK';

  @override
  String get admin_leave_detail_daysLeft_tag => 'Days left';

  @override
  String get admin_leave_empty_screen_message => 'No any Leaves, yet!';

  @override
  String get gender_male_tag => 'Male';

  @override
  String get gender_female_tag => 'Female';

  @override
  String user_details_gender(num gender) {
    String _temp0 = intl.Intl.pluralLogic(
      gender,
      locale: localeName,
      other: 'Other',
      two: 'Female',
      one: 'Male',
    );
    return '$_temp0';
  }

  @override
  String get create_form_screen_title => 'New Form';

  @override
  String get title_tag => 'Title';

  @override
  String get description_tag => 'Description';

  @override
  String get create_from_limit_to_1_response_text => 'Limit To 1 Response';

  @override
  String get question_tag => 'Question';

  @override
  String get options_tag => 'Options';

  @override
  String get question_text_field_hint_text => 'Enter Question';

  @override
  String get remove_tag => 'Remove';

  @override
  String get type_tag => 'Type';

  @override
  String get required_tag => 'Required';

  @override
  String get create_tag => 'Create';

  @override
  String get create_form_success_message =>
      ' form has been created successfully';

  @override
  String get forms_title => 'Forms';

  @override
  String get responses_tag => 'Responses';

  @override
  String get fill_up_tag => 'Fill-up';

  @override
  String get form_list_empty_screen_title => 'No forms';

  @override
  String get form_list_empty_screen_message => 'Oops, No Forms Here!';

  @override
  String org_form_answer_type(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        '0': 'Text',
        '1': 'Boolean',
        '2': 'Date',
        '3': 'Time',
        '4': 'Drop-down',
        '5': 'Checkboxes',
        '6': 'File upload',
        '7': 'None',
        'other': 'other',
      },
    );
    return '$_temp0';
  }

  @override
  String get network_connection_error =>
      'Please check your Internet connection';

  @override
  String get user_not_found_error_message =>
      'User with this email doesn\'t exist, Please ask your manager to add it';

  @override
  String get user_data_not_update_error_message =>
      'Error in Updating your account information, Please check that you have signed in correct account';

  @override
  String get firestore_fetch_data_error_message => 'Something went wrong';

  @override
  String get firebase_auth_error_message =>
      'Error occurred while Google sign in. Try again';

  @override
  String get sign_out_error_message =>
      'Your attempt to sign out failed,Please try again later';

  @override
  String get error_something_went_wrong => 'Something went wrong';

  @override
  String get fill_all_details_error => 'Please fill all details';

  @override
  String get fill_require_details_error => 'Please fill required details!';

  @override
  String get invalid_date_selection_error => 'Please select valid date';

  @override
  String get apply_leave_minimum_one_hour_error =>
      'Please apply leave for minimum half day';

  @override
  String get invalid_mobile_number_error => 'Please enter valid phone number';

  @override
  String get add_member_employee_exists_error => 'Member already exists!';

  @override
  String get leave_already_applied_error_message =>
      'Leave request has been already applied!';

  @override
  String get provide_required_information =>
      'Please provide the required information to continue';

  @override
  String get apple_sign_in_error_message =>
      'Oops! It looks like you haven\'t granted permission to access your email. Please check and grant permission to access your email address';

  @override
  String get sign_out_alert => 'Are you sure you want to sign out?';

  @override
  String get setup_profile_title => 'Setup Profile';

  @override
  String get submit_button_tag => 'Submit';

  @override
  String deactivate_user_account_alert(String username) {
    return 'Are you sure you want to deactivate $username\'s account? This action cannot be undone.';
  }

  @override
  String get remove_user_leave_alert =>
      'Are you sure you want to cancel this leave?';

  @override
  String employee_empty_leave_message(String name) {
    return '$name don\'t have any leaves yet!';
  }

  @override
  String sign_out_from_text(String text) {
    return 'Sign out from $text';
  }

  @override
  String employee_details_leaves_title(String name) {
    return '$name\'s Leaves';
  }
}
