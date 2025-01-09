import 'package:dompet_mal/app/modules/aggrement/bindings/aggrement_binding.dart';
import 'package:dompet_mal/app/modules/aggrement/views/aggrement_view.dart';
import 'package:dompet_mal/app/modules/email_verification/bindings/email_verification_binding.dart';
import 'package:dompet_mal/app/modules/email_verification/views/email_verification_view.dart';
import 'package:dompet_mal/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:dompet_mal/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:dompet_mal/app/modules/forgotpass_verification/bindings/forgotpass_verification_binding.dart';
import 'package:dompet_mal/app/modules/forgotpass_verification/views/forgotpass_verification_view.dart';
import 'package:dompet_mal/app/modules/login/bindings/login_binding.dart';
import 'package:dompet_mal/app/modules/register/bindings/register_binding.dart';
import 'package:dompet_mal/app/modules/register/views/register_view.dart';
import 'package:dompet_mal/app/modules/reset_pass/bindings/reset_pass_binding.dart';
import 'package:dompet_mal/app/modules/reset_pass/views/reset_pass_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kategori/bindings/kategori_binding.dart';
import '../modules/kategori/views/kategori_view.dart';
import '../modules/kirim-uang/bindings/kirim_uang_binding.dart';
import '../modules/kirim-uang/views/kirim_uang_view.dart';
import '../modules/konfirmasi-transfer/bindings/konfirmasi_transfer_binding.dart';
import '../modules/konfirmasi-transfer/views/konfirmasi_transfer_view.dart';
import '../modules/list-donasi/bindings/list_donasi_binding.dart';
import '../modules/list-donasi/views/list_donasi_view.dart';
import '../modules/onBoardingPage/bindings/on_boarding_page_binding.dart';
import '../modules/onBoardingPage/views/on_boarding_page_view.dart';
import '../modules/paymentAccountPage/bindings/payment_account_page_binding.dart';
import '../modules/paymentAccountPage/views/payment_account_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
      page: () => const ListDonasiView(),
      binding: ListDonasiBinding(),
    ),
    GetPage(
      name: _Paths.KONFIRMASI_TRANSFER,
      page: () => const KonfirmasiTransferView(),
      binding: KonfirmasiTransferBinding(),
    ),
    GetPage(
      name: _Paths.KIRIM_UANG,
      page: () => const KirimUangView(),
      binding: KirimUangBinding(),
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
  ];
}
