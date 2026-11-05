import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/contact_message.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ContactException implements Exception {
  const ContactException(this.message);

  final String message;

  @override
  String toString() => message;
}


class ContactService {
  const ContactService();

  static const String simulateErrorKeyword = '#error';

  static const Duration _timeout = Duration(seconds: 10);
  

  Future<void> send(ContactMessage message) async {
    
    if (message.message.contains(simulateErrorKeyword)) {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      throw const ContactException(
        'Không thể gửi tin nhắn lúc này. Vui lòng thử lại sau.',
      );
    }
    if (Firebase.apps.isEmpty) {
     throw const ContactException(
        'Chưa kết nối được máy chủ. Vui lòng thử lại sau.',
      );
    }
    try{
      await FirebaseFirestore.instance.collection('contacts').add({
        'name':message.name,
        'email':message.email,
        'message':message.message,
        'createdAt':FieldValue.serverTimestamp(),
      }).timeout(_timeout);
    } on TimeoutException {
      throw const ContactException(
        'Kết nối quá chậm. Vui lòng kiểm tra mạng và thử lại.',
      );
    } on FirebaseException catch (e) {
      throw ContactException(
        e.code == 'permission-denied'
            ? 'Tin nhắn không hợp lệ hoặc bị từ chối. Vui lòng kiểm tra lại.'
            :
        'Lỗi khi gửi tin nhắn: ${e.message}',
      );
    } catch (e) {
      throw ContactException(
        'Lỗi không xác định: $e',
      );
    }
    await _notifyEmailJs(message);
  }
}

//ham gui email thong bao khi co tin nhan moi
Future<void> _notifyEmailJs(ContactMessage message) async {
  try{
    final response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_id': EmailJsConfig.serviceId,
        'template_id': EmailJsConfig.templateId,
        'user_id': EmailJsConfig.publicKey,
        'template_params': {
          'from_name': message.name,
          'from_email': message.email,
          'message': message.message,
          'reply_to': message.email,
        },
      }),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw ContactException(
        'Không thể gửi email thông báo. Mã lỗi: ${response.statusCode}',
      );
    }
  } on TimeoutException {
    throw const ContactException(
      'Kết nối quá chậm khi gửi email thông báo. Vui lòng kiểm tra mạng và thử lại.',
    );
  } catch (e) {
    throw ContactException(
      'Lỗi khi gửi email thông báo: $e',
    );
  }
}