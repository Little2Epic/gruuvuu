import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'gruuv_model.dart';

class Journal {
  final String id; // Unique identifier for the journal
  final String title; // Title of the journal
  final List<JournalEntry> entries; // List of journal entries
  final DateTime createdAt; // Timestamp for when the journal was created

  Journal({
    required this.id,
    required this.title,
    List<JournalEntry>? entries,
  })  : entries = entries ?? [],
        createdAt = DateTime.now(); // Automatically set to the current time
}

class JournalEntry {
  final String id; // Unique identifier for the entry
  final List<Media> media; // List of media associated with the entry
  final DateTime timestamp; // Timestamp for when the entry was created
  final Color backgroundColor; // Background color for the entry
  final String? backgroundPattern; // Image URI for the background pattern
  final String? title; // Optional title for the entry

  JournalEntry({
    required this.id,
    required this.media,
    required this.backgroundColor,
    this.backgroundPattern,
    this.title,
  }) : timestamp = DateTime.now(); // Automatically set to the current time
}

enum MediaType { textBox, gruuv, gruuvs, drawing, image }

class Media {
  final String id; // Unique identifier for the media
  final MediaType
      type; // Type of media (textbox, Gruuv, Gruuvs, drawing, image)
  final String? text; // Text content (if applicable)
  final String? imagePath; // Path or URL for an image (if applicable)
  final List<Uint8List>? drawing; // Drawing content (if applicable)
  final Gruuv? gruuv; // Reference to a single Gruuv (if applicable)
  final Gruuvu? gruuvs; // Reference to a collection of Gruuvs (if applicable)
  final Color? backgroundColor; // Background color for the media
  final String? backgroundPattern; // Image URI for the background pattern

  Media({
    required this.id,
    required this.type,
    this.text,
    this.imagePath,
    this.drawing,
    this.gruuv,
    this.gruuvs,
    this.backgroundColor,
    this.backgroundPattern,
  });
}
