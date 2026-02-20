import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'common/glassmorphism_card.dart';

class SkillsCard extends StatelessWidget {
  final bool isCompact;
  final int crossAxisCount;

  const SkillsCard({
    super.key,
    this.isCompact = false,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphismCard(
      title: 'Skills',
      child: _buildSkillsGrid(),
    );
  }

  Widget _buildSkillsGrid() {
    // Official SVG Strings for Brand Identity
    const String flutterSvg =
        '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 166 202"><path fill="#027DFD" d="M37.9 16.7L82 61.3l-28 28.3L9.6 44.8z"/><path fill="#29B6F6" d="M110.1 89.8L154.5 45H98l-44 44.8z"/><path fill="#01579B" d="M98 157h56.5l-44.4-44.8-28.7 28.9z"/><path fill="#29B6F6" d="M53.9 89.8l28.7 28.9L127 163.5l27.5-27.7 11.1-11.2L110.1 89.8z"/></svg>''';

    const String firebaseSvg =
        '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 436"><path fill="#FFC107" d="M55.8 333.3l-26.6-83.3L107.5 14.1c1.6-4.9-5-7.9-7.9-3.6L55.8 333.3z"/><path fill="#FFA000" d="M172.9 292.8l27.1-168.1c.8-5.3-6-8.2-9.6-4.1l-60.7 68.6-28.4 86.6 71.6 17z"/><path fill="#FFCA28" d="M55.8 333.3l71.6 13.5 125.7-126-72.2-127.3c-2.4-4.2-8.5-4-10.8.2L55.8 333.3z"/><path fill="#F57F17" d="M55.8 333.3h0L160 435.6l104.2-102.3 27-168.1h0L55.8 333.3z"/></svg>''';

    // Using Color(0xFF...) format for stability
    final skills = [
      SkillItem(
        name: 'Flutter',
        svgContent: flutterSvg,
        color: const Color(0xFF54C5F8),
      ),
      SkillItem(
        name: 'Dart',
        icon: FontAwesomeIcons.bullseye,
        color: const Color(0xFF0175C2),
      ),
      SkillItem(
        name: 'Firebase',
        svgContent: firebaseSvg,
        color: const Color(0xFFFFCA28),
      ),
      SkillItem(
        name: 'Python',
        icon: FontAwesomeIcons.python,
        color: const Color(0xFF3776AB),
      ),
      SkillItem(
        name: 'C/C++',
        icon: FontAwesomeIcons.c,
        color: const Color(0xFF00599C),
      ),
      SkillItem(
        name: 'Java',
        icon: FontAwesomeIcons.java,
        color: const Color(0xFF007396),
      ),
      SkillItem(
        name: 'HTML',
        icon: FontAwesomeIcons.html5,
        color: const Color(0xFFE34F26),
      ),
      SkillItem(
        name: 'CSS',
        icon: FontAwesomeIcons.css3Alt,
        color: const Color(0xFF1572B6),
      ),
      SkillItem(
        name: 'Node.js',
        icon: FontAwesomeIcons.nodeJs,
        color: const Color(0xFF339933),
      ),
      SkillItem(
        name: 'Agora SDK',
        icon: FontAwesomeIcons.video,
        color: const Color(0xFF099DFD),
      ),
      SkillItem(
        name: 'ML Kit',
        icon: FontAwesomeIcons.brain,
        color: const Color(0xFF4285F4),
      ),
      SkillItem(
        name: 'Dialogflow',
        icon: FontAwesomeIcons.robot,
        color: const Color(0xFFFF9800),
      ),
      SkillItem(
        name: 'Git',
        icon: FontAwesomeIcons.gitAlt,
        color: const Color(0xFFF05133),
      ),
      SkillItem(
        name: 'Postman',
        icon: FontAwesomeIcons.paperPlane,
        color: const Color(0xFFFF6C37),
      ),
      SkillItem(
        name: 'Figma',
        icon: FontAwesomeIcons.figma,
        color: const Color(0xFFF24E1E),
      ),
      SkillItem(
        name: 'Antigravity',
        icon: FontAwesomeIcons.atom,
        color: const Color(0xFF9C27B0),
      ),
      SkillItem(
        name: 'Cursor AI',
        icon: FontAwesomeIcons.laptopCode,
        color: const Color(0xFF333333),
      ),
      SkillItem(
        name: 'GitHub Copilot',
        icon: FontAwesomeIcons.robot,
        color: const Color(0xFF651FFF),
      ),
    ];

    return Wrap(
      spacing: isCompact ? 12 : 24,
      runSpacing: isCompact ? 12 : 24,
      alignment: WrapAlignment.center,
      children: skills
          .map((skill) => _SkillTile(skill: skill, isCompact: isCompact))
          .toList(),
    );
  }
}

class SkillItem {
  final String name;
  final String? svgContent;
  final IconData? icon;
  final Color color;

  SkillItem({
    required this.name,
    this.svgContent,
    this.icon,
    required this.color,
  });
}

class _SkillTile extends StatefulWidget {
  final SkillItem skill;
  final bool isCompact;

  const _SkillTile({required this.skill, this.isCompact = false});

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.isCompact ? 70.0 : 90.0;
    final iconSize = widget.isCompact ? 40.0 : 50.0;
    final fontSize = widget.isCompact ? 11.0 : 12.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        constraints: BoxConstraints(minHeight: size),
        transform: Matrix4.identity()..scale(_isHovered ? 1.15 : 1.0),
        transformAlignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: widget.skill.svgContent != null
                  ? SvgPicture.string(
                      widget.skill.svgContent!,
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.contain,
                    )
                  : Icon(
                      widget.skill.icon,
                      size: iconSize,
                      color: widget.skill.color,
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.skill.name,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
