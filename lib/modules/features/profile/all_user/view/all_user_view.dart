import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import 'package:moury/theme/app_theme.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../view_model/all_user_view_model.dart';

class AllUserView extends StatelessWidget {
  const AllUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final contorller = Get.put(AllUserViewModel());
    return Scaffold(
      backgroundColor: secondaryColor,
      body: GetBuilder<AllUserViewModel>(
        initState: (state) {
          contorller.getAllUser();
        },
        builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: AppDimens.mainPagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      elHeightSpan,
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          "Explore Friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: AppDimens.headlineFontSizeOther),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          "Get connected with people",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: disabledColor,
                                  fontSize: AppDimens.headlineFontSizeXXSmall),
                        ),
                      ),
                      mHeightSpan,
                      Expanded(
                        child: GridView.builder(
                          itemCount:
                              controller.allUsersResponseData?.data?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0),
                          itemBuilder: (BuildContext context, int index) {
                            final userData =
                                controller.allUsersResponseData?.data?[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  '/single-user-profile',
                                  arguments: {
                                    'userId': userData?.sId,
                                  },
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        child: Text(
                                          userData?.name?[0] ?? '',
                                        ),
                                      ),
                                      sHeightSpan,
                                      Text(
                                        userData?.name ?? 'N/a',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      mHeightSpan,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
