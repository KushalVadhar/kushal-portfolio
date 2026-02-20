/// Model class for Work Experience data
class ExperienceModel {
  final String id;
  final String company;
  final String role;
  final String duration;
  final String startDate; // e.g., "Jan 2023"
  final String? endDate; // null if currently working
  final bool isCurrent;
  final String description;
  final List<String> achievements;
  final List<String> technologiesUsed;
  final String? companyLogo;
  final String? companyUrl;

  const ExperienceModel({
    required this.id,
    required this.company,
    required this.role,
    required this.duration,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    required this.description,
    required this.achievements,
    required this.technologiesUsed,
    this.companyLogo,
    this.companyUrl,
  });

  /// Create a copy with modified fields
  ExperienceModel copyWith({
    String? id,
    String? company,
    String? role,
    String? duration,
    String? startDate,
    String? endDate,
    bool? isCurrent,
    String? description,
    List<String>? achievements,
    List<String>? technologiesUsed,
    String? companyLogo,
    String? companyUrl,
  }) {
    return ExperienceModel(
      id: id ?? this.id,
      company: company ?? this.company,
      role: role ?? this.role,
      duration: duration ?? this.duration,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      description: description ?? this.description,
      achievements: achievements ?? this.achievements,
      technologiesUsed: technologiesUsed ?? this.technologiesUsed,
      companyLogo: companyLogo ?? this.companyLogo,
      companyUrl: companyUrl ?? this.companyUrl,
    );
  }
}
