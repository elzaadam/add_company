import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddCompanyController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var companyName = ''.obs;
  var companyEmail = ''.obs;
  var aboutCompany = ''.obs;

  var shareProfile = false.obs;
  var agreeMedia = false.obs;
  var agreeLicense = false.obs;

  var logoImage = Rx<File?>(null);
  var isFormValid = false.obs;

  // Constants
  final userId = 7;
  final companyId = 91;
  final countryId = 1;
  final insertedById = 91;

  final String accessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOX1RfTV9Vc2VyX0lEIjoyLCJWX1VzZXJOYW1lIjoiamdhcnVucmFqQGdtYWlsLmNvbSIsImlhdCI6MTc1NDQ4NjQ3NCwiZXhwIjoxNzU0NTcyODc0fQ.sU3QS5WWIHGT29S5qoPtgUa8_8WCeN5gjXn3hTciJ-k';

  void validateForm() {
    isFormValid.value =
        companyName.value.isNotEmpty &&
        companyEmail.value.isNotEmpty &&
        aboutCompany.value.isNotEmpty &&
        agreeLicense.value;
  }

  Future<void> pickLogoImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      logoImage.value = File(picked.path);
    }
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (!agreeLicense.value) {
      Get.snackbar("Agreement Required", "You must agree to the license.");
      return;
    }

    final uri = Uri.parse('https://api.hedvigg-dev.com/api/company/create');
    final request = http.MultipartRequest('POST', uri);

    request.fields['N_T_M_User_ID'] = userId.toString();
    request.fields['N_T_M_Company_ID'] = companyId.toString();
    request.fields['N_T_M_Country_ID'] = countryId.toString();
    request.fields['V_CompanyName'] = companyName.value;
    request.fields['V_CompanyEmailID'] = companyEmail.value;
    request.fields['V_Description'] = aboutCompany.value;
    request.fields['B_PublicProfile'] = shareProfile.value ? '1' : '0';
    request.fields['B_AudioVideo'] = agreeMedia.value ? '1' : '0';
    request.fields['N_InsertedBy_ID'] = insertedById.toString();
    request.fields['V_PaymentDuration'] = '7';
    request.fields['N_T_M_LicenseHd_ID'] = '1';
    request.fields['N_T_M_LicenseCityStateCountry_Link_ID'] = '0';

    if (logoImage.value != null) {
      request.files.add(
        await http.MultipartFile.fromPath('logo', logoImage.value!.path),
      );
    }

    request.headers['accessToken'] = accessToken;

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Company created successfully!");
      } else {
        Get.snackbar("Error", "Submission failed: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
