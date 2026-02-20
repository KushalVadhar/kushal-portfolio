/// Model class for Education data
class EducationModel {
  final String id;
  final String institution;
  final String degree;
  final String field;
  final String startYear;
  final String endYear;
  final String? grade;
  final String? description;
  final List<String>? achievements;

  const EducationModel({
    required this.id,
    required this.institution,
    required this.degree,
    required this.field,
    required this.startYear,
    required this.endYear,
    this.grade,
    this.description,
    this.achievements,
  });

  /// Get formatted duration (e.g., "2019 - 2023")
  String get duration => '$startYear - $endYear';

  /// Create a copy with modified fields
  EducationModel copyWith({
    String? id,
    String? institution,
    String? degree,
    String? field,
    String? startYear,
    String? endYear,
    String? grade,
    String? description,
    List<String>? achievements,
  }) {
    return EducationModel(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      field: field ?? this.field,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      grade: grade ?? this.grade,
      description: description ?? this.description,
      achievements: achievements ?? this.achievements,
    );
  }
}
