import 'package:c_w_animation/credit_withdrawal_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final colorList = [
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.redAccent,
  ];
  final alignList = [
    AlignmentDirectional.topCenter,
    AlignmentDirectional.bottomCenter,
  ];
  final screenColor = Colors.white.obs;
  final selectedColor = Colors.indigoAccent.obs;
  final nextColor = Colors.redAccent.obs;
  final alignmentOfContainer = AlignmentDirectional.bottomCenter.obs;
  final centreContainerSizeToggleHeight = 100.0.obs;
  final centreContainerSizeToggleWidth = 100.0.obs;
  final colorChangingContainerSizeToggleHeight = 50.0.obs;
  final colorChangingContainerSizeToggleWidth = 50.0.obs;
  final isAnimationCompleted = false.obs;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = SplashController();

  changeColor() async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (int i = 0; i < 4; i++) {
      splashController.alignmentOfContainer.value =
          splashController.alignList[i % 2];
      await Future.delayed(const Duration(milliseconds: 300));
      splashController.centreContainerSizeToggleHeight.value =
          splashController.centreContainerSizeToggleHeight.value + 20;
      splashController.centreContainerSizeToggleWidth.value =
          splashController.centreContainerSizeToggleWidth.value + 20;
      splashController.selectedColor.value = splashController.colorList[i];
      await Future.delayed(const Duration(milliseconds: 300));
      splashController.nextColor.value = i != 3
          ? splashController.colorList[i + 1]
          : splashController.nextColor.value;
      await Future.delayed(const Duration(milliseconds: 300));
    }
    splashController.alignmentOfContainer.value = AlignmentDirectional.center;
    await Future.delayed(const Duration(milliseconds: 300));
    splashController.colorChangingContainerSizeToggleHeight.value =
        splashController.centreContainerSizeToggleHeight.value;
    splashController.colorChangingContainerSizeToggleWidth.value =
        splashController.centreContainerSizeToggleWidth.value;
    await Future.delayed(const Duration(milliseconds: 300));
    splashController.isAnimationCompleted.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    splashController.screenColor.value = Colors.redAccent;
    await Future.delayed(const Duration(milliseconds: 600));
    Get.to(() => const TransactionScreen());
  }

  @override
  void initState() {
    changeColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  height: splashController.screenColor.value != Colors.redAccent
                      ? splashController.centreContainerSizeToggleHeight.value
                      : Get.height,
                  width: splashController.screenColor.value != Colors.redAccent
                      ? splashController.centreContainerSizeToggleWidth.value
                      : Get.width,
                  curve: Curves.bounceOut,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        splashController.screenColor.value != Colors.redAccent
                            ? 300
                            : 0),
                    color: splashController.selectedColor.value,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: AnimatedContainer(
                  height: 30,
                  width: Get.width / 2,
                  curve: Curves.bounceOut,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: splashController.nextColor.value,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: AnimatedContainer(
                  height: 30,
                  width: Get.width / 2,
                  curve: Curves.bounceOut,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: splashController.nextColor.value,
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: splashController.isAnimationCompleted.isFalse
                    ? AlignmentDirectional.topCenter
                    : AlignmentDirectional.centerStart,
                child: AnimatedContainer(
                  height:
                      splashController.isAnimationCompleted.isFalse ? 50 : 30,
                  width:
                      splashController.isAnimationCompleted.isFalse ? 50 : 30,
                  curve: Curves.elasticInOut,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: splashController.isAnimationCompleted.isFalse
                        ? splashController.nextColor.value
                        : Colors.redAccent,
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: splashController.isAnimationCompleted.isFalse
                    ? AlignmentDirectional.bottomCenter
                    : AlignmentDirectional.centerEnd,
                child: AnimatedContainer(
                  height:
                      splashController.isAnimationCompleted.isFalse ? 50 : 30,
                  width:
                      splashController.isAnimationCompleted.isFalse ? 50 : 30,
                  curve: Curves.elasticInOut,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: splashController.isAnimationCompleted.isFalse
                        ? splashController.nextColor.value
                        : Colors.redAccent,
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: splashController.alignmentOfContainer.value,
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 600),
                child: AnimatedContainer(
                  height: splashController
                      .colorChangingContainerSizeToggleHeight.value,
                  width: splashController
                      .colorChangingContainerSizeToggleWidth.value,
                  curve: Curves.elasticInOut,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: splashController.nextColor.value,
                  ),
                ),
              ),
              splashController.isAnimationCompleted.isTrue
                  ? Center(
                      child: Image.asset(
                          "assets/images/flutter-icon-original.png"),
                    )
                  : const Center(),
            ],
          ),
        ),
      ),
    );
  }
}
