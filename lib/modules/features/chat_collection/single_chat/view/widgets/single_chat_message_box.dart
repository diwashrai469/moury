import 'package:flutter/material.dart';
import '../../../../../../common/constant/app_dimens.dart';
import '../../../../../../common/constant/ui_helpers.dart';
import '../../../../../../theme/app_theme.dart';
import '../../view_model/single_chat_view_model.dart';

class SingleChatMessageBox extends StatefulWidget {
  final String userId;
  final SingleChatViewModel controller;

  const SingleChatMessageBox({
    Key? key,
    required this.userId,
    required this.controller,
  }) : super(key: key);

  @override
  State<SingleChatMessageBox> createState() => _SingleChatMessageBoxState();
}

class _SingleChatMessageBoxState extends State<SingleChatMessageBox> {
  final TextEditingController sendTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 10, bottom: 3, top: 3, right: 10),
          width: double.infinity,
          color: secondaryColor,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
              mWidthSpan,
              Expanded(
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                  minLines: 1,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  controller: sendTextEditingController,
                  decoration: const InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(
                          color: disabledColor,
                          fontSize: AppDimens.nameFontSize,
                          fontWeight: FontWeight.normal),
                      border: InputBorder.none),
                ),
              ),
              mWidthSpan,
              SizedBox(
                height: 45,
                width: 45,
                child: FloatingActionButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (sendTextEditingController.text.isNotEmpty) {
                      widget.controller.sendMessage(
                          id: widget.userId,
                          message: sendTextEditingController.text);
                      sendTextEditingController.clear();
                    }
                  },
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                  child: const Icon(
                    Icons.send,
                    color: Colors.black87,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
