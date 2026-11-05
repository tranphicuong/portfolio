import 'package:flutter/material.dart';

import '../models/contact_message.dart';
import '../services/contact_service.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import 'custom_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ContactService _service = const ContactService();

  bool _isSubmitting = false;

  
  int _formVersion = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      _showSnackBar(
        'Vui lòng kiểm tra lại các trường đang báo lỗi.',
        isError: true,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    String? errorMessage;
    try {
      await _service.send(
        ContactMessage(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          message: _messageController.text.trim(),
        ),
      );
    } on ContactException catch (error) {
      errorMessage = error.message;
    } catch (_) {
      errorMessage = 'Đã có lỗi không xác định. Vui lòng thử lại.';
    }

    if (!mounted) return;

    
    setState(() => _isSubmitting = false);

    if (errorMessage != null) {
      _showSnackBar(errorMessage, isError: true);
      return;
    }


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _resetForm();
    });
    _showSnackBar('Gửi thành công! Cảm ơn bạn, mình sẽ phản hồi sớm nhất.');
  }

  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    // Đổi key => dựng lại các ô mới, xoá luôn trạng thái validate.
    setState(() => _formVersion++);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final scheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? scheme.error : const Color(0xFF16A34A),
          content: Row(
            children: [
              Icon(
                isError
                    ? Icons.error_outline_rounded
                    : Icons.check_circle_outline_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }

  InputDecoration _decoration({
    required String label,
    IconData? icon,
    String? hint,
    String? helper,
    bool alignLabelWithHint = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      alignLabelWithHint: alignLabelWithHint,
      prefixIcon: icon == null ? null : Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Biểu mẫu liên hệ',
      child: Form(
        key: _formKey,
        child: KeyedSubtree(
          key: ValueKey<int>(_formVersion),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                enabled: !_isSubmitting,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.name,
                decoration: _decoration(
                  label: 'Họ và tên',
                  icon: Icons.person_outline_rounded,
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _emailController,
                enabled: !_isSubmitting,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.email,
                decoration: _decoration(
                  label: 'Email',
                  hint: 'ten@gmail.com',
                  icon: Icons.mail_outline_rounded,
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _messageController,
                enabled: !_isSubmitting,
                minLines: 4,
                maxLines: 6,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.message,
                decoration: _decoration(
                  label: 'Nội dung tin nhắn',
                  helper: 'Tối thiểu ${AppValidation.minMessageLength} ký tự',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: _isSubmitting ? 'Đang gửi...' : 'Gửi tin nhắn',
                icon: Icons.send_rounded,
                isLoading: _isSubmitting,
                expand: true,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}