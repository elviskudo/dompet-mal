import 'package:dompet_mal/app/modules/(admin)/bankAdmin/bindings/bank_admin_binding.dart';
import 'package:dompet_mal/app/modules/(admin)/bankAdmin/views/bank_admin_view.dart';
import 'package:get/get.dart';

import '../modules/(admin)/admin_panel/bindings/admin_panel_binding.dart';
import '../modules/(admin)/admin_panel/views/admin_panel_view.dart';
import '../modules/(admin)/categories/bindings/categories_binding.dart';
import '../modules/(admin)/categories/views/categories_view.dart';
import '../modules/(admin)/companies/bindings/companies_binding.dart';
import '../modules/(admin)/companies/views/companies_view.dart';
import '../modules/(admin)/list_user/bindings/list_user_binding.dart';
import '../modules/(admin)/list_user/views/list_user_view.dart';
import '../modules/(admin)/upload/bindings/upload_binding.dart';
import '../modules/(admin)/upload/views/upload_view.dart';
import '../modules/(home)/Report/bindings/report_binding.dart';
import '../modules/(home)/Report/views/report_view.dart';
import '../modules/(home)/aggrement/bindings/aggrement_binding.dart';
import '../modules/(home)/aggrement/views/aggrement_view.dart';
import '../modules/(home)/category/bindings/category_binding.dart';
import '../modules/(home)/category/views/category_view.dart';
import '../modules/(admin)/charityAdmin/bindings/charity_admin_binding.dart';
import '../modules/(admin)/charityAdmin/views/charity_admin_view.dart';
import '../modules/(home)/confirmationTransfer/bindings/konfirmasi_transfer_binding.dart';
import '../modules/(home)/confirmationTransfer/views/konfirmasi_transfer_view.dart';
import '../modules/(admin)/contributorAdmin/bindings/contributor_admin_binding.dart';
import '../modules/(admin)/contributorAdmin/views/contributor_admin_view.dart';
import '../modules/(home)/donationDetailPage/bindings/donation_detail_page_binding.dart';
import '../modules/(home)/donationDetailPage/views/donation_detail_page_view.dart';
import '../modules/(home)/email_verification/bindings/email_verification_binding.dart';
import '../modules/(home)/email_verification/views/email_verification_view.dart';
import '../modules/(home)/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/(home)/forgot_password/views/forgot_password_view.dart';
import '../modules/(home)/forgotpass_verification/bindings/forgotpass_verification_binding.dart';
import '../modules/(home)/forgotpass_verification/views/forgotpass_verification_view.dart';
import '../modules/(home)/home/bindings/home_binding.dart';
import '../modules/(home)/home/views/home_view.dart';
import '../modules/(home)/listDonation/bindings/list_donation_binding.dart';
import '../modules/(home)/listDonation/views/list_donation_view.dart';
import '../modules/(home)/listPayment/bindings/list_payment_binding.dart';
import '../modules/(home)/listPayment/views/list_payment_view.dart';
import '../modules/(home)/login/bindings/login_binding.dart';
import '../modules/(home)/login/views/login_view.dart';
import '../modules/(home)/message/bindings/message_binding.dart';
import '../modules/(home)/message/views/message_view.dart';
import '../modules/(home)/navigation/bindings/navigation_binding.dart';
import '../modules/(home)/navigation/views/navigation_view.dart';
import '../modules/(home)/notification/bindings/notification_binding.dart';
import '../modules/(home)/notification/views/notification_view.dart';
import '../modules/(home)/onBoardingPage/bindings/on_boarding_page_binding.dart';
import '../modules/(home)/onBoardingPage/views/on_boarding_page_view.dart';
import '../modules/(home)/participantPage/bindings/participant_page_binding.dart';
import '../modules/(home)/participantPage/views/participant_page_view.dart';
import '../modules/(home)/paymentAccountPage/bindings/payment_account_page_binding.dart';
import '../modules/(home)/paymentAccountPage/views/payment_account_page_view.dart';
import '../modules/(home)/paymentSuccess/bindings/payment_success_binding.dart';
import '../modules/(home)/paymentSuccess/views/payment_success_view.dart';
import '../modules/(home)/profile/bindings/profile_binding.dart';
import '../modules/(home)/profile/views/profile_view.dart';
import '../modules/(home)/quran/bindings/quran_binding.dart';
import '../modules/(home)/quran/views/quran_view.dart';
import '../modules/(home)/register/bindings/register_binding.dart';
import '../modules/(home)/register/views/register_view.dart';
import '../modules/(home)/reset_pass/bindings/reset_pass_binding.dart';
import '../modules/(home)/reset_pass/views/reset_pass_view.dart';
import '../modules/(home)/sendMoney/bindings/sendMoney_binding.dart';
import '../modules/(home)/sendMoney/views/sendMoney_view.dart';
import '../modules/(home)/sendMoney2/bindings/send_money2_binding.dart';
import '../modules/(home)/sendMoney2/views/send_money2_view.dart';
import '../modules/(home)/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/(home)/splash_screen/views/splash_screen_view.dart';
import '../modules/(admin)/transactions/bindings/transactions_binding.dart';
import '../modules/(admin)/transactions/views/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

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
      page: () => SendMoney2View(),
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
      page: () =>  ProfileView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
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
      page: () => SendMoney2View(),
      binding: SendMoney2Binding(),
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
    GetPage(
      name: _Paths.QURAN,
      page: () => const QuranView(),
      binding: QuranBinding(),
    ),
    GetPage(
      name: _Paths.LIST_USER,
      page: () => ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PANEL,
      page: () => const AdminPanelView(),
      binding: AdminPanelBinding(),
    ),
    GetPage(
      name: _Paths.CONTRIBUTOR_ADMIN,
      page: () => const ContributorAdminView(),
      binding: ContributorAdminBinding(),
    ),
    GetPage(
      name: _Paths.CHARITY_ADMIN,
      page: () => const CharityAdminView(),
      binding: CharityAdminBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD,
      page: () => const UploadView(),
      binding: UploadBinding(),
    ),
    GetPage(
      name: _Paths.COMPANIES,
      page: () => CompaniesView(),
      binding: CompaniesBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.BANK_ADMIN,
      page: () => const BankAdminView(),
      binding: BankAdminBinding(),
    ),
  ];
}
