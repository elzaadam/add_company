import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedvigg_project/add_company_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Company Creator',
      home: AddCompanyPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
