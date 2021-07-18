import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangController extends GetxController {
  var elang = 'eng'.obs;
  var klang = 'kor'.obs;
  var jlang = 'jar'.obs;

  langSet() {
    update();
  }
}
