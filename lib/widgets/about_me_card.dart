import 'package:flutter/material.dart';
import 'common/glassmorphism_card.dart';

class AboutMeCard extends StatelessWidget {
  final bool isCompact;

  const AboutMeCard({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return GlassmorphismCard(
      title: 'About Me',
      child: isCompact ? _buildCompactLayout() : _buildFullLayout(),
    );
  }

  Widget _buildFullLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Avatar
            const _ProfileAvatar(),
            const SizedBox(width: 24),
            // Name and Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kushal Vadhar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Mobile App Developer | Flutter Specialist',
                      style: TextStyle(
                        color: Colors.blue.shade300,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded,
                          color: Colors.white38, size: 14),
                      const SizedBox(width: 4),
                      const Text(
                        'Vadodara, India',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Bio
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Text(
            'Passionate Flutter Engineer since May 2024, specialized in building scalable mobile architectures and AI-integrated workflows. I focus on high-performance UI and seamless digital experiences.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Timeline Section
        Row(
          children: [
            const Icon(Icons.work_history_rounded,
                color: Colors.white54, size: 18),
            const SizedBox(width: 8),
            Text(
              "EXPERIENCE",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildExperienceTimeline(),

        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.school_rounded, color: Colors.white54, size: 18),
            const SizedBox(width: 8),
            Text(
              "EDUCATION",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildEducationRow(
            "Charusat University", "B.Tech Computer Science (GPA 8.7)", "2023"),
        const SizedBox(height: 12),
        _buildEducationRow(
            "Sigma Institute", "Diploma Computer Eng (GPA 8.3)", "2020"),
      ],
    );
  }

  Widget _buildExperienceTimeline() {
    return Column(
      children: [
        _buildTimeLineItem(
          company: "Mindsclik",
          role: "Flutter Developer",
          duration: "May 2024 - Present",
          description:
              "Developing production-grade industrial and consumer apps.",
          isCurrent: true,
          isLast: false,
        ),
        _buildTimeLineItem(
          company: "Freelancing",
          role: "Flutter Developer",
          duration: "2023 - 2024",
          description: "Built custom mobile solutions for global clients.",
          isCurrent: false,
          isLast: false,
        ),
        _buildTimeLineItem(
          company: "Kintu Design",
          role: "Software Intern",
          duration: "2022 - 2023",
          description: "AI Chatbot & Video Stress Detection models.",
          isCurrent: false,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimeLineItem({
    required String company,
    required String role,
    required String duration,
    required String description,
    required bool isCurrent,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isCurrent ? Colors.blueAccent : Colors.white24,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCurrent
                        ? Colors.blueAccent.withOpacity(0.3)
                        : Colors.transparent,
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.white10,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(role,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      Text(duration,
                          style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(company,
                      style: TextStyle(
                          color: Colors.blue.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(description,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.4)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationRow(String school, String degree, String year) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(school,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600))),
        Expanded(
            child: Text(degree,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 13))),
        Text(year,
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade400,
                    Colors.blue.shade400,
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  'KV',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kushal Vadhar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Flutter Specialist',
                    style: TextStyle(
                      color: Colors.blue.shade300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Building next-gen mobile apps at Mindsclik. Experience with AI, IoT and Production Flutter Apps.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatefulWidget {
  const _ProfileAvatar();

  @override
  State<_ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<_ProfileAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        width: 80,
        height: 80,
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.15 : 1.0)
          ..rotateZ(_isHovered ? 0.05 : 0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: _isHovered ? Alignment.topRight : Alignment.topLeft,
            end: _isHovered ? Alignment.bottomLeft : Alignment.bottomRight,
            colors: [
              Colors.purple.shade400,
              Colors.blue.shade400,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(_isHovered ? 0.6 : 0.3),
              blurRadius: _isHovered ? 30 : 20,
              spreadRadius: _isHovered ? 4 : 2,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'KV',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
