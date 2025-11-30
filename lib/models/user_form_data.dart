// models/user_form_data.dart
import 'package:flutter/material.dart';

class UserFormData {
  // Personal Information
  final String fullName;
  final String emailAddress;
  final String password;
  final String? phoneNumber; // اختياري
  final int? age; // اختياري

  // Demographics
  final String? gender;
  final String? country;

  // Date & Time
  final DateTime? birthDate;
  final TimeOfDay? preferredTime;

  // Skills & Experience
  final String? experienceLevel;
  final List<String> selectedSkills;
  final String? bioDescription; // اختياري

  // Ratings & Preferences
  final double satisfactionRating;
  final double progressLevel;
  final RangeValues budgetRange;

  // Preferences
  final bool subscribeNewsletter;
  final bool termsAgreed;

  UserFormData({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    this.phoneNumber,
    this.age,
    this.gender,
    this.country,
    this.birthDate,
    this.preferredTime,
    this.experienceLevel,
    required this.selectedSkills,
    this.bioDescription,
    required this.satisfactionRating,
    required this.progressLevel,
    required this.budgetRange,
    required this.subscribeNewsletter,
    required this.termsAgreed,
  });

  // دالة لطباعة البيانات إلى الـ Console
  void printToConsole() {
    print('==================== تم إرسال البيانات بنجاح ====================');
    print('1. معلومات شخصية:');
    print('   الاسم: $fullName');
    print('   الإيميل: $emailAddress');
    print('   كلمة المرور: $password (لغرض الاختبار فقط)');
    print('   الهاتف: ${phoneNumber ?? 'لم يُدخل'}');
    print('   العمر: ${age ?? 'لم يُدخل'}');

    print('\n2. التركيبة السكانية:');
    print('   الجنس: ${gender ?? 'لم يُختر'}');
    print('   البلد: ${country ?? 'لم يُختر'}');

    print('\n3. التاريخ والوقت:');
    print(
      '   تاريخ الميلاد: ${birthDate?.toLocal().toString().split(' ')[0] ?? 'لم يُختر'}',
    );
    print('   الوقت المفضل: ${preferredTime ?? 'لم يُختر'}');

    print('\n4. المهارات والخبرة:');
    print('   مستوى الخبرة: ${experienceLevel ?? 'لم يُختر'}');
    print('   المهارات المختارة: ${selectedSkills.join(', ')}');
    print('   الوصف: ${bioDescription ?? 'لا يوجد'}');

    print('\n5. التقييمات والتفضيلات:');
    print('   تقييم الرضا: ${satisfactionRating.toStringAsFixed(1)}');
    print('   مستوى التقدم: ${progressLevel.toInt()}%');
    print(
      '   نطاق الميزانية: \$${budgetRange.start.toStringAsFixed(0)} - \$${budgetRange.end.toStringAsFixed(0)}',
    );

    print('\n6. التفضيلات:');
    print('   اشتراك النشرة: ${subscribeNewsletter ? 'موافق' : 'غير موافق'}');
    print('   الموافقة على الشروط: ${termsAgreed ? 'موافق' : 'غير موافق'}');
    print('===============================================================');
  }
}
