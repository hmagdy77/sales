import 'package:get/get.dart';

import '../../../core/constants/app_image_assets.dart';
import '../../../core/localization/translations.dart';
import '../../../models/static/on_boarding_model.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: AppStrings.choseProduct.tr,
      body: AppStrings.onBoardingOne.tr,
      image: AppImageAssets.onBoardingOne),
  OnBoardingModel(
      title: AppStrings.easySafePayment.tr,
      body: AppStrings.onBoardingOne.tr,
      image: AppImageAssets.onBoardingTwo),
  OnBoardingModel(
      title: AppStrings.trackYourOrder.tr,
      body: AppStrings.onBoardingOne.tr,
      image: AppImageAssets.onBoardingThree),
  OnBoardingModel(
      title: AppStrings.fastDelivery.tr,
      body: AppStrings.onBoardingOne.tr,
      image: AppImageAssets.onBoardingFour),
];
