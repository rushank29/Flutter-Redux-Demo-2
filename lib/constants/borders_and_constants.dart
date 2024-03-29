import 'package:flutter/material.dart';

InputBorder kNonFocusBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: const BorderSide(width: 0.5, color: Colors.black87),
);

InputBorder kFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: const BorderSide(width: 1, color: Colors.black87),
);

InputBorder kErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: BorderSide(width: 1, color: Colors.red[300]!),
);
