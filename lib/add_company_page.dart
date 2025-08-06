import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_company_controller.dart';

class AddCompanyPage extends StatelessWidget {
  final controller = Get.put(AddCompanyController());

  AddCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Add Company', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Company Logo",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: controller.pickLogoImage,
                child: Obx(() {
                  final logo = controller.logoImage.value;
                  return Container(
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF8F8F4),
                    ),
                    child: logo == null
                        ? const Center(
                            child: Text('+\nLogo', textAlign: TextAlign.center),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(logo, fit: BoxFit.cover),
                          ),
                  );
                }),
              ),

              const SizedBox(height: 24),
              buildTextField(
                label: "Company Name",
                hint: "Enter Company Name",
                onSaved: (val) => controller.companyName.value = val!.trim(),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Company name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: "Company Email ID",
                hint: "Enter Company Email ID",
                onSaved: (val) => controller.companyEmail.value = val!.trim(),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!GetUtils.isEmail(val.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: "About Company",
                hint: "Write About Company..",
                maxLines: 4,
                onSaved: (val) => controller.aboutCompany.value = val!.trim(),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Company description is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              Obx(
                () => buildCheckbox(
                  "I agree to share my company profile.",
                  controller.shareProfile.value,
                  (val) => controller.shareProfile.value = val ?? false,
                ),
              ),
              Obx(
                () => buildCheckbox(
                  "I agree to use photos and videos for in social media.",
                  controller.agreeMedia.value,
                  (val) => controller.agreeMedia.value = val ?? false,
                ),
              ),
              Obx(
                () => buildCheckboxRichText(
                  const Text.rich(
                    TextSpan(
                      text: 'I agree the ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'license agreement.',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  controller.agreeLicense.value,
                  (val) => controller.agreeLicense.value = val ?? false,
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C8F6F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.submitForm,
                  child: const Text('Continue', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            maxLines: maxLines,
            onSaved: onSaved,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget buildCheckboxRichText(
    Widget label,
    bool value,
    Function(bool?) onChanged,
  ) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: label,
      value: value,
      onChanged: onChanged,
    );
  }
}
