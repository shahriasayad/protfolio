import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

/// Handles external links, clipboard helpers, form validation, and contact API calls.
class PortfolioService {
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  Future<void> openExternalUrl(
    String? rawUrl, {
    LaunchMode mode = LaunchMode.platformDefault,
    String errorMessage = 'Could not open link.',
  }) async {
    if (rawUrl == null || rawUrl.trim().isEmpty || rawUrl == '#') {
      return;
    }

    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null) {
      EasyLoading.showError(errorMessage);
      return;
    }

    try {
      final launched = await launchUrl(uri, mode: mode);
      if (!launched) {
        EasyLoading.showError(errorMessage);
      }
    } catch (_) {
      EasyLoading.showError(errorMessage);
    }
  }

  Future<void> openEmailClient(String emailAddress) async {
    final emailUri = Uri(scheme: 'mailto', path: emailAddress);
    await openExternalUrl(
      emailUri.toString(),
      errorMessage: 'Could not launch email client.',
    );
  }

  Future<void> copyToClipboard(String text, {String? toastMessage}) async {
    await Clipboard.setData(ClipboardData(text: text));
    EasyLoading.showToast(toastMessage ?? 'Copied to clipboard');
  }

  String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMessage(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Message is required';
    }
    if (trimmed.length < 10) {
      return 'Message should be at least 10 characters';
    }
    return null;
  }

  Future<bool> submitContactMessage({
    required String targetEmail,
    required String senderEmail,
    required String message,
  }) async {
    final response = await http
        .post(
          Uri.parse('https://formsubmit.co/ajax/$targetEmail'),
          headers: const {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'email': senderEmail.trim(),
            'message': message.trim(),
            '_captcha': 'false',
          },
        )
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception('Request timeout'),
        );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
