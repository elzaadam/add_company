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

  final picker = ImagePicker();

  void pickLogoImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      logoImage.value = File(pickedFile.path);
    }
  }

  void submitForm() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Form Error',
        'Please enter all required fields properly.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
      return;
    }

    formKey.currentState!.save();

    if (!agreeLicense.value) {
      Get.snackbar('Error', 'You must agree to the license agreement.');
      return;
    }

    try {
      final uri = Uri.parse("https://api.hedvigg-dev.com/api/company/create");

      var request = http.MultipartRequest("POST", uri);

      // 🔹 Required Fields
      request.fields['Content-Type'] = 'multipart/form-data';
      request.fields['N_T_M_User_ID'] = '1'; // Replace with actual value
      request.fields['N_T_M_Company_ID'] = '1'; // Replace with actual value
      request.fields['N_T_M_Country_ID'] = '1'; // Replace with actual value
      request.fields['V_CompanyName'] = companyName.value;
      request.fields['V_CompanyEmailID'] = companyEmail.value;
      request.fields['V_Description'] = aboutCompany.value;

      // 🔸 Optional or additional
      request.fields['V_PaymentDuration'] = '30'; // example
      request.fields['B_PublicProfile'] = shareProfile.value ? '1' : '0';
      request.fields['B_AudioVideo'] = agreeMedia.value ? '1' : '0';
      request.fields['N_T_M_LicenseHd_ID'] = '1'; // Replace as needed
      request.fields['N_T_M_LicenseCityStateCountry_Link_ID'] = '1'; // Replace
      request.fields['N_InsertedBy_ID'] = '1'; // Replace as needed

      if (logoImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('logo', logoImage.value!.path),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Company created successfully!');
      } else {
        Get.snackbar(
          'Error',
          'Failed to create company (${response.statusCode})',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
}
