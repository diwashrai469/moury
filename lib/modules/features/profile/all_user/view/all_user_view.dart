import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/constant/ui_helpers.dart';
import '../../../../../common/constant/app_dimens.dart';
import '../view_model/all_user_view_model.dart';

class AllUserView extends StatelessWidget {
  const AllUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final contorller = Get.put(AllUserViewModel());
    return Scaffold(
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
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: 5,
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
                                      Text(userData?.name ?? 'N/a'),
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
