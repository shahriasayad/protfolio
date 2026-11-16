import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/common/portfolio_section_header.dart';
import '../widgets/common/section_wrapper.dart';

/// About section - editorial two-column overview and engineering focus ledger.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppScreenUtil.isDesktopWidth(width);

    const header = PortfolioSectionHeader(
      sectionIndex: '01',
      title: 'About',
      subtitle: 'Who I am and how I work.',
    );

    final narrative = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            ctrl.bio.value.trim(),
            style: AppTextStyles.body(
              fontSize: 16,
              color: AppTokens.textPrimary,
              height: 1.75,
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s28),
        const _SpecRow(
          label: 'CORE STACK',
          value: 'Flutter · Dart · GetX · REST APIs · Firebase',
        ),
        const _SpecRow(
          label: 'FOCUS AREAS',
          value: 'Clean architecture, responsive UI systems, production speed',
        ),
        const _SpecRow(
          label: 'DELIVERY',
          value: 'End-to-end execution from Figma specs to App Store & Play Store',
          isLast: true,
        ),
      ],
    );

    return SectionWrapper(
      tone: SectionTone.tinted,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 4, child: header),
                const SizedBox(width: AppTokens.s48),
                Expanded(flex: 7, child: narrative),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(height: AppTokens.s24),
                narrative,
              ],
            ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _SpecRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.s14),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: AppTokens.border),
          bottom: isLast
              ? const BorderSide(color: AppTokens.border)
              : BorderSide.none,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final narrow = constraints.maxWidth < 460;
          if (narrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppTokens.accent,
                  ),
                ),
                const SizedBox(height: AppTokens.s4),
                Text(
                  value,
                  style: AppTextStyles.body(
                    fontSize: 14,
                    color: AppTokens.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  label,
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppTokens.accent,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(width: AppTokens.s16),
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.body(
                    fontSize: 14,
                    color: AppTokens.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
