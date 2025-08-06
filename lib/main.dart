import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_company_page.dart';

void main() {
  runApp(MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Company Form App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF9F9F3),
      ),
      home: AddCompanyPage(),
    );
  }
}
