import 'package:flutter/material.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/utils/app_theme.dart';

class ProFileEdit extends StatefulWidget {
  const ProFileEdit({
    super.key,
    required this.label,
    required this.textEditingController,
  });

  final String label;
  final TextEditingController textEditingController;

  @override
  State<ProFileEdit> createState() => _ProFileEditState();
}

class _ProFileEditState extends State<ProFileEdit> {
  bool _isEditText = false;

  void _onPressEdit() {
    setState(() {
      _isEditText = !_isEditText;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isEditText = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gaps.v10,
        Text(widget.label),
        Gaps.h10,
        Flexible(
          child: TextFormField(
            controller: widget.textEditingController,
            style: TextStyle(
              fontSize: Sizes.size14,
              color: isDarkMod(context) ? Colors.white54 : Colors.black54,
            ),
            //onSubmitted: sendMsg,
            //onChanged: checkText,
            // onSubmitted: (text) {
            //   sendMsg(text);
            // },
            // onChanged: (text) {
            //   checkText(text);
            // },
            decoration: InputDecoration(
              // labelText: '텍스트 입력',
              // hintText: '텍스트를 입력해주세요',
              hintStyle: TextStyle(
                color: Theme.of(context).hintColor,
              ),
              border: const OutlineInputBorder(), //외곽선
              enabled: _isEditText,
              constraints: const BoxConstraints(
                maxHeight: Sizes.size32,
                minWidth: Sizes.size32,
              ),
              // suffixIcon: widget.textEditingController.text.isNotEmpty  && _isEditText
              //     ? Container(
              //         child: IconButton(
              //           alignment: Alignment.centerRight,
              //           icon: const Icon(
              //             Icons.cancel,
              //           ),
              //           onPressed: () {
              //             widget.textEditingController.clear();
              //             setState(() {});
              //           },
              //         ),
              //       )
              //     : Container(),
              // ),
            ),
          ),
        ),
        Gaps.h10,
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              isDarkMod(context)
                  ? Colors.amber.shade300
                  : Colors.blueAccent.shade400,
            ),
          ),
          onPressed: _onPressEdit,
          child: Text(_isEditText ? "완료" : "변경"),
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(
        //       Sizes.size16,
        //     ),
        //   ),
        //   child: const Center(
        //     child: Text(
        //       "변경",
        //       style: TextStyle(
        //         fontSize: Sizes.size14,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
