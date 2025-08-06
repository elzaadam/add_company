import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_company_controller.dart';

class AddCompanyPage extends StatelessWidget {
  final controller = Get.put(AddCompanyController());

  AddCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F5),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Add Company",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Company Logo Title
              _sectionTitle("Company Logo"),

              // Logo Picker
              Obx(() {
                return GestureDetector(
                  onTap: controller.pickLogoImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: controller.logoImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              controller.logoImage.value!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Colors.black54,
                                ),
                                Text(
                                  "Logo",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Company Name
              _sectionTitle("Company Name"),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _inputDecoration("Enter Company Name"),
                onChanged: (val) => controller.companyName.value = val,
                validator: (val) =>
                    val!.isEmpty ? "Company name is required" : null,
              ),
              const SizedBox(height: 16),

              // Company Email
              _sectionTitle("Company Email ID"),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _inputDecoration("Enter Company Email ID"),
                onChanged: (val) => controller.companyEmail.value = val,
                validator: (val) => val!.isEmpty ? "Email is required" : null,
              ),
              const SizedBox(height: 16),

              // About Company
              _sectionTitle("About Company"),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _inputDecoration("Write About Company.."),
                maxLines: 3,
                onChanged: (val) => controller.aboutCompany.value = val,
                validator: (val) =>
                    val!.isEmpty ? "Description is required" : null,
              ),
              const SizedBox(height: 16),

              // Checkboxes
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("I agree to share my company profile."),
                  value: controller.shareProfile.value,
                  onChanged: (val) =>
                      controller.shareProfile.value = val ?? false,
                ),
              ),
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                    "I agree to use photos and videos for in social media.",
                  ),
                  value: controller.agreeMedia.value,
                  onChanged: (val) =>
                      controller.agreeMedia.value = val ?? false,
                ),
              ),
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                    text: TextSpan(
                      text: "I agree the ",
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "license agreement.",
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: controller.agreeLicense.value,
                  onChanged: (val) =>
                      controller.agreeLicense.value = val ?? false,
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF888A6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.submitForm,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Title Widget
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  // Input Field Decoration
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }
}
