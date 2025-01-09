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
  ];
}
