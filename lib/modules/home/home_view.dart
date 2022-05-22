import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:manabie_todolist/modules/home/home_view_model.dart';
import 'package:manabie_todolist/shared/based/base_view_state.dart';
import 'package:manabie_todolist/theme/ui_color.dart';
import 'package:manabie_todolist/theme/ui_text_style.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseViewState<HomeView, HomeViewModel> {
  @override
  HomeViewModel createViewModel() => HomeViewModel();

  @override
  void initState() {
    configEasyLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => KeyboardAutoDismiss(
        scaffold: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: UIColor.black,
            onPressed: () {
              viewModel.index.value = HomeIndex.all;
            },
            child: const Icon(CupertinoIcons.home),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: const [
              CupertinoIcons.archivebox,
              CupertinoIcons.list_bullet,
            ],
            activeIndex: viewModel.index.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            activeColor: UIColor.blue,
            inactiveColor: UIColor.black,
            backgroundColor: UIColor.white,
            onTap: (index) {
              viewModel.index.value = index;
            },
          ),
          body: viewModel.getView(),
        ),
      ),
    );
  }

  void configEasyLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.black
      ..indicatorSize = 60.0
      ..radius = 10.0
      ..progressWidth = 5.0
      ..lineWidth = 10.0
      ..backgroundColor = Colors.white
      ..indicatorColor = UIColor.blue
      ..textColor = UIColor.black
      ..progressColor = UIColor.blue
      ..textStyle = UITextStyle.black_16_w400
      ..userInteractions = false;
  }
}
