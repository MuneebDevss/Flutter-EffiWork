import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';

class SpaceBetweenSections extends StatelessWidget {
  const SpaceBetweenSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spaceBtwSections,
    );
  }
}
class SpaceBetweenItems extends StatelessWidget {
  const SpaceBetweenItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Sizes.spaceBtwItems,
    );
  }
}