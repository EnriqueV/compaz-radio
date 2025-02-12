import 'package:flutter/material.dart';

class RadioListModel {
  final String title;
  final String subTitle;
  final String image;
  final VoidCallback? onTap;
  final int id;

  RadioListModel( {
    required this.title,
    required this.subTitle,
    required this.image,
    this.onTap,
    required this.id,
  });
}



