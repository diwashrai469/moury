
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/constant/app_dimens.dart';
import '../../../../common/widgets/k_button.dart';
import '../view_model/explore_view_models.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find friends"),
      ),
      body: Padding(
        padding: AppDimens.mainPagePadding,
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0),
              itemBuilder: (BuildContext context, int index) {
                final exploreData =
                    controller.exploreResponseData?.data?[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people),
                       Text(exploreData?.name ?? 'N/a'),
                        
                        KButton(
                            child: const Row(children: [
                              Icon(Icons.add),
                              Text("Add friend")
                            ]),
                            onPressed: () {})
                      ],
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
