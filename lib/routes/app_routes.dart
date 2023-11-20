import 'package:taousapp/presentation/settings_screen/account_management_screen/account_management_screen.dart';
import 'package:taousapp/presentation/settings_screen/account_management_screen/binding/account_management_binding.dart';
import 'package:taousapp/presentation/edit_profile_screen/binding/edit_profile_binding.dart';
import 'package:taousapp/presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:taousapp/presentation/home_screen/binding/home_binding.dart';
import 'package:taousapp/presentation/home_screen/home_screen.dart';
import 'package:taousapp/presentation/profile_screen_user/binding/profile_binding_user.dart';
import 'package:taousapp/presentation/profile_screen_user/profile_screen_user.dart';
import 'package:taousapp/presentation/settings_screen/personal_information_screen/binding/personal_information_binding.dart';
import 'package:taousapp/presentation/settings_screen/personal_information_screen/birthday_screen.dart';
import 'package:taousapp/presentation/settings_screen/personal_information_screen/gender_screen.dart';
import 'package:taousapp/presentation/settings_screen/personal_information_screen/personal_information_screen.dart';
import 'package:taousapp/presentation/splashone_screen/splashone_screen.dart';
import 'package:taousapp/presentation/splashone_screen/binding/splashone_binding.dart';
import 'package:taousapp/presentation/log_in_screen/log_in_screen.dart';
import 'package:taousapp/presentation/log_in_screen/binding/log_in_binding.dart';
import 'package:taousapp/presentation/sign_up_tab_container_screen/sign_up_tab_container_screen.dart';
import 'package:taousapp/presentation/sign_up_tab_container_screen/binding/sign_up_tab_container_binding.dart';
import 'package:taousapp/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:taousapp/presentation/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:taousapp/presentation/profile_screen/profile_screen.dart';
import 'package:taousapp/presentation/profile_screen/binding/profile_binding.dart';
import 'package:taousapp/presentation/post_screen/post_screen.dart';
import 'package:taousapp/presentation/post_screen/binding/post_binding.dart';
import 'package:taousapp/presentation/frends_screen/frends_screen.dart';
import 'package:taousapp/presentation/frends_screen/binding/frends_binding.dart';
import 'package:taousapp/presentation/messages_screen/messages_screen.dart';
import 'package:taousapp/presentation/messages_screen/binding/messages_binding.dart';
import 'package:taousapp/presentation/chat_screen/chat_screen.dart';
import 'package:taousapp/presentation/chat_screen/binding/chat_binding.dart';
import 'package:taousapp/presentation/prodcut_details_one_screen/prodcut_details_one_screen.dart';
import 'package:taousapp/presentation/prodcut_details_one_screen/binding/prodcut_details_one_binding.dart';
import 'package:taousapp/presentation/prodcut_details_screen/prodcut_details_screen.dart';
import 'package:taousapp/presentation/prodcut_details_screen/binding/prodcut_details_binding.dart';
import 'package:taousapp/presentation/reel_screen/reel_screen.dart';
import 'package:taousapp/presentation/reel_screen/binding/reel_binding.dart';
import 'package:taousapp/presentation/settings_screen/settings_screen.dart';
import 'package:taousapp/presentation/settings_screen/binding/settings_binding.dart';
import 'package:taousapp/presentation/notifications_screen/notifications_screen.dart';
import 'package:taousapp/presentation/notifications_screen/binding/notifications_binding.dart';
import 'package:taousapp/presentation/make_complaint_screen/make_complaint_screen.dart';
import 'package:taousapp/presentation/make_complaint_screen/binding/make_complaint_binding.dart';
import 'package:taousapp/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:taousapp/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashoneScreen = '/splashone_screen';

  static const String logInScreen = '/log_in_screen';

  static const String signUpPage = '/sign_up_page';

  static const String signUpTabContainerScreen =
      '/sign_up_tab_container_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String profileScreen = '/profile_screen';

  static const String postScreen = '/post_screen';

  static const String frendsScreen = '/frends_screen';

  static const String messagesScreen = '/messages_screen';

  static const String chatScreen = '/chat_screen';

  static const String prodcutDetailsOneScreen = '/prodcut_details_one_screen';

  static const String prodcutDetailsScreen = '/prodcut_details_screen';

  static const String reelScreen = '/reel_screen';

  static const String settingsScreen = '/settings_screen';

  static const String homeScreen = '/home_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String makeComplaintScreen = '/make_complaint_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String profileScreenUser = '/profile_screen_user';

  static const String accountManagementScreen = '/account_management_screen';
  static const String personalInformationScreen =
      '/personal_information_screen';
  static const String birthdayScreen = '/birthday_screen';
  static const String genderScreen = '/gender_screen';

  static List<GetPage> pages = [
    GetPage(
      name: splashoneScreen,
      page: () => SplashoneScreen(),
      transition: Transition.downToUp,
      bindings: [
        SplashoneBinding(),
      ],
    ),
    GetPage(
      name: logInScreen,
      page: () => LogInScreen(),
      bindings: [
        LogInBinding(),
      ],
    ),
    GetPage(
      name: signUpTabContainerScreen,
      page: () => SignUpTabContainerScreen(),
      bindings: [
        SignUpTabContainerBinding(),
      ],
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
    ),
    GetPage(
      name: editProfileScreen,
      page: () => EditprofileScreen(),
      bindings: [
        EditprofileBinding(),
      ],
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: postScreen,
      page: () => PostScreen(),
      bindings: [
        PostBinding(),
      ],
    ),
    GetPage(
      name: frendsScreen,
      page: () => FrendsScreen(),
      bindings: [
        FrendsBinding(),
      ],
    ),
    GetPage(
      name: messagesScreen,
      page: () => MessagesScreen(),
      bindings: [
        MessagesBinding(),
      ],
    ),
    GetPage(
      name: chatScreen,
      page: () => ChatScreen(),
      bindings: [
        ChatBinding(),
      ],
    ),
    GetPage(
      name: prodcutDetailsOneScreen,
      page: () => ProdcutDetailsOneScreen(),
      bindings: [
        ProdcutDetailsOneBinding(),
      ],
    ),
    GetPage(
      name: prodcutDetailsScreen,
      page: () => ProdcutDetailsScreen(),
      bindings: [
        ProdcutDetailsBinding(),
      ],
    ),
    GetPage(
      name: reelScreen,
      page: () => ReelScreen(),
      bindings: [
        ReelBinding(),
      ],
    ),
    GetPage(
      name: settingsScreen,
      page: () => SettingsScreen(),
      bindings: [
        SettingsBinding(),
      ],
    ),
    GetPage(
      name: accountManagementScreen,
      page: () => AccountManagementScreen(),
      bindings: [
        AccountManagementBinding(),
      ],
    ),
    GetPage(
      name: personalInformationScreen,
      page: () => PersonalInformationScreen(),
      bindings: [
        PersonalInformationBinding(),
      ],
    ),
    GetPage(name: birthdayScreen, page: () => BirthdayScreen()),
    GetPage(name: genderScreen, page: () => GenderScreen()),
    GetPage(
      name: notificationsScreen,
      page: () => NotificationsScreen(),
      bindings: [
        NotificationsBinding(),
      ],
    ),
    GetPage(
      name: makeComplaintScreen,
      page: () => MakeComplaintScreen(),
      bindings: [
        MakeComplaintBinding(),
      ],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: profileScreenUser,
      page: () => ProfileScreenUser(),
      bindings: [
        ProfileBindingUser(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashoneScreen(),
      bindings: [
        SplashoneBinding(),
      ],
    )
  ];
}
