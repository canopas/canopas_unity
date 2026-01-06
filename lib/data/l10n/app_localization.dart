import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Unity'**
  String get appTitle;

  /// No description provided for @sign_in_description_text.
  ///
  /// In en, this message translates to:
  /// **'Help you to manage your office leaves and employees easily with unity.'**
  String get sign_in_description_text;

  /// No description provided for @sign_in_title_text.
  ///
  /// In en, this message translates to:
  /// **'Effortless Leave\nManagement with Unity'**
  String get sign_in_title_text;

  /// No description provided for @google_login_button_text.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get google_login_button_text;

  /// No description provided for @apple_login_button_text.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get apple_login_button_text;

  /// No description provided for @settings_tag.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_tag;

  /// No description provided for @members_tag.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members_tag;

  /// No description provided for @leaves_tag.
  ///
  /// In en, this message translates to:
  /// **'Leaves'**
  String get leaves_tag;

  /// No description provided for @recent_tag.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent_tag;

  /// No description provided for @past_tag.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past_tag;

  /// No description provided for @upcoming_tag.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming_tag;

  /// No description provided for @deactivate_tag.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate_tag;

  /// No description provided for @activate_tag.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate_tag;

  /// No description provided for @delete_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete_button_tag;

  /// No description provided for @save_tag.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save_tag;

  /// No description provided for @edit_tag.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit_tag;

  /// No description provided for @reason_tag.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason_tag;

  /// No description provided for @details_tag.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details_tag;

  /// No description provided for @sign_out_tag.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out_tag;

  /// No description provided for @update_tag.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update_tag;

  /// No description provided for @or_tag.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or_tag;

  /// No description provided for @space_tag.
  ///
  /// In en, this message translates to:
  /// **'Space'**
  String get space_tag;

  /// No description provided for @next_tag.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next_tag;

  /// No description provided for @back_tag.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_tag;

  /// No description provided for @add_tag.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add_tag;

  /// No description provided for @request_tag.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get request_tag;

  /// No description provided for @alert_cancel_action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get alert_cancel_action;

  /// No description provided for @all_tag.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_tag;

  /// No description provided for @ok_tag.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok_tag;

  /// No description provided for @profile_tag.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_tag;

  /// No description provided for @view_all_tag.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all_tag;

  /// No description provided for @spaces_title.
  ///
  /// In en, this message translates to:
  /// **'Spaces'**
  String get spaces_title;

  /// No description provided for @delete_space_text.
  ///
  /// In en, this message translates to:
  /// **'Delete Space'**
  String get delete_space_text;

  /// No description provided for @delete_dialog_description_text.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete space?'**
  String get delete_dialog_description_text;

  /// No description provided for @change_space_tag.
  ///
  /// In en, this message translates to:
  /// **'Change Space'**
  String get change_space_tag;

  /// No description provided for @company_name_tag.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get company_name_tag;

  /// No description provided for @create_space_Website_url_label.
  ///
  /// In en, this message translates to:
  /// **'Website URL (Optional)'**
  String get create_space_Website_url_label;

  /// No description provided for @create_new_space_title.
  ///
  /// In en, this message translates to:
  /// **'Create New Space'**
  String get create_new_space_title;

  /// No description provided for @create_own_space_title.
  ///
  /// In en, this message translates to:
  /// **'Want to create your own space?'**
  String get create_own_space_title;

  /// No description provided for @welcome_to_unity_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Unity'**
  String get welcome_to_unity_text;

  /// No description provided for @spaces_list_title.
  ///
  /// In en, this message translates to:
  /// **'Spaces for {email}'**
  String spaces_list_title(String email);

  /// No description provided for @edit_space_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Edit Space'**
  String get edit_space_button_tag;

  /// No description provided for @view_profile_button_tag.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get view_profile_button_tag;

  /// No description provided for @empty_space_list_msg.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t been added to any organizations yet. Please contact your administrator to get started.'**
  String get empty_space_list_msg;

  /// No description provided for @create_space_tag.
  ///
  /// In en, this message translates to:
  /// **'Create Space'**
  String get create_space_tag;

  /// No description provided for @create_space_tab_1_tag.
  ///
  /// In en, this message translates to:
  /// **'Space Details'**
  String get create_space_tab_1_tag;

  /// No description provided for @create_space_tab_2_tag.
  ///
  /// In en, this message translates to:
  /// **'Space SetUp'**
  String get create_space_tab_2_tag;

  /// No description provided for @create_space_tab_3_tag.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get create_space_tab_3_tag;

  /// No description provided for @create_space_enter_space_details_text.
  ///
  /// In en, this message translates to:
  /// **'Enter Space Details'**
  String get create_space_enter_space_details_text;

  /// No description provided for @create_space_set_up_your_space_text.
  ///
  /// In en, this message translates to:
  /// **'Set up Your Space'**
  String get create_space_set_up_your_space_text;

  /// No description provided for @create_space_enter_your_details_text.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Details'**
  String get create_space_enter_your_details_text;

  /// No description provided for @create_space_enter_your_name_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get create_space_enter_your_name_hint_text;

  /// No description provided for @create_space_invalid_time_off_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid input'**
  String get create_space_invalid_time_off_error;

  /// No description provided for @create_space_invalid_name_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid name'**
  String get create_space_invalid_name_error;

  /// No description provided for @create_space_invalid_website_url_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid website url'**
  String get create_space_invalid_website_url_error;

  /// No description provided for @empty_change_space_title.
  ///
  /// In en, this message translates to:
  /// **'No spaces'**
  String get empty_change_space_title;

  /// No description provided for @empty_change_space_description.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any other space.'**
  String get empty_change_space_description;

  /// Pass the value of leaves for leave days
  ///
  /// In en, this message translates to:
  /// **'{leave,plural,=0{{leave} Day Application} =1{{leave} Day Application} other{{leave} Days Application}}'**
  String days_placeholder_leave(int leave);

  /// No description provided for @page_not_found_error_code.
  ///
  /// In en, this message translates to:
  /// **'404'**
  String get page_not_found_error_code;

  /// No description provided for @page_not_found_error_title.
  ///
  /// In en, this message translates to:
  /// **'page not found!'**
  String get page_not_found_error_title;

  /// No description provided for @page_not_found_error_message.
  ///
  /// In en, this message translates to:
  /// **'It looks like we can\'t find the page you\'re looking for!'**
  String get page_not_found_error_message;

  /// get leave type from leave status
  ///
  /// In en, this message translates to:
  /// **'{leaveType, select, 0{Casual Leave} 1{Urgent Leave} other{other}}'**
  String leave_type_placeholder_text(String leaveType);

  /// get leave type from leave status
  ///
  /// In en, this message translates to:
  /// **'{leaveStatus, select, 1{Pending} 2{Approved} 3{Rejected} 4{Cancelled} other{other}}'**
  String leave_status_placeholder_text(String leaveStatus);

  /// Pass the value of role to get role of user
  ///
  /// In en, this message translates to:
  /// **'{role, select, admin{Admin} employee{Employee} hr{HR} other{other}}'**
  String user_detail_role_type(String role);

  /// No description provided for @dateFormatter_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateFormatter_yesterday;

  /// No description provided for @dateFormatter_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateFormatter_today;

  /// No description provided for @dateFormatter_just_now.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get dateFormatter_just_now;

  /// No description provided for @dateFormatter_first_half_day.
  ///
  /// In en, this message translates to:
  /// **'First Half Day'**
  String get dateFormatter_first_half_day;

  /// No description provided for @dateFormatter_second_half_day.
  ///
  /// In en, this message translates to:
  /// **'Second Half Day'**
  String get dateFormatter_second_half_day;

  /// No description provided for @dateFormatter_full_day.
  ///
  /// In en, this message translates to:
  /// **'Full Day'**
  String get dateFormatter_full_day;

  /// define total leave count more than one day
  ///
  /// In en, this message translates to:
  /// **'{totalLeave} Days'**
  String dateFormatter_placeholder_other_days(double totalLeave);

  /// No description provided for @year_tag.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year_tag;

  /// No description provided for @year_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'year ago'**
  String get year_ago_tag;

  /// No description provided for @years_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'years ago'**
  String get years_ago_tag;

  /// No description provided for @month_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'month ago'**
  String get month_ago_tag;

  /// No description provided for @months_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'months ago'**
  String get months_ago_tag;

  /// No description provided for @week_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'week ago'**
  String get week_ago_tag;

  /// No description provided for @weeks_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'weeks ago'**
  String get weeks_ago_tag;

  /// No description provided for @day_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'day ago'**
  String get day_ago_tag;

  /// No description provided for @days_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'days ago'**
  String get days_ago_tag;

  /// No description provided for @hour_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'hour ago'**
  String get hour_ago_tag;

  /// No description provided for @hours_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'hours ago'**
  String get hours_ago_tag;

  /// No description provided for @minute_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'minute ago'**
  String get minute_ago_tag;

  /// No description provided for @minutes_ago_tag.
  ///
  /// In en, this message translates to:
  /// **'minutes ago'**
  String get minutes_ago_tag;

  /// No description provided for @dateFormatter_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dateFormatter_tomorrow;

  /// No description provided for @date_formatter_leave_request_total_half_day_text.
  ///
  /// In en, this message translates to:
  /// **'Total leave duration: half day'**
  String get date_formatter_leave_request_total_half_day_text;

  /// No description provided for @date_formatter_leave_request_total_zero_day_text.
  ///
  /// In en, this message translates to:
  /// **'Total leave duration: 0 day'**
  String get date_formatter_leave_request_total_zero_day_text;

  /// No description provided for @date_formatter_leave_request_total_one_day_text.
  ///
  /// In en, this message translates to:
  /// **'Total leave duration 1 day'**
  String get date_formatter_leave_request_total_one_day_text;

  /// No description provided for @date_formatter_leave_request_total_days_text.
  ///
  /// In en, this message translates to:
  /// **'Total leave duration: {day} days'**
  String date_formatter_leave_request_total_days_text(double day);

  /// No description provided for @date_format_yMMMd.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String date_format_yMMMd(DateTime date);

  /// No description provided for @date_format_MMMd.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String date_format_MMMd(DateTime date);

  /// No description provided for @date_format_yMMMM.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String date_format_yMMMM(DateTime date);

  /// Pass name of LeaveDayDuration enum for get string
  ///
  /// In en, this message translates to:
  /// **'{dayDuration, select, fullLeave{Full Leave} firstHalfLeave{First-half} secondHalfLeave{Second-half} noLeave{No Leave} other{Other}}'**
  String leave_day_duration_tag(String dayDuration);

  /// No description provided for @leave_calendar_title.
  ///
  /// In en, this message translates to:
  /// **'Leave Calendar'**
  String get leave_calendar_title;

  /// No description provided for @range_leave_calendar_title.
  ///
  /// In en, this message translates to:
  /// **'User Leave Calendar'**
  String get range_leave_calendar_title;

  /// No description provided for @calendar_no_leave_msg.
  ///
  /// In en, this message translates to:
  /// **'There is no leave on {date}'**
  String calendar_no_leave_msg(DateTime date);

  /// No description provided for @range_calendar_no_leave_msg.
  ///
  /// In en, this message translates to:
  /// **'There is no leave on\n{startDate} to {endDate}'**
  String range_calendar_no_leave_msg(DateTime startDate, DateTime endDate);

  /// No description provided for @who_is_out_card_no_leave_present_title.
  ///
  /// In en, this message translates to:
  /// **'All Hands on Deck'**
  String get who_is_out_card_no_leave_present_title;

  /// No description provided for @who_is_out_card_no_leave_present_message.
  ///
  /// In en, this message translates to:
  /// **'Not a single beach umbrella in sight, all workstations full!'**
  String get who_is_out_card_no_leave_present_message;

  /// No description provided for @who_is_out_card_see_all_button_tag.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get who_is_out_card_see_all_button_tag;

  /// No description provided for @who_is_out_card_title.
  ///
  /// In en, this message translates to:
  /// **'Who is out of office?'**
  String get who_is_out_card_title;

  /// No description provided for @state_controller_access_revoked_alert_dialogue_title.
  ///
  /// In en, this message translates to:
  /// **'Access revoked'**
  String get state_controller_access_revoked_alert_dialogue_title;

  /// No description provided for @state_controller_access_revoked_alert_dialogue_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You no longer have access to this space'**
  String get state_controller_access_revoked_alert_dialogue_subtitle;

  /// No description provided for @empty_request_message.
  ///
  /// In en, this message translates to:
  /// **'Everything is sorted out! Relax!!'**
  String get empty_request_message;

  /// No description provided for @empty_request_title.
  ///
  /// In en, this message translates to:
  /// **'No Pending Leave Requests'**
  String get empty_request_title;

  /// No description provided for @admin_home_absence_tag.
  ///
  /// In en, this message translates to:
  /// **'Absence'**
  String get admin_home_absence_tag;

  /// No description provided for @admin_home_invite_member_appbar_tag.
  ///
  /// In en, this message translates to:
  /// **'Invite Member'**
  String get admin_home_invite_member_appbar_tag;

  /// No description provided for @invite_tag.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite_tag;

  /// No description provided for @admin_home_invite_member_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Add member by email'**
  String get admin_home_invite_member_hint_text;

  /// No description provided for @admin_home_invite_member_error_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get admin_home_invite_member_error_email;

  /// No description provided for @member_already_invited_error.
  ///
  /// In en, this message translates to:
  /// **'Member already invited!'**
  String get member_already_invited_error;

  /// No description provided for @admin_home_add_member_error_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get admin_home_add_member_error_email;

  /// No description provided for @admin_home_add_member_error_name.
  ///
  /// In en, this message translates to:
  /// **'Name is too short!!'**
  String get admin_home_add_member_error_name;

  /// No description provided for @admin_home_add_member_complete_mandatory_field_error.
  ///
  /// In en, this message translates to:
  /// **'Please complete this mandatory field'**
  String get admin_home_add_member_complete_mandatory_field_error;

  /// No description provided for @admin_home_add_member_employee_added_message.
  ///
  /// In en, this message translates to:
  /// **'An employee has been added successfully!!'**
  String get admin_home_add_member_employee_added_message;

  /// No description provided for @admin_home_add_member_submit_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get admin_home_add_member_submit_button_tag;

  /// No description provided for @admin_home_add_member_designation_tag.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get admin_home_add_member_designation_tag;

  /// No description provided for @admin_home_add_member_addMember_tag.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get admin_home_add_member_addMember_tag;

  /// No description provided for @admin_home_add_member_name_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Andrew Jhone'**
  String get admin_home_add_member_name_hint_text;

  /// No description provided for @admin_home_add_member_employee_id_hint_text.
  ///
  /// In en, this message translates to:
  /// **'CA 1001'**
  String get admin_home_add_member_employee_id_hint_text;

  /// No description provided for @admin_home_add_member_email_hint_text.
  ///
  /// In en, this message translates to:
  /// **'andrew@canopas.com'**
  String get admin_home_add_member_email_hint_text;

  /// No description provided for @admin_home_add_member_designation_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Android developer'**
  String get admin_home_add_member_designation_hint_text;

  /// No description provided for @admin_home_add_member_level_hint_text.
  ///
  /// In en, this message translates to:
  /// **'SW-L1 Junior engineer'**
  String get admin_home_add_member_level_hint_text;

  /// No description provided for @admin_home_add_member_mobile_number_hint_text.
  ///
  /// In en, this message translates to:
  /// **'+91 123456-7890'**
  String get admin_home_add_member_mobile_number_hint_text;

  /// No description provided for @admin_home_add_member_blood_group_hint_text.
  ///
  /// In en, this message translates to:
  /// **'B+'**
  String get admin_home_add_member_blood_group_hint_text;

  /// No description provided for @admin_home_add_member_address_hint_text.
  ///
  /// In en, this message translates to:
  /// **'552_554, Laxmi Enclave-2, Katargam, surat-395004'**
  String get admin_home_add_member_address_hint_text;

  /// No description provided for @event_card_title.
  ///
  /// In en, this message translates to:
  /// **'Celebrations of the Week'**
  String get event_card_title;

  /// No description provided for @birthdays_tag.
  ///
  /// In en, this message translates to:
  /// **'Birthdays'**
  String get birthdays_tag;

  /// No description provided for @work_anniversaries_tag.
  ///
  /// In en, this message translates to:
  /// **'Work Anniversary'**
  String get work_anniversaries_tag;

  /// No description provided for @no_event_text.
  ///
  /// In en, this message translates to:
  /// **'No festivities on the calendar this week'**
  String get no_event_text;

  /// No description provided for @upcoming_birthday_text.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s birthday is coming up on'**
  String upcoming_birthday_text(String name);

  /// No description provided for @present_birthday_text.
  ///
  /// In en, this message translates to:
  /// **'Today is {name}\'s birthday 🥳🥳! Let\'s make it sparkle with cheerful wishes!'**
  String present_birthday_text(String name);

  /// No description provided for @upcoming_anniversary_text.
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =1{{name} will have successfully completed {years} year with us on} other {{name} will have successfully completed {years} years with us on}}'**
  String upcoming_anniversary_text(String name, int years);

  /// No description provided for @present_anniversary_text.
  ///
  /// In en, this message translates to:
  /// **'{years,plural, =1{Congratulations on {years} year with us {name} 💐💐! Keep up the good work!} other {Congratulations on {years} years with us {name} 💐💐! Keep up the good work!}}'**
  String present_anniversary_text(String name, int years);

  /// No description provided for @search_employee_tag.
  ///
  /// In en, this message translates to:
  /// **'Search employee'**
  String get search_employee_tag;

  /// No description provided for @empty_leaves_message.
  ///
  /// In en, this message translates to:
  /// **'There is no any leaves, yet'**
  String get empty_leaves_message;

  /// No description provided for @admin_leave_detail_enter_reason_tag.
  ///
  /// In en, this message translates to:
  /// **'Enter Message'**
  String get admin_leave_detail_enter_reason_tag;

  /// No description provided for @admin_leave_detail_note_tag.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get admin_leave_detail_note_tag;

  /// No description provided for @admin_leave_detail_reject_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get admin_leave_detail_reject_button_tag;

  /// No description provided for @admin_leave_detail_approve_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get admin_leave_detail_approve_button_tag;

  /// No description provided for @admin_employee_detail_profile_tag.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get admin_employee_detail_profile_tag;

  /// No description provided for @admin_employees_detail_time_off_tag.
  ///
  /// In en, this message translates to:
  /// **'Time Off'**
  String get admin_employees_detail_time_off_tag;

  /// No description provided for @invited_members_title.
  ///
  /// In en, this message translates to:
  /// **'Invited members'**
  String get invited_members_title;

  /// No description provided for @inactive_members_title.
  ///
  /// In en, this message translates to:
  /// **'Inactive members'**
  String get inactive_members_title;

  /// No description provided for @admin_setting_update_leave_total_leaves_tag.
  ///
  /// In en, this message translates to:
  /// **'Total Leaves'**
  String get admin_setting_update_leave_total_leaves_tag;

  /// No description provided for @yearly_paid_time_off_tag.
  ///
  /// In en, this message translates to:
  /// **'Yearly Paid Time-Off'**
  String get yearly_paid_time_off_tag;

  /// No description provided for @hr_leave_record_tag.
  ///
  /// In en, this message translates to:
  /// **'Leave Record'**
  String get hr_leave_record_tag;

  /// No description provided for @leave_notification_email_tag.
  ///
  /// In en, this message translates to:
  /// **'Leave notification email'**
  String get leave_notification_email_tag;

  /// No description provided for @user_leave_apply_tag.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get user_leave_apply_tag;

  /// No description provided for @user_leave_used_leaves_tag.
  ///
  /// In en, this message translates to:
  /// **'Used Leaves'**
  String get user_leave_used_leaves_tag;

  /// No description provided for @user_leave_past_leaves_tag.
  ///
  /// In en, this message translates to:
  /// **'Past Leaves'**
  String get user_leave_past_leaves_tag;

  /// No description provided for @user_leave_upcoming_leaves_tag.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Leaves'**
  String get user_leave_upcoming_leaves_tag;

  /// No description provided for @user_leave_show_less_tag.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get user_leave_show_less_tag;

  /// No description provided for @user_leave_view_more_tag.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get user_leave_view_more_tag;

  /// No description provided for @no_leaves_tag.
  ///
  /// In en, this message translates to:
  /// **'No Leaves!'**
  String get no_leaves_tag;

  /// No description provided for @user_leave_empty_screen_message.
  ///
  /// In en, this message translates to:
  /// **'Are you secretly a superhero?'**
  String get user_leave_empty_screen_message;

  /// No description provided for @user_leaves_apply_appbar_tag.
  ///
  /// In en, this message translates to:
  /// **'Leave Request'**
  String get user_leaves_apply_appbar_tag;

  /// No description provided for @user_leaves_apply_enter_reason_tag.
  ///
  /// In en, this message translates to:
  /// **'Enter reason'**
  String get user_leaves_apply_enter_reason_tag;

  /// No description provided for @user_leaves_apply_leave_type_tag.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get user_leaves_apply_leave_type_tag;

  /// No description provided for @user_leaves_apply_leave_start_tag.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get user_leaves_apply_leave_start_tag;

  /// No description provided for @user_leaves_apply_leave_end_tag.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get user_leaves_apply_leave_end_tag;

  /// No description provided for @user_leaves_apply_leave_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Apply Leave'**
  String get user_leaves_apply_leave_button_tag;

  /// No description provided for @user_leaves_apply_leave_error_message_fill_details.
  ///
  /// In en, this message translates to:
  /// **'Please fill all details'**
  String get user_leaves_apply_leave_error_message_fill_details;

  /// No description provided for @user_leaves_apply_leave_error_valid_reason.
  ///
  /// In en, this message translates to:
  /// **' • Please enter valid reason'**
  String get user_leaves_apply_leave_error_valid_reason;

  /// No description provided for @user_leaves_apply_leave_success_message.
  ///
  /// In en, this message translates to:
  /// **'You\'ve successfully applied!'**
  String get user_leaves_apply_leave_success_message;

  /// No description provided for @cancel_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button_tag;

  /// No description provided for @cancel_leave_message.
  ///
  /// In en, this message translates to:
  /// **'Leave is cancelled successfully!'**
  String get cancel_leave_message;

  /// No description provided for @user_settings_edit_select_tag.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get user_settings_edit_select_tag;

  /// No description provided for @user_setting_camera_tag.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get user_setting_camera_tag;

  /// No description provided for @user_setting_gallery_tag.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get user_setting_gallery_tag;

  /// No description provided for @employee_designation_tag.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get employee_designation_tag;

  /// No description provided for @employee_blood_group_tag.
  ///
  /// In en, this message translates to:
  /// **'Blood Group'**
  String get employee_blood_group_tag;

  /// No description provided for @employee_role_tag.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get employee_role_tag;

  /// No description provided for @employee_mobile_tag.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get employee_mobile_tag;

  /// No description provided for @employee_email_tag.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get employee_email_tag;

  /// No description provided for @employee_address_tag.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get employee_address_tag;

  /// No description provided for @employee_gender_tag.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get employee_gender_tag;

  /// No description provided for @employee_dateOfBirth_tag.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get employee_dateOfBirth_tag;

  /// No description provided for @employee_dateOfJoin_tag.
  ///
  /// In en, this message translates to:
  /// **'Date of Joining'**
  String get employee_dateOfJoin_tag;

  /// No description provided for @employee_level_tag.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get employee_level_tag;

  /// No description provided for @employee_employeeID_tag.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get employee_employeeID_tag;

  /// No description provided for @employee_name_tag.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get employee_name_tag;

  /// No description provided for @admin_leave_detail_button_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get admin_leave_detail_button_reject;

  /// No description provided for @admin_leave_detail_button_approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get admin_leave_detail_button_approve;

  /// No description provided for @admin_leave_detail_button_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get admin_leave_detail_button_ok;

  /// No description provided for @admin_leave_detail_daysLeft_tag.
  ///
  /// In en, this message translates to:
  /// **'Days left'**
  String get admin_leave_detail_daysLeft_tag;

  /// No description provided for @admin_leave_empty_screen_message.
  ///
  /// In en, this message translates to:
  /// **'No any Leaves, yet!'**
  String get admin_leave_empty_screen_message;

  /// No description provided for @gender_male_tag.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male_tag;

  /// No description provided for @gender_female_tag.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female_tag;

  /// Pass the value of gender to get gender of user
  ///
  /// In en, this message translates to:
  /// **'{gender, plural, =1{Male} =2{Female} other{Other}}'**
  String user_details_gender(num gender);

  /// No description provided for @create_form_screen_title.
  ///
  /// In en, this message translates to:
  /// **'New Form'**
  String get create_form_screen_title;

  /// No description provided for @title_tag.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title_tag;

  /// No description provided for @description_tag.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description_tag;

  /// No description provided for @create_from_limit_to_1_response_text.
  ///
  /// In en, this message translates to:
  /// **'Limit To 1 Response'**
  String get create_from_limit_to_1_response_text;

  /// No description provided for @question_tag.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question_tag;

  /// No description provided for @options_tag.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options_tag;

  /// No description provided for @question_text_field_hint_text.
  ///
  /// In en, this message translates to:
  /// **'Enter Question'**
  String get question_text_field_hint_text;

  /// No description provided for @remove_tag.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove_tag;

  /// No description provided for @type_tag.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type_tag;

  /// No description provided for @required_tag.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required_tag;

  /// No description provided for @create_tag.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create_tag;

  /// No description provided for @create_form_success_message.
  ///
  /// In en, this message translates to:
  /// **' form has been created successfully'**
  String get create_form_success_message;

  /// No description provided for @forms_title.
  ///
  /// In en, this message translates to:
  /// **'Forms'**
  String get forms_title;

  /// No description provided for @responses_tag.
  ///
  /// In en, this message translates to:
  /// **'Responses'**
  String get responses_tag;

  /// No description provided for @fill_up_tag.
  ///
  /// In en, this message translates to:
  /// **'Fill-up'**
  String get fill_up_tag;

  /// No description provided for @form_list_empty_screen_title.
  ///
  /// In en, this message translates to:
  /// **'No forms'**
  String get form_list_empty_screen_title;

  /// No description provided for @form_list_empty_screen_message.
  ///
  /// In en, this message translates to:
  /// **'Oops, No Forms Here!'**
  String get form_list_empty_screen_message;

  /// Pass the value of answer type to get answerType
  ///
  /// In en, this message translates to:
  /// **'{type, select, 0{Text} 1{Boolean} 2{Date} 3{Time} 4{Drop-down} 5{Checkboxes} 6{File upload} 7{None} other{other}}'**
  String org_form_answer_type(String type);

  /// No description provided for @network_connection_error.
  ///
  /// In en, this message translates to:
  /// **'Please check your Internet connection'**
  String get network_connection_error;

  /// No description provided for @user_not_found_error_message.
  ///
  /// In en, this message translates to:
  /// **'User with this email doesn\'t exist, Please ask your manager to add it'**
  String get user_not_found_error_message;

  /// No description provided for @user_data_not_update_error_message.
  ///
  /// In en, this message translates to:
  /// **'Error in Updating your account information, Please check that you have signed in correct account'**
  String get user_data_not_update_error_message;

  /// No description provided for @firestore_fetch_data_error_message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get firestore_fetch_data_error_message;

  /// No description provided for @firebase_auth_error_message.
  ///
  /// In en, this message translates to:
  /// **'Error occurred while Google sign in. Try again'**
  String get firebase_auth_error_message;

  /// No description provided for @sign_out_error_message.
  ///
  /// In en, this message translates to:
  /// **'Your attempt to sign out failed,Please try again later'**
  String get sign_out_error_message;

  /// No description provided for @error_something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_something_went_wrong;

  /// No description provided for @fill_all_details_error.
  ///
  /// In en, this message translates to:
  /// **'Please fill all details'**
  String get fill_all_details_error;

  /// No description provided for @fill_require_details_error.
  ///
  /// In en, this message translates to:
  /// **'Please fill required details!'**
  String get fill_require_details_error;

  /// No description provided for @invalid_date_selection_error.
  ///
  /// In en, this message translates to:
  /// **'Please select valid date'**
  String get invalid_date_selection_error;

  /// No description provided for @apply_leave_minimum_one_hour_error.
  ///
  /// In en, this message translates to:
  /// **'Please apply leave for minimum half day'**
  String get apply_leave_minimum_one_hour_error;

  /// No description provided for @invalid_mobile_number_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid phone number'**
  String get invalid_mobile_number_error;

  /// No description provided for @add_member_employee_exists_error.
  ///
  /// In en, this message translates to:
  /// **'Member already exists!'**
  String get add_member_employee_exists_error;

  /// No description provided for @leave_already_applied_error_message.
  ///
  /// In en, this message translates to:
  /// **'Leave request has been already applied!'**
  String get leave_already_applied_error_message;

  /// No description provided for @provide_required_information.
  ///
  /// In en, this message translates to:
  /// **'Please provide the required information to continue'**
  String get provide_required_information;

  /// No description provided for @apple_sign_in_error_message.
  ///
  /// In en, this message translates to:
  /// **'Oops! It looks like you haven\'t granted permission to access your email. Please check and grant permission to access your email address'**
  String get apple_sign_in_error_message;

  /// No description provided for @sign_out_alert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get sign_out_alert;

  /// No description provided for @setup_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Setup Profile'**
  String get setup_profile_title;

  /// No description provided for @submit_button_tag.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit_button_tag;

  /// No description provided for @deactivate_user_account_alert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to deactivate {username}\'s account? This action cannot be undone.'**
  String deactivate_user_account_alert(String username);

  /// No description provided for @remove_user_leave_alert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this leave?'**
  String get remove_user_leave_alert;

  /// No description provided for @employee_empty_leave_message.
  ///
  /// In en, this message translates to:
  /// **'{name} don\'t have any leaves yet!'**
  String employee_empty_leave_message(String name);

  /// No description provided for @sign_out_from_text.
  ///
  /// In en, this message translates to:
  /// **'Sign out from {text}'**
  String sign_out_from_text(String text);

  /// No description provided for @employee_details_leaves_title.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s Leaves'**
  String employee_details_leaves_title(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
