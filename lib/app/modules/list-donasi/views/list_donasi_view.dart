import 'package:dompet_mal/component/bannerCategoryChoice.dart';
import 'package:dompet_mal/component/customAppBarCategory.dart';
import 'package:dompet_mal/models/pilihanKategoriModel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_donasi_controller.dart';

class ListDonasiView extends GetView<ListDonasiController> {
  const ListDonasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsetsDirectional.all(24),
        child: BannerKategori(banners: dummyDataListCategoryBanner),
      ),
    );
  }
}
