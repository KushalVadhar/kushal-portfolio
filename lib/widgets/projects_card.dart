import 'package:flutter/material.dart';
import 'common/glassmorphism_card.dart';

class ProjectsCard extends StatefulWidget {
  final int crossAxisCount;
  final bool showViewAll;

  const ProjectsCard({
    super.key,
    this.crossAxisCount = 3,
    this.showViewAll = true,
  });

  @override
  State<ProjectsCard> createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismCard(
      title: 'Projects',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProjectsGrid(),
          if (widget.showViewAll) ...[
            const SizedBox(height: 16),
            _buildViewAllButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectsGrid() {
    // Premium AI & Production Ready Projects based on Resume
    final projects = [
      ProjectItem(
        name: 'NeuroFlow AI',
        description:
            'Advanced Mental Stress Detection via Chatbot & Facial Analysis',
        icon: Icons.psychology,
        color: Colors.pink,
        gradient: [Colors.pink.shade400, Colors.purple.shade400],
      ),
      ProjectItem(
        name: 'Knorr Grocery',
        description:
            'Production App (10k+ Downloads) - Real-time Cart & Orders',
        icon: Icons.shopping_basket,
        color: Colors.green,
        gradient: [Colors.green.shade400, Colors.teal.shade400],
      ),
      ProjectItem(
        name: 'VisionStream',
        description:
            'Live Video Streaming with Real-Time AI Analysis (Agora SDK)',
        icon: Icons.videocam,
        color: Colors.orange,
        gradient: [Colors.orange.shade800, Colors.red.shade400],
      ),
      ProjectItem(
        name: 'Lokey Services',
        description:
            'Utility Services Platform - Production Ready Provider/API Arch',
        icon: Icons.home_repair_service,
        color: Colors.blue,
        gradient: [Colors.blue.shade600, Colors.cyan.shade400],
      ),
      ProjectItem(
        name: 'Smart Mirror AI',
        description:
            'IoT Mirror with Integrated News, Weather & Face Recog APIs',
        icon: Icons.smart_screen,
        color: Colors.indigo,
        gradient: [Colors.indigo.shade400, Colors.blue.shade900],
      ),
      ProjectItem(
        name: 'macOS Portfolio',
        description:
            'This Website! Advanced Flutter Web with Animations & Glassmorphism',
        icon: Icons.web, // Use a Generic Web Icon
        color: Colors.grey,
        gradient: [Colors.blueGrey.shade400, Colors.grey.shade600],
      ),
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            // Staggered Animation Logic
            final double start = index * 0.1;
            final double end = start + 0.4;
            final curve = CurvedAnimation(
              parent: _controller,
              curve: Interval(start.clamp(0.0, 1.0), end.clamp(0.0, 1.0),
                  curve: Curves.easeOutBack),
            );

            return Transform.scale(
              scale: curve.value,
              child: Opacity(
                opacity: curve.value,
                child: _ProjectTile(project: projects[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildViewAllButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 30.0), // Added generous bottom padding
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'View All Projects →',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectItem {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<Color> gradient;

  ProjectItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}

class _ProjectTile extends StatefulWidget {
  final ProjectItem project;

  const _ProjectTile({required this.project});

  @override
  State<_ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<_ProjectTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        // Restore Hover Scale
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.08 : 1.0)
          ..translate(0.0, _isHovered ? -5.0 : 0.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          // Restore Gradient
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.project.gradient[0].withOpacity(_isHovered ? 0.8 : 0.6),
              widget.project.gradient[1].withOpacity(_isHovered ? 0.7 : 0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(_isHovered ? 0.6 : 0.2),
            width: 1,
          ),
          // Restore Shadow
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.project.color.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // App Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.project.gradient,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                widget.project.icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            // Name
            Text(
              widget.project.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            // Description
            Text(
              widget.project.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 11,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            // View Button (Pill)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
