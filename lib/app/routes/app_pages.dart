import 'package:dompet_mal/app/modules/category/bindings/category_binding.dart';
import 'package:dompet_mal/app/modules/category/views/category_view.dart';
import 'package:dompet_mal/app/modules/listDonation/bindings/list_donation_binding.dart';
import 'package:dompet_mal/app/modules/listDonation/views/list_donation_view.dart';
import 'package:dompet_mal/app/modules/listPayment/bindings/list_payment_binding.dart';
import 'package:dompet_mal/app/modules/listPayment/views/list_payment_view.dart';
import 'package:dompet_mal/app/modules/message/bindings/message_binding.dart';
import 'package:dompet_mal/app/modules/message/views/message_view.dart';
import 'package:dompet_mal/app/modules/notification/bindings/notification_binding.dart';
import 'package:dompet_mal/app/modules/notification/views/notification_view.dart';
import 'package:dompet_mal/app/modules/paymentSuccess/bindings/payment_success_binding.dart';
import 'package:dompet_mal/app/modules/paymentSuccess/views/payment_success_view.dart';
import 'package:dompet_mal/app/modules/sendMoney2/bindings/send_money2_binding.dart';
import 'package:dompet_mal/app/modules/sendMoney2/views/send_money2_view.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../modules/Report/bindings/report_binding.dart';
import '../modules/Report/views/report_view.dart';
import 'package:get/get.dart';

import '../modules/aggrement/bindings/aggrement_binding.dart';
import '../modules/aggrement/views/aggrement_view.dart';
import '../modules/confirmationTransfer/bindings/konfirmasi_transfer_binding.dart';
import '../modules/confirmationTransfer/views/konfirmasi_transfer_view.dart';
import '../modules/donationDetailPage/bindings/donation_detail_page_binding.dart';
import '../modules/donationDetailPage/views/donation_detail_page_view.dart';
import '../modules/email_verification/bindings/email_verification_binding.dart';
import '../modules/email_verification/views/email_verification_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgotpass_verification/bindings/forgotpass_verification_binding.dart';
import '../modules/forgotpass_verification/views/forgotpass_verification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/onBoardingPage/bindings/on_boarding_page_binding.dart';
import '../modules/onBoardingPage/views/on_boarding_page_view.dart';
import '../modules/participants/bindings/participants_binding.dart';
import '../modules/participants/views/participants_view.dart';
import '../modules/paymentAccountPage/bindings/payment_account_page_binding.dart';
import '../modules/paymentAccountPage/views/payment_account_page_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/listDonation/bindings/list_donation_binding.dart';
import '../modules/listDonation/views/list_donation_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onBoardingPage/bindings/on_boarding_page_binding.dart';
import '../modules/onBoardingPage/views/on_boarding_page_view.dart';
import '../modules/participantPage/bindings/participant_page_binding.dart';
import '../modules/participantPage/views/participant_page_view.dart';
import '../modules/paymentAccountPage/bindings/payment_account_page_binding.dart';
import '../modules/paymentAccountPage/views/payment_account_page_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_pass/bindings/reset_pass_binding.dart';
import '../modules/reset_pass/views/reset_pass_view.dart';

import '../modules/sendMoney/bindings/sendMoney_binding.dart';
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
      name: _Paths.ListDonation,
      page: () => ListDonationView(),
      binding: ListDonationBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.KONFIRMASI_TRANSFER,
      page: () => const ConfirmationTransferView(),
      binding: ConfirmationTransferBinding(),
    ),
    GetPage(
      name: _Paths.SEND_MONEY,
      page: () => const SendMoneyView(),
      binding: SendMoneyBinding(),
    ),
    GetPage(
      name: _Paths.SEND_MONEY2,
      page: () => const SendMoney2View(),
      binding: SendMoney2Binding(),
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
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.PARTICIPANTS,
      page: () => const ParticipantsView(),
      binding: ParticipantsBinding(),
    ),
    GetPage(
      name: _Paths.SEND_MONEY,
      page: () => const SendMoneyView(),
      binding: SendMoneyBinding(),
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
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.DONATION_DETAIL_PAGE,
      page: () => DonationDetailView(),
      binding: DonationDetailPageBinding(),
    ),
    GetPage(
      name: _Paths.PARTICIPANT_PAGE,
      page: () => ParticipantPage(),
      binding: ParticipantPageBinding(),
    ),
    GetPage(
      name: _Paths.LIST_PAYMENT,
      page: () => ListPaymentView(),
      binding: ListPaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESS,
      page: () => const PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => MessageView(),
      binding: MessageBinding(),
    ),
  ];
}
