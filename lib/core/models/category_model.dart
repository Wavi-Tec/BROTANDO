import 'package:flutter/material.dart';

class QuizCategory {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int totalQuestions;
  final Color color;

  QuizCategory({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.totalQuestions,
    required this.color,
  });
}