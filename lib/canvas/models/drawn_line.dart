import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Wrapper class for chronologically ordered list of points that have been touched by user.
class DrawnLine extends Equatable {
  final List<Offset> path;

  const DrawnLine({
    required this.path,
  });

  @override
  List<Object?> get props => [path];
}