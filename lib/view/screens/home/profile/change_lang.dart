import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labsense_ai/core/localization/changelocal.dart';
import 'package:labsense_ai/view/widgets/custom_button.dart';

class ChangeLang extends StatelessWidget {
  final LocalController localController = Get.put(LocalController());
  ChangeLang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Change Language")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Select Language"),
          SizedBox(height: 20),
          CustomButton(
            text: "Arabic",
            onPressed: () {
              localController.changeLang("ar");
            },
          ),
          CustomButton(
            text: "English",
            onPressed: () {
              localController.changeLang("en");
            },
          ),
        ],
      ),
    );
  }
}
