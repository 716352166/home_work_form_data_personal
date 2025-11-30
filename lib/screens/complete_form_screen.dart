// screens/complete_form_screen.dart
import 'package:flutter/material.dart';
import '../models/user_form_data.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/skill_chip.dart';

class CompleteFormScreen extends StatefulWidget {
  const CompleteFormScreen({super.key});

  @override
  State<CompleteFormScreen> createState() => _CompleteFormScreenState();
}

class _CompleteFormScreenState extends State<CompleteFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // ** 1. Controllers for Text Fields **
  final TextEditingController _nameController = TextEditingController(
    text: 'Najm Al-Ahmadi',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'najm@example.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'securePass123',
  );
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // ** 2. State Variables for complex widgets **
  String? _selectedGender;
  String? _selectedCountry;
  DateTime? _selectedBirthDate;
  TimeOfDay? _selectedTime;
  String? _selectedExperienceLevel;
  List<String> _selectedSkills = [
    'Flutter',
    'Dart',
    'Firebase',
  ]; // قيم مبدئية لـ "Flutter, Dart, Firebase"
  double _satisfactionRating = 3.0;
  double _progressLevel = 50.0;
  RangeValues _budgetRange = const RangeValues(20, 80);
  bool _subscribeNewsletter = true;
  bool _termsAgreed = false; // يجب أن تكون false لفرض الموافقة

  // ** 3. Lookup Lists **
  final List<String> _genders = ['ذكر', 'أنثى', 'أخرى'];
  final List<String> _countries = ['السعودية', 'مصر', 'الإمارات', 'اليمن'];
  final List<String> _experienceLevels = ['مبتدئ', 'متوسط', 'خبير'];
  final List<String> _allSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'API Integration',
    'State Management',
    'UI/UX Design',
    'Testing',
  ];

  // ** 4. Validation and Submission Logic **

  // دالة التحقق الإلزامية
  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب.';
    }
    return null;
  }

  // دالة التحقق من القائمة المنسدلة (للقوائم الإلزامية)
  String? _dropdownValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'الرجاء اختيار $fieldName.';
    }
    return null;
  }

  // دالة التحقق من الشروط والأحكام
  String? _termsValidator(bool? value) {
    if (value != true) {
      return 'يجب الموافقة على الشروط والأحكام للمتابعة.';
    }
    return null;
  }

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    // التحقق من حقول الفورم النصية والقوائم المنسدلة الإلزامية
    if (_formKey.currentState!.validate() && _termsAgreed) {
      // إذا كانت جميع الحقول صالحة (بما في ذلك الشروط والأحكام)
      final formData = UserFormData(
        fullName: _nameController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text, // كلمة المرور
        phoneNumber: _phoneController.text.isNotEmpty
            ? _phoneController.text
            : null,
        age: int.tryParse(_ageController.text),
        gender: _selectedGender,
        country: _selectedCountry,
        birthDate: _selectedBirthDate,
        preferredTime: _selectedTime,
        experienceLevel: _selectedExperienceLevel,
        selectedSkills: _selectedSkills,
        bioDescription: _bioController.text.isNotEmpty
            ? _bioController.text
            : null,
        satisfactionRating: _satisfactionRating,
        progressLevel: _progressLevel,
        budgetRange: _budgetRange,
        subscribeNewsletter: _subscribeNewsletter,
        termsAgreed: _termsAgreed,
      );

      // طباعة البيانات إلى الـ Console
      formData.printToConsole();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال البيانات بنجاح! تحقق من الـ Console'),
        ),
      );
    } else {
      // إذا كان التحقق من الفورم لم ينجح، نقوم بعرض رسالة تنبيه
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'الرجاء تعبئة جميع الحقول المطلوبة والموافقة على الشروط.',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // ** 5. Build Method (UI) **
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Form Example'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: const Color.fromARGB(255, 176, 168, 168),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 1. Personal Information ---
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              CustomTextField(
                labelText: 'Full Name *',
                controller: _nameController,
                icon: Icons.person,
                validator: _requiredValidator,
              ),
              CustomTextField(
                labelText: 'Email Address *',
                controller: _emailController,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: _requiredValidator,
              ),
              CustomTextField(
                labelText: 'Password *',
                controller: _passwordController,
                icon: Icons.lock,
                isPassword: true,
                validator: _requiredValidator,
              ),
              CustomTextField(
                labelText: 'Phone Number',
                controller: _phoneController,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                labelText: 'Age',
                controller: _ageController,
                icon: Icons.cake,
                keyboardType: TextInputType.number,
              ),

              const Divider(height: 30),

              // --- 2. Demographics ---
              const Text(
                'Demographics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              _buildDropdown(
                'Gender',
                Icons.wc,
                _selectedGender,
                _genders,
                (value) => setState(() => _selectedGender = value),
                // لا يوجد شرط النجمة * في الصورة، لذا نجعله اختياري
              ),
              _buildDropdown(
                'Country',
                Icons.public,
                _selectedCountry,
                _countries,
                (value) => setState(() => _selectedCountry = value),
              ),

              const Divider(height: 30),

              // --- 3. Date & Time ---
              const Text(
                'Date & Time',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDateOrTimeButton(
                      'Birth Date',
                      Icons.calendar_today,
                      _selectedBirthDate,
                      _selectDate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDateOrTimeButton(
                      'Preferred Time',
                      Icons.access_time,
                      _selectedTime,
                      _selectTime,
                    ),
                  ),
                ],
              ),

              const Divider(height: 30),

              // --- 4. Skills & Experience ---
              const Text(
                'Skills & Experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              _buildDropdown(
                'Experience Level',
                Icons.work,
                _selectedExperienceLevel,
                _experienceLevels,
                (value) => setState(() => _selectedExperienceLevel = value),
              ),

              const SizedBox(height: 10),
              const Text(
                'Select Your Skills:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Wrap(
                children: _allSkills
                    .map(
                      (skill) => SkillChip(
                        skill: skill,
                        isSelected: _selectedSkills.contains(skill),
                        onTap: _toggleSkill,
                      ),
                    )
                    .toList(),
              ),

              CustomTextField(
                labelText: 'Bio/Description',
                controller: _bioController,
                icon: Icons.description,
                keyboardType: TextInputType.multiline,
              ),

              const Divider(height: 30),

              // --- 5. Ratings & Preferences ---
              const Text(
                'Ratings & Preferences',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              // Satisfaction Rating (Slider)
              _buildRatingSection(
                'Satisfaction Rating: ${_satisfactionRating.toStringAsFixed(1)}',
                Icons.star,
              ),
              Slider(
                value: _satisfactionRating,
                min: 1.0,
                max: 5.0,
                divisions: 8, // 1.0, 1.5, 2.0, ... 5.0
                label: _satisfactionRating.toStringAsFixed(1),
                onChanged: (double value) =>
                    setState(() => _satisfactionRating = value),
                activeColor: Colors.purple,
              ),

              // Progress Level (Slider)
              _buildRatingSection(
                'Progress Level: ${_progressLevel.toInt()}%',
                Icons.trending_up,
              ),
              Slider(
                value: _progressLevel,
                min: 0,
                max: 100,
                divisions: 100,
                label: _progressLevel.toInt().toString(),
                onChanged: (double value) =>
                    setState(() => _progressLevel = value),
                activeColor: Colors.purple,
              ),

              // Budget Range (RangeSlider)
              _buildRatingSection(
                'Budget Range: \$${_budgetRange.start.toStringAsFixed(0)} - \$${_budgetRange.end.toStringAsFixed(0)}',
                Icons.attach_money,
              ),
              RangeSlider(
                values: _budgetRange,
                min: 0,
                max: 200,
                divisions: 40,
                labels: RangeLabels(
                  '\$${_budgetRange.start.toStringAsFixed(0)}',
                  '\$${_budgetRange.end.toStringAsFixed(0)}',
                ),
                onChanged: (RangeValues values) =>
                    setState(() => _budgetRange = values),
                activeColor: Colors.purple,
              ),

              const Divider(height: 30),

              // --- 6. Preferences & Submit ---
              const Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              // Subscribe Toggle
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.notifications,
                  color: Colors.blueGrey,
                ),
                title: const Text('Subscribe to Newsletter'),
                subtitle: const Text('Receive updates and promotions'),
                trailing: Switch(
                  value: _subscribeNewsletter,
                  onChanged: (bool value) =>
                      setState(() => _subscribeNewsletter = value),
                  activeColor: Colors.blue,
                ),
              ),

              // Terms and Conditions Checkbox (Mandatory)
              FormField<bool>(
                initialValue: _termsAgreed,
                validator: _termsValidator, // استخدام دالة التحقق
                builder: (FormFieldState<bool> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _termsAgreed,
                            onChanged: (bool? value) {
                              setState(() {
                                _termsAgreed = value ?? false;
                                field.didChange(
                                  _termsAgreed,
                                ); // تحديث حالة الـ FormField
                              });
                            },
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _termsAgreed = !_termsAgreed;
                                  field.didChange(_termsAgreed);
                                });
                              },
                              child: const Text(
                                'I agree to the Terms and Conditions',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            field.errorText ?? '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit Form',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ** 7. Helper Widgets for better readability **

  // دالة مساعدة لإنشاء حقل القائمة المنسدلة
  Widget _buildDropdown(
    String label,
    IconData icon,
    String? currentValue,
    List<String> items,
    Function(String?) onChanged, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          prefixIcon: Icon(icon, color: Colors.blueGrey),
          border: const OutlineInputBorder(),
        ),
        value: currentValue,
        hint: Text('Select your $label'),
        items: items.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: onChanged,
        validator: required
            ? (value) => _dropdownValidator(value, label)
            : null,
      ),
    );
  }

  // دالة مساعدة لإنشاء زر التاريخ/الوقت
  Widget _buildDateOrTimeButton(
    String label,
    IconData icon,
    dynamic value,
    Function(BuildContext) onTap,
  ) {
    final String displayValue = value is DateTime
        ? value.toLocal().toString().split(' ')[0]
        : value is TimeOfDay
        ? value.format(context)
        : label;

    return OutlinedButton.icon(
      icon: Icon(icon),
      label: Text(displayValue, overflow: TextOverflow.ellipsis),
      onPressed: () => onTap(context),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  // دالة مساعدة لإنشاء قسم التقييمات
  Widget _buildRatingSection(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
