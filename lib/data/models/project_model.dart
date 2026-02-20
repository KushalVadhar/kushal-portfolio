/// Model class for Project data
class ProjectModel {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final List<String> techStack;
  final String architecture;
  final List<String> keyFeatures;
  final String? challenge;
  final String? solution;
  final String? result;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? caseStudyUrl;
  final String? imageAsset;
  final String category; // e.g., "Mobile App", "Web App", "Desktop"
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.techStack,
    required this.architecture,
    required this.keyFeatures,
    this.challenge,
    this.solution,
    this.result,
    this.githubUrl,
    this.liveDemoUrl,
    this.caseStudyUrl,
    this.imageAsset,
    this.category = 'Mobile App',
    this.isFeatured = false,
  });

  /// Create a copy with modified fields
  ProjectModel copyWith({
    String? id,
    String? title,
    String? shortDescription,
    String? fullDescription,
    List<String>? techStack,
    String? architecture,
    List<String>? keyFeatures,
    String? challenge,
    String? solution,
    String? result,
    String? githubUrl,
    String? liveDemoUrl,
    String? caseStudyUrl,
    String? imageAsset,
    String? category,
    bool? isFeatured,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      techStack: techStack ?? this.techStack,
      architecture: architecture ?? this.architecture,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      challenge: challenge ?? this.challenge,
      solution: solution ?? this.solution,
      result: result ?? this.result,
      githubUrl: githubUrl ?? this.githubUrl,
      liveDemoUrl: liveDemoUrl ?? this.liveDemoUrl,
      caseStudyUrl: caseStudyUrl ?? this.caseStudyUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      category: category ?? this.category,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
