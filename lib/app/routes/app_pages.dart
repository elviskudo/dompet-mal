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
      page: () => const KategoriView(),
      binding: KategoriBinding(),
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
