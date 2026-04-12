import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_tokens.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  final _isLoading = false.obs;
  final _submitStatus = Rxn<String>();

  // Your email address for FormSubmit
  static const String _recipientEmail = 'shahriasayad9@gmail.com';
  static const String _formSubmitUrl =
      'https://formsubmit.co/ajax/$_recipientEmail';

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _isLoading.value = true;
    _submitStatus.value = null;

    try {
      final response = await http
          .post(
            Uri.parse(_formSubmitUrl),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: {
              'email': _emailController.text,
              'message': _messageController.text,
              '_captcha': 'false',
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _submitStatus.value = 'success';
        _emailController.clear();
        _messageController.clear();

        Get.snackbar(
          'Success',
          'Message sent successfully!',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        await Future.delayed(const Duration(seconds: 2));
        _submitStatus.value = null;
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      _submitStatus.value = 'error';
      Get.snackbar(
        'Error',
        'Failed to send message. Please try again.',
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      await Future.delayed(const Duration(seconds: 2));
      _submitStatus.value = null;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Your Email',
              labelStyle: TextStyle(color: AppTokens.textMuted),
              hintText: 'you@example.com',
              hintStyle: TextStyle(color: AppTokens.textMuted.withOpacity(0.5)),
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
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: TextStyle(color: AppTokens.textMuted),
              hintText: 'Tell me about your project...',
              hintStyle: TextStyle(color: AppTokens.textMuted.withOpacity(0.5)),
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

          // Submit button
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading.value ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTokens.accent,
                  disabledBackgroundColor: AppTokens.accent.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading.value
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
