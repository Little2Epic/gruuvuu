import 'package:flutter/material.dart';
import 'package:gruuvuu/logic/models/action_model.dart';

enum ElementType {
  boxShape,
  text,
}

enum TextAlignment {
  left,
  center,
  right,
}

enum TextDecoration {
  bold,
  italic,
  underline,
}

class PropertyAttribute {
  final ElementType elementType; // Is Shape or Text
  final double? weight; // Font weight
  final Color color; // Color of attribute
  final double size; // Size in px
  final TextAlignment? alignment; // Text alignment
  final Set<TextDecoration> decorations; // Set for multiple decorations
  final double? radius; // Shape radius
  final int? startIndex; // Position to start modifying text
  final int? endIndex; // Position to end modifying text
  final bool isClickable; // Can be interacted with
  final ActionHandler? action; // Action to perform when clicked

  PropertyAttribute({
    required this.elementType,
    this.weight,
    required this.color,
    required this.size,
    this.alignment,
    Set<TextDecoration>? decorations,
    this.radius,
    this.startIndex,
    this.endIndex,
    this.isClickable = false,
    this.action,
  }) : decorations = decorations ?? {};
}
