import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
    required this.screenWidth,
    required this.animation,
    required this.animationController,
    required this.onSubmit,
    required this.headingText,
    required this.textController,
  });

  final double screenWidth;
  final Animation animation;
  final AnimationController animationController;
  final VoidCallback onSubmit;
  final String headingText;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
            bottom: animation.value,
            child: Container(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              width: screenWidth,
              height: Sizes.appBarHeight * 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$headingText:',
                    style: const TextStyle(
                      fontFamily: 'SecularOne',
                    ),
                  ),
                  const SpaceBetweenItems(),
                  TextField(
                    onSubmitted: (value) => onSubmit(),
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus!.unfocus(),
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Enter new value',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2)),
                    ),
                  ),
                  const SpaceBetweenItems(),
                  ElevatedButton(
                    onPressed: () => onSubmit(),
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue),
                        elevation: WidgetStateProperty.all(3),
                        enableFeedback: true,
                        shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ))),
                    child: const Text('Submit'),
                  )
                ],
              ),
            ));
      },
    );
  }
}
