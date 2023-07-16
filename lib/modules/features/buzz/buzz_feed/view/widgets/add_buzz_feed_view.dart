import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/app_dimens.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/common/widgets/k_textformfield.dart';
import 'package:moury/modules/features/buzz/buzz_feed/view_models/buzz_feed_view_models.dart';
import 'package:moury/theme/app_theme.dart';

class AddBuzzFeedView extends StatelessWidget {
  const AddBuzzFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController feedTextController = TextEditingController();
    final createaFeedModel = Get.put(BuzzFeedViewModels());
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Buzz",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: AppDimens.titleFontSize, color: Colors.white),
        ),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: AppDimens.mainPagePadding,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              KTextFormField(
                maxLines: 20,
                controller: feedTextController,
                hint: "What's happening?",
                label: "Buzz",
              ),
              mHeightSpan,
              KButton(
                  child: const Text("Buzz up"),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (feedTextController.text.isNotEmpty) {
                      createaFeedModel.createBuzz(feedTextController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
