import 'package:garage/core/networking/models/offer.dart';
import 'package:garage/core/networking/models/product.dart';
import 'package:garage/core/ui/pages_page.dart';
import 'package:garage/core/ui/webview_payment_page.dart';
import 'package:garage/features/all_chats/all_chats_binding.dart';
import 'package:garage/features/auth/change_password/change_password_binding.dart';
import 'package:garage/features/auth/change_password/change_password_page.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_binding.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_page.dart';
import 'package:garage/features/auth/forget_password/forget_password_binding.dart';
import 'package:garage/features/auth/forget_password/forget_password_page.dart';
import 'package:garage/features/auth/login/login_binding.dart';
import 'package:garage/features/auth/login/login_page.dart';
import 'package:garage/features/auth/otp_verify/otp_verify_binding.dart';
import 'package:garage/features/auth/otp_verify/otp_verify_page.dart';
import 'package:garage/features/auth/success_dialog_screen/success_dialog_screen.dart';
import 'package:garage/features/auth/profile/profile_binding.dart';
import 'package:garage/features/auth/profile/profile_page.dart';
import 'package:garage/features/auth/profile_edit/profile_edit_binding.dart';
import 'package:garage/features/auth/profile_edit/profile_edit_page.dart';
import 'package:garage/features/auth/register/register_binding.dart';
import 'package:garage/features/auth/register/register_page.dart';
import 'package:garage/features/auth/reset_password_by_mobile/reset_password_by_mobile_binding.dart';
import 'package:garage/features/auth/reset_password_by_mobile/reset_password_by_mobile_page.dart';
import 'package:garage/features/main/account_settings/account_settings_binding.dart';
import 'package:garage/features/main/account_settings/account_settings_page.dart';
import 'package:garage/features/main/add_car/add_car_binding.dart';
import 'package:garage/features/main/add_car/add_car_page.dart';
import 'package:garage/features/main/add_new_address/add_new_address_binding.dart';
import 'package:garage/features/main/add_new_address/add_new_address_page.dart';
import 'package:garage/features/main/add_price_request/add_price_request_binding.dart';
import 'package:garage/features/main/add_price_request/add_price_request_page.dart';
import 'package:garage/features/main/adress/address_binding.dart';
import 'package:garage/features/main/adress/address_page.dart';
import 'package:garage/features/main/cart/cart_binding.dart';
import 'package:garage/features/main/category/category_Page.dart';
import 'package:garage/features/main/category/category_binding.dart';
import 'package:garage/features/main/chat/chat_binding.dart';
import 'package:garage/features/main/chat/chat_page.dart';
import 'package:garage/features/main/company/company_binding.dart';
import 'package:garage/features/main/company/company_page.dart';
import 'package:garage/features/main/complete_cart_order/complete_cart_order_binding.dart';
import 'package:garage/features/main/complete_cart_order/complete_cart_order_page.dart';
import 'package:garage/features/main/main_navigation/main_navigation_binding.dart';
import 'package:garage/features/main/main_navigation/main_navigation_page.dart';
import 'package:garage/features/main/maintenance_appointment_reminder/maintenance_appointment_reminder_binding.dart';
import 'package:garage/features/main/maintenance_appointment_reminder/maintenance_appointment_reminder_page.dart';
import 'package:garage/features/main/my_orders/my_orders_binding.dart';
import 'package:garage/features/main/order_details/order_details_binding.dart';
import 'package:garage/features/main/order_details/order_details_page.dart';
import 'package:garage/features/main/price_request/price_request_binding.dart';
import 'package:garage/features/main/price_request/price_request_page.dart';
import 'package:garage/features/main/price_requst_details/price_requst_details_binding.dart';
import 'package:garage/features/main/price_requst_details/price_requst_details_page.dart';
import 'package:garage/features/main/product_details/product_details_PAGE.dart';
import 'package:garage/features/main/product_details/product_details_binding.dart';
import 'package:garage/features/main/search/search_binding.dart';
import 'package:garage/features/main/search/search_page.dart';
import 'package:garage/features/main/specifies_the_brand/select_the_brand_binding.dart';
import 'package:garage/features/main/specifies_the_brand/select_the_brand_page.dart';
import 'package:garage/features/onBoard/intro/intro_binding.dart';
import 'package:garage/features/onBoard/intro/intro_page.dart';
import 'package:garage/features/onBoard/splash/splash_binding.dart';
import 'package:garage/features/onBoard/splash/splash_page.dart';
import 'package:garage/features/onBoard/welcom/welcome_bindings.dart';
import 'package:garage/features/onBoard/welcom/welcome_page.dart';
import 'package:garage/features/other/about/about_binding.dart';
import 'package:garage/features/other/about/about_page.dart';
import 'package:garage/features/other/contact_us/contact_us_binding.dart';
import 'package:garage/features/other/contact_us/contact_us_page.dart';
import 'package:garage/features/other/select_location/select_location_binding.dart';
import 'package:garage/features/other/select_location/select_location_page.dart';
import 'package:garage/features/other/setting/setting_page.dart';
import 'package:garage/features/other/terms/terms_binding.dart';
import 'package:garage/features/other/terms/terms_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    GetPage(name: Routes.PROFILE, page: () => const ProfilePage()),
    GetPage(name: Routes.SETTING, page: () => SettingPage()),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.OTP_VERIFY,
      page: () => OtpVerifyPage(),
      binding: OtpVerifyBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.CONTACT_US,
      page: () => const ContactUsPage(),
      binding: ContactUsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PAGE,
      page: () => PagesPage(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.PROFILE_EDIT,
      page: () => const ProfileEditPage(),
      binding: ProfileEditBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.SELECT_LOCATION,
      page: () => SelectLocationPage(),
      binding: SelectLocationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.FORGET_PASSWORD,
      page: () => const ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.RESET_PASSWORD_BY_MOBILE,
      page: () => ResetPasswordByMobilePage(),
      binding: ResetPasswordByMobileBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
      transition: Transition.cupertino,
    ),
    // GetPage(
    //   name: Routes.WEBVIEW_PAYMENT,
    //   page: () => WebviewPaymentPage(),
    //   transition: Transition.cupertino,
    // ),
    GetPage(
      name: Routes.INTRO,
      page: () => IntroPage(),
      binding: IntroBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.COMPANY_PROFILE_EDIT,
      page: () => const CompanyProfileEditPage(),
      binding: CompanyProfileEditBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => AboutPage(),
      binding: AboutBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.TERMS,
      page: () => TermsPage(),
      binding: TermsBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.MAIN,
      page: () => const MainNavigationPage(),
      bindings: [
        ProfileBinding(),
        MainNavigationBinding(),
        MyOrdersBinding(),
        CartBinding(),
        AllChatsBinding(),
      ],
    ),
    GetPage(
      name: Routes.SelectTheBrandPageKey,
      page: () => const SelectTheBrandPage(),
      binding: SelectTheBrandBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.ADDCARPAGEKEY,
      page: () => const AddCarPage(),
      binding: AddCarBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.CATEGRYPAGEKEY,
      page: () => CategoryPage(),
      binding: CategoryBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.COMPANYkEY,
      page: () => const CompanyPage(),
      binding: CompanyBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PRODUCT_DETAILSKEY,
      page: () => const ProductDetailsPage(),
      binding: ProductDetailsBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.ORDER_DETAILSSKEY,
      page: () => const OrderDetailsPage(),
      binding: OrderDetailsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.COMPLETE_CART_ORDER,
      page: () => const CompleteCartOrderPage(),
      binding: CompleteCartOrderBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.SuccessDialogScreen,
      page: () => const SuccessDialogScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => const ChatPage(),
      binding: ChatBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchPage(),
      binding: SearchBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PRICEEQUEST_PAGE,
      page: () => const PriceRequestPage(),
      binding: PriceRequestBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PriceRequestDetailsPageKEY,
      page: () => const PriceRequestDetailsPage(),
      binding: PriceRequestDetailsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.AddPriceRequest,
      page: () => const AddPriceRequestPage(),
      binding: AddPriceRequestBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.MaintenanceAppointmentReminder,
      page: () => const MaintenanceAppointmentReminderPage(),
      binding: MaintenanceAppointmentReminderBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.AddNewAddressPage,
      page: () => const AddNewAddressPage(),
      binding: AddNewAddressBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.AddressPage,
      page: () => const AddressPage(),
      binding: AddressBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.AccountSetting,
      page: () => const AccountSettingsPage(),
      binding: AccountSettingsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.WELCOME_PAGE,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
