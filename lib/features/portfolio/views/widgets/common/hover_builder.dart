import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodels/portfolio_controller.dart';

/// Stateless hover and click wrapper backed by targeted GetBuilder rebuilds.
class HoverBuilder extends StatelessWidget {
  final String hoverId;
  final VoidCallback? onTap;
  final MouseCursor cursor;
  final Widget Function(BuildContext context, bool isHovered) builder;

  const HoverBuilder({
    super.key,
    required this.hoverId,
    required this.builder,
    this.onTap,
    this.cursor = SystemMouseCursors.click,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return MouseRegion(
      cursor: onTap != null ? cursor : MouseCursor.defer,
      onEnter: (_) => ctrl.setHovered(hoverId, true),
      onExit: (_) => ctrl.setHovered(hoverId, false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: GetBuilder<PortfolioController>(
          id: 'hover_$hoverId',
          builder: (controller) => builder(context, controller.isHovered(hoverId)),
        ),
      ),
    );
  }
}
