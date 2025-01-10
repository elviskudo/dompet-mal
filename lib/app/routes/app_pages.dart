import 'package:get/get.dart';

import '../modules/Report/bindings/report_binding.dart';
import '../modules/Report/views/report_view.dart';
import '../modules/aggrement/bindings/aggrement_binding.dart';
import '../modules/aggrement/views/aggrement_view.dart';
import '../modules/category/bindings/kategori_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/confirmationTransfer/bindings/konfirmasi_transfer_binding.dart';
import '../modules/confirmationTransfer/views/konfirmasi_transfer_view.dart';
import '../modules/email_verification/bindings/email_verification_binding.dart';
import '../modules/email_verification/views/email_verification_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgotpass_verification/bindings/forgotpass_verification_binding.dart';
import '../modules/forgotpass_verification/views/forgotpass_verification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/listDonation/bindings/list_donation_binding.dart';
import '../modules/listDonation/views/list_donation_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myDonation/bindings/my_donation_binding.dart';
import '../modules/myDonation/views/my_donation_view.dart';
import '../modules/myFavorite/bindings/my_favorite_binding.dart';
import '../modules/myFavorite/views/my_favorite_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/onBoardingPage/bindings/on_boarding_page_binding.dart';
import '../modules/onBoardingPage/views/on_boarding_page_view.dart';
import '../modules/paymentAccountPage/bindings/payment_account_page_binding.dart';
import '../modules/paymentAccountPage/views/payment_account_page_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_pass/bindings/reset_pass_binding.dart';
import '../modules/reset_pass/views/reset_pass_view.dart';
import '../modules/sendMoney/bindings/kirim_uang_binding.dart';
import '../modules/sendMoney/views/sendMoney_view.dart';
import '../modules/sendMoney2/bindings/send_money2_binding.dart';
import '../modules/sendMoney2/views/send_money2_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NAVIGATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.KATEGORI,
      page: () => KategoriView(),
      binding: KategoriBinding(),
    ),
    GetPage(
      name: _Paths.LIST_DONASI,
      page: () => const ListDonationView(),
      binding: ListDonationBinding(),
    ),
    GetPage(
      name: _Paths.KONFIRMASI_TRANSFER,
      page: () => const KonfirmasiTransferView(),
      binding: KonfirmasiTransferBinding(),
    ),
    GetPage(
      name: _Paths.KIRIM_UANG,
      page: () => const SendMoneyView(),
      binding: SendMoneyBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.AGGREMENT,
      page: () => const AggrementView(),
      binding: AggrementBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_VERIFICATION,
      page: () => const EmailVerificationView(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASS_VERIFICATION,
      page: () => const ForgotpassVerificationView(),
      binding: ForgotpassVerificationBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASS,
      page: () => const ResetPassView(),
      binding: ResetPassBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING_PAGE,
      page: () => const OnboardingPageView(),
      binding: OnBoardingPageBinding(),
    ),
    GetPage(
      name: '/payment-account-page',
      page: () => const PaymentAccountPageView(),
      binding: PaymentAccountPageBinding(),
    ),
    GetPage(
      name: _Paths.MY_DONATION,
      page: () => MyDonationView(),
      binding: MyDonationBinding(),
    ),
    GetPage(
      name: _Paths.MY_FAVORITE,
      page: () => MyFavoriteView(),
      binding: MyFavoriteBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.SEND_MONEY2,
      page: () => const SendMoney2View(),
      binding: SendMoney2Binding(),
    ),
  ];
}
