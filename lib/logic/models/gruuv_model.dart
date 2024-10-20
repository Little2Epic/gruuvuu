import 'package:flutter/material.dart';
import 'package:gruuvuu/logic/models/action_model.dart';
import 'package:gruuvuu/logic/models/element_attributes_model.dart';

class Gallery {
  final String id; // Unique identifier for the gallery
  late List<Gruuvu> savedGruuvus; // List of saved Gruuvs
  final DateTime createdAt; // Timestamp for when the gallery was created

  Gallery({
    required this.id,
    List<Gruuvu>? savedGruuvs,
  }) : createdAt = DateTime.now() // Automatically set to current time
  {
    savedGruuvus = savedGruuvus.isEmpty ? [] : savedGruuvus;
  }

  // Method to add a Gruuv to the gallery
  void addGruuvu(Gruuvu gruuvu) {
    savedGruuvus.add(gruuvu);
  }

  // Method to remove a Gruuvu from the gallery
  void removeGruuvu(Gruuvu gruuvu) {
    savedGruuvus.remove(gruuvu);
  }

  // Method to get Gruuvus sorted by creation time
  List<Gruuvu> getSortedGruuvus() {
    savedGruuvus.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return savedGruuvus;
  }
}

class Gruuvu {
  final int id; // Unique identifier for the Gruuvus
  final List<Gruuv> gruuvGroup; // Collection of Gruuv objects
  final String? title; // Title of the Gruuvus
  final String? description; // Description of the Gruuvus
  final int timestamp; // Timestamp for the Gruuvus

  Gruuvu({
    required this.id,
    List<Gruuv>? gruuvGroup,
    this.title,
    this.description,
    required this.timestamp,
  }) : gruuvGroup = gruuvGroup ?? []; // Initialize to an empty list if null
}

class Gruuv extends ShapeDecoration {
  final int id; // Unique identifier for the Gruuv
  final int parentID; // ID of the parent Gruuvu
  final Text body; // Text content of the Gruuv
  static const ShapeBorder defShape = CircleBorder();
  final List<PropertyAttribute>
      attributes; // List of attributes for both body and Gruuv
  final ActionHandler action; // Action associated with the Gruuv

  Gruuv({
    required this.id,
    required this.parentID,
    required this.body,
    List<PropertyAttribute>? attributes,
    required this.action,
    super.shape = defShape,
  }) : attributes = attributes ?? []; // Initialize to empty list if null
}
