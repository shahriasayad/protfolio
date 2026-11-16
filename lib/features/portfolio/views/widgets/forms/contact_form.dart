import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import '../../../viewmodels/portfolio_controller.dart';

/// Contact form card with controller-backed validation and reactive submit state.
class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return Container(
      padding: const EdgeInsets.all(AppTokens.s24),
      decoration: BoxDecoration(
        color: AppTokens.bg,
        borderRadius: BorderRadius.circular(AppTokens.r12),
        border: Border.all(color: AppTokens.border),
      ),
      child: Form(
        key: ctrl.contactFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppTokens.s12,
                runSpacing: AppTokens.s4,
                children: [
                  Text(
                    'DIRECT INQUIRY',
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppTokens.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '24–48h reply',
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppTokens.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.s20),
            _FieldLabel(label: 'YOUR EMAIL'),
            const SizedBox(height: AppTokens.s8),
            TextFormField(
              controller: ctrl.contactEmailController,
              keyboardType: TextInputType.emailAddress,
              style: AppTextStyles.body(
                fontSize: 14,
                color: AppTokens.textPrimary,
                height: 1.4,
              ),
              decoration: _inputDecoration(hint: 'you@company.com'),
              validator: ctrl.validateEmail,
            ),
            const SizedBox(height: AppTokens.s20),
            _FieldLabel(label: 'PROJECT DETAILS'),
            const SizedBox(height: AppTokens.s8),
            TextFormField(
              controller: ctrl.contactMessageController,
              maxLines: 5,
              style: AppTextStyles.body(
                fontSize: 14,
                color: AppTokens.textPrimary,
                height: 1.5,
              ),
              decoration: _inputDecoration(
                hint: 'Share scope, timeline, or what you are building...',
              ),
              validator: ctrl.validateMessage,
            ),
            const SizedBox(height: AppTokens.s24),
            Obx(
              () {
                final isSubmitting = ctrl.isContactSubmitting.value;
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : ctrl.submitContactForm,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppTokens.textPrimary,
                      foregroundColor: AppTokens.bg,
                      disabledBackgroundColor: AppTokens.surfaceElevated,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTokens.s16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTokens.r8),
                      ),
                    ),
                    child: isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTokens.accent,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Send Message',
                                style: AppTextStyles.button(
                                  fontSize: 14,
                                  color: AppTokens.bg,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: AppTokens.s8),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                                color: AppTokens.bg,
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.body(
        fontSize: 13,
        color: AppTokens.textMuted,
        height: 1.4,
      ),
      filled: true,
      fillColor: AppTokens.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTokens.s14,
        vertical: AppTokens.s14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r8),
        borderSide: const BorderSide(color: AppTokens.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r8),
        borderSide: const BorderSide(color: AppTokens.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r8),
        borderSide: const BorderSide(color: AppTokens.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r8),
        borderSide: const BorderSide(color: AppTokens.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r8),
        borderSide: const BorderSide(color: AppTokens.error, width: 1.5),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.mono(
        fontSize: 11,
        color: AppTokens.textSecondary,
        letterSpacing: 0.8,
      ),
    );
  }
}
