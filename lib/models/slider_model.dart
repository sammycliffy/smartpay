import 'package:smart_pay/constants/image_assets.dart';

class SliderModel {
  String image;
  String title;
  String description;

  SliderModel(
      {required this.title, required this.description, required this.image});
}

// List created
List<SliderModel> getSlides() {
  List<SliderModel> slides = [
    SliderModel(
        title: "Finance app the safest \n and most trusted",
        description:
            "Your finance work starts here. our here to help you track and deal with speeding up your transactions",
        image: AppImages.mobilePhone),
    SliderModel(
        title: "The fastest transaction process only here",
        description:
            "Get easy to pay your bills with just a few steps. Paying your bills become fast and efficient",
        image: AppImages.mobilePhone1)
  ];

  return slides;
}
