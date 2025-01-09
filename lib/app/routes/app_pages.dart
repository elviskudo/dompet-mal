import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kategori/bindings/kategori_binding.dart';
import '../modules/kategori/views/kategori_view.dart';
import '../modules/onBoardingPage/bindings/on_boarding_page_binding.dart';
import '../modules/onBoardingPage/views/on_boarding_page_view.dart';
import '../modules/paymentAccountPage/bindings/payment_account_page_binding.dart';
import '../modules/paymentAccountPage/views/payment_account_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PAYMENT_ACCOUNT_PAGE;

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
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING_PAGE,
      page: () => const OnboardingPageView(),
      binding: OnBoardingPageBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_ACCOUNT_PAGE,
      page: () => const PaymentAccountPageView(),
      binding: PaymentAccountPageBinding(),
    ),
  ];
}
