import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import 'package:my_portfolio/features/portfolio/models/live_app_model.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class LiveAppCard extends StatefulWidget {
  final LiveAppModel app;

  const LiveAppCard({super.key, required this.app});

  @override
  State<LiveAppCard> createState() => _LiveAppCardState();
}

class _LiveAppCardState extends State<LiveAppCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null || urlString.isEmpty || urlString == '#') return;
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTokens.r16.r),
            border: Border.all(color: AppTokens.border.withValues(alpha: 0.5)),
          ),
          clipBehavior: Clip.antiAlias,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                Image.asset(widget.app.coverImagePath, fit: BoxFit.cover),

                // Hover Overlay Gradient
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: _isHovered ? 0.8 : 0.0),
                        Colors.black.withValues(alpha: _isHovered ? 0.95 : 0.6),
                      ],
                    ),
                  ),
                ),

                // Base State (Only Title)
                AnimatedOpacity(
                  opacity: _isHovered ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(AppTokens.s20.w),
                      child: Text(
                        widget.app.title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Hover State (Full Content)
                AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.all(AppTokens.s24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.app.title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppTokens.s8.h),
                        Text(
                          widget.app.description,
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 14.sp,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppTokens.s16.h),

                        // Features Wrap
                        Wrap(
                          spacing: AppTokens.s8.w,
                          runSpacing: AppTokens.s4.h,
                          children: widget.app.features
                              .map(
                                (feature) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: AppTokens.accent,
                                    ),
                                    SizedBox(width: AppTokens.s4.w),
                                    Text(
                                      feature,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),

                        SizedBox(height: AppTokens.s12.h),

                        // Tech Stack Section
                        Text(
                          'Technology Stack:',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppTokens.s4.h),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ctrl.techIntegrations.map((item) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: AppTokens.s4.h,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 10.sp,
                                        height: 1.3,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '${item['category']}: ',
                                          style: const TextStyle(
                                            color: AppTokens.accent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(text: item['details']),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        SizedBox(height: AppTokens.s12.h),

                        // Store Buttons
                        Row(
                          children: [
                            if (widget.app.testFlightLink != null)
                              _StoreButton(
                                icon: Icons.flight_takeoff,
                                label: 'TestFlight',
                                onTap: () =>
                                    _launchUrl(widget.app.testFlightLink),
                              ),
                            if (widget.app.appStoreLink != null &&
                                widget.app.testFlightLink == null)
                              _StoreButton(
                                icon: Icons.apple,
                                label: 'App Store',
                                onTap: () =>
                                    _launchUrl(widget.app.appStoreLink),
                              ),
                            if (widget.app.playStoreLink != null &&
                                widget.app.testFlightLink == null) ...[
                              SizedBox(width: AppTokens.s12.w),
                              _StoreButton(
                                icon: Icons.play_arrow,
                                label: 'Play Store',
                                onTap: () =>
                                    _launchUrl(widget.app.playStoreLink),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StoreButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTokens.r8.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTokens.s16.w,
          vertical: AppTokens.s8.h,
        ),
        decoration: BoxDecoration(
          color: AppTokens.accent,
          borderRadius: BorderRadius.circular(AppTokens.r8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.black),
            SizedBox(width: AppTokens.s8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
