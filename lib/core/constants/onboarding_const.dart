import 'package:flutter/material.dart';
import 'package:labsense_ai/core/constants/imgaes.dart';
import 'package:labsense_ai/model/onboarding_model.dart';

List<OnboardingModel> myList = [
  OnboardingModel(
    title: "Scan your medical tests and get instant clarity.",
    body:
        "No more confusing terminology. \nTransform complex lab results into \na simple, actionable health roadmap \ntailored just for you.",
    image: Image.asset(AppImages.onBoardingImageOne),
  ),
  OnboardingModel(
    title: "Your Data is Private",
    body:
        "We use encryption to ensure \nyour medical records remain \nconfidential and secure.",
    image: Image.asset(AppImages.onBoardingImageTwo),
  ),
  OnboardingModel(
    title: "Track Your Trends",
    body:
        "See how your biomarkers change over \ntime with interactive charts and \nautomated health trend analysis.",
    image: Image.asset(AppImages.onBoardingImageThree),
  ),
];
