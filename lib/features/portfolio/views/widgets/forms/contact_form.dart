import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_tokens.dart';
import '../../../viewmodels/portfolio_controller.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return Form(
      key: ctrl.contactFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: ctrl.contactEmailController,
            decoration: InputDecoration(
              labelText: 'Your Email',
              labelStyle: TextStyle(color: AppTokens.textMuted),
              hintText: 'you@example.com',
              hintStyle: TextStyle(
                color: AppTokens.textMuted.withValues(alpha: 0.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTokens.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTokens.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTokens.accent, width: 2),
              ),
              filled: true,
              fillColor: AppTokens.bg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: TextStyle(color: AppTokens.textPrimary),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: AppTokens.s16),

          TextFormField(
            controller: ctrl.contactMessageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: TextStyle(color: AppTokens.textMuted),
              hintText: 'Tell me about your project...',
              hintStyle: TextStyle(
                color: AppTokens.textMuted.withValues(alpha: 0.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTokens.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTokens.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppTokens.accent, width: 2),
              ),
              filled: true,
              fillColor: AppTokens.bg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: TextStyle(color: AppTokens.textPrimary),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message is required';
              }
              if (value.length < 10) {
                return 'Message should be at least 10 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: AppTokens.s24),
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ctrl.isContactSubmitting.value
                    ? null
                    : ctrl.submitContactForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTokens.accent,
                  disabledBackgroundColor: AppTokens.accent.withValues(
                    alpha: 0.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: ctrl.isContactSubmitting.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTokens.textPrimary,
                          ),
                        ),
                      )
                    : Text(
                        'Send Message',
                        style: GoogleFonts.spaceGrotesk(
                          color: AppTokens.bg,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
