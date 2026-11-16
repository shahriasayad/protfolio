import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../models/project_model.dart';
import '../../../viewmodels/portfolio_controller.dart';
import '../common/hover_builder.dart';

/// Project showcase card supporting both spotlight and supporting grid layouts.
class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;
  final bool isFeatured;
  final bool horizontalLayout;

  const ProjectCard({
    super.key,
    required this.project,
    this.index = 0,
    this.isFeatured = false,
    bool? horizontalLayout,
  }) : horizontalLayout = horizontalLayout ?? isFeatured;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final indexLabel = (index + 1).toString().padLeft(2, '0');

    return HoverBuilder(
      hoverId: 'project_${project.title}',
      onTap: () => ctrl.openUrl(
        project.link,
        external: true,
        errorMessage: 'Could not open ${project.title}.',
      ),
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: hovered ? AppTokens.surfaceAlt : AppTokens.surface,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(
              color: hovered ? AppTokens.accent : AppTokens.border,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: horizontalLayout
              ? _FeaturedProjectLayout(
                  project: project,
                  indexLabel: indexLabel,
                  hovered: hovered,
                  isFeatured: isFeatured,
                )
              : _StandardProjectLayout(
                  project: project,
                  indexLabel: indexLabel,
                  hovered: hovered,
                ),
        );
      },
    );
  }
}

class _FeaturedProjectLayout extends StatelessWidget {
  final ProjectModel project;
  final String indexLabel;
  final bool hovered;
  final bool isFeatured;

  const _FeaturedProjectLayout({
    required this.project,
    required this.indexLabel,
    required this.hovered,
    required this.isFeatured,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 740;
        final preview = _ProjectVisualHeader(
          project: project,
          hovered: hovered,
          aspectRatio: isWide ? 16 / 11 : 16 / 9,
        );
        final body = _ProjectBody(
          project: project,
          indexLabel: indexLabel,
          hovered: hovered,
          isFeatured: isFeatured,
        );

        if (!isWide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTokens.s16,
                  AppTokens.s16,
                  AppTokens.s16,
                  0,
                ),
                child: preview,
              ),
              Padding(
                padding: const EdgeInsets.all(AppTokens.s20),
                child: body,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.s20),
                child: preview,
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTokens.s8,
                  AppTokens.s24,
                  AppTokens.s24,
                  AppTokens.s24,
                ),
                child: body,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StandardProjectLayout extends StatelessWidget {
  final ProjectModel project;
  final String indexLabel;
  final bool hovered;

  const _StandardProjectLayout({
    required this.project,
    required this.indexLabel,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTokens.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectVisualHeader(
            project: project,
            hovered: hovered,
            aspectRatio: 16 / 9,
          ),
          const SizedBox(height: AppTokens.s16),
          _ProjectBody(
            project: project,
            indexLabel: indexLabel,
            hovered: hovered,
            isFeatured: false,
          ),
        ],
      ),
    );
  }
}

class _ProjectBody extends StatelessWidget {
  final ProjectModel project;
  final String indexLabel;
  final bool hovered;
  final bool isFeatured;

  const _ProjectBody({
    required this.project,
    required this.indexLabel,
    required this.hovered,
    required this.isFeatured,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                isFeatured ? '$indexLabel // SPOTLIGHT' : 'PROJECT $indexLabel',
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: isFeatured ? AppTokens.accent : AppTokens.textMuted,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppTokens.s8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'GitHub',
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: hovered ? AppTokens.accent : AppTokens.textMuted,
                  ),
                ),
                const SizedBox(width: AppTokens.s4),
                Icon(
                  Icons.north_east_rounded,
                  size: 14,
                  color: hovered ? AppTokens.accent : AppTokens.textMuted,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppTokens.s10),
        Text(
          project.title,
          style: AppTextStyles.cardTitle(fontSize: isFeatured ? 23 : 18),
        ),
        const SizedBox(height: AppTokens.s8),
        Text(
          project.description,
          style: AppTextStyles.body(
            fontSize: isFeatured ? 14 : 13,
            color: AppTokens.textSecondary,
            height: 1.55,
          ),
        ),
        const SizedBox(height: AppTokens.s14),

        // Key engineering impact strip
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s12,
            vertical: AppTokens.s10,
          ),
          decoration: BoxDecoration(
            color: AppTokens.bg,
            borderRadius: BorderRadius.circular(AppTokens.r6),
            border: const Border(
              left: BorderSide(color: AppTokens.accent, width: 2),
            ),
          ),
          child: Text(
            project.impact,
            style: AppTextStyles.body(
              fontSize: 12,
              color: AppTokens.textPrimary,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s14),

        // Tech stack tags
        Wrap(
          spacing: AppTokens.s6,
          runSpacing: AppTokens.s6,
          children: project.tech
              .map(
                (tech) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.s8,
                    vertical: AppTokens.s4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTokens.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppTokens.r4),
                    border: Border.all(color: AppTokens.border),
                  ),
                  child: Text(
                    tech,
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppTokens.textSecondary,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ProjectVisualHeader extends StatelessWidget {
  final ProjectModel project;
  final bool hovered;
  final double aspectRatio;

  const _ProjectVisualHeader({
    required this.project,
    required this.hovered,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final coverPath = project.coverImagePath;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTokens.r8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTokens.bg,
          border: Border.all(color: AppTokens.border),
          borderRadius: BorderRadius.circular(AppTokens.r8),
        ),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: coverPath != null
              ? AnimatedScale(
                  scale: hovered ? 1.04 : 1.0,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    coverPath,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    cacheWidth: kIsWeb ? null : 960,
                    errorBuilder: (context, error, stackTrace) =>
                        _ProjectSchematicPreview(project: project),
                  ),
                )
              : _ProjectSchematicPreview(project: project),
        ),
      ),
    );
  }
}

/// Crisp architectural spec preview for projects without raster cover assets.
class _ProjectSchematicPreview extends StatelessWidget {
  final ProjectModel project;

  const _ProjectSchematicPreview({required this.project});

  @override
  Widget build(BuildContext context) {
    final slug = project.title.toLowerCase().replaceAll(' ', '_');

    return Container(
      padding: const EdgeInsets.all(AppTokens.s16),
      decoration: const BoxDecoration(
        color: AppTokens.bg,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTokens.surfaceSoft, AppTokens.bg],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.terminal_rounded,
                size: 14,
                color: AppTokens.accent,
              ),
              const SizedBox(width: AppTokens.s6),
              Expanded(
                child: Text(
                  'package:$slug/main.dart',
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppTokens.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                project.emoji,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const Spacer(),
          Text(
            project.title,
            style: AppTextStyles.cardTitle(fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppTokens.s6),
          Text(
            project.tech.take(3).join('  ·  '),
            style: AppTextStyles.mono(
              fontSize: 11,
              color: AppTokens.accent,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTokens.statusLive,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Expanded(
                child: Text(
                  'Open source repository on GitHub',
                  style: AppTextStyles.mono(
                    fontSize: 10,
                    color: AppTokens.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
