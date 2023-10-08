import 'package:flutter/material.dart';

class InterestChip extends StatefulWidget {
  const InterestChip({
    super.key,
    // required this.animation,
    required this.idx,
    required this.title,
    required this.selected,
    // required this.selectedItems,
    required this.updateItemFn,
  });

  // final Animation<double> animation;
  final int idx;
  final String title;
  final bool selected;
  final Function updateItemFn;
  // final List<String> selectedItems;

  @override
  State<InterestChip> createState() => _InterestChipState();
}

class _InterestChipState extends State<InterestChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 1,
    ),
  );

  @override
  void initState() {
    super.initState();
    _initOpacity();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initOpacity() {
    if (widget.selected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onTapSelected(int idx) {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    // widget.updateItemFn(widget.idx, _animationController.isCompleted);
    widget.updateItemFn(widget.idx);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(_animationController);
    return FadeTransition(
      // key: _gAnimatedtKey,
      opacity: fadeAnimation,
      child: GestureDetector(
        onTap: () => _onTapSelected(widget.idx),
        // child: Container(
        //   padding: const EdgeInsets.symmetric(
        //     vertical: Sizes.size14,
        //     horizontal: Sizes.size16,
        //   ),
        //   decoration: BoxDecoration(
        //     // color: _isSelected
        //     //     ? Theme.of(context).primaryColor
        //     //     : isDarkMod(context)
        //     //         ? Colors.grey.shade700
        //     //         : Colors.white,
        //     borderRadius: BorderRadius.circular(
        //       Sizes.size28,
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.1),
        //         blurRadius: Sizes.size5,
        //         spreadRadius: Sizes.size5,
        //       ),
        //     ],
        //   ),
        //   child: const Text(
        //     "sdfsdfsdf",
        //     style: TextStyle(
        //       // color: _isSelected ? Colors.white : Colors.black87,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        child: Chip(
          clipBehavior: Clip.antiAlias,
          // key: _gAnimatedtKey,
          backgroundColor: Theme.of(context).primaryColor,
          label: Text(widget.title),
        ),
      ),
    );
  }
}
