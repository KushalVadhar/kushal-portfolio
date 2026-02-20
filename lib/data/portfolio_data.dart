import 'models/project_model.dart';
import 'models/experience_model.dart';
import 'models/education_model.dart';

/// Repository for portfolio data
/// Populated from Resume: Kushal Vadhar
class PortfolioData {
  PortfolioData._(); // Private constructor

  // ========== PROJECTS DATA ==========

  static final List<ProjectModel> projects = [
    ProjectModel(
      id: 'proj_lingua',
      title: 'LinguaVision AI',
      shortDescription: 'Advanced AI language learning with Vision & LLMs',
      fullDescription:
          'Engineered a cutting-edge AI language learning platform utilizing Gemini Pro Vision for real-time object reasoning and OpenAI Whisper for near-perfect pronunciation analysis. Implemented a RAG (Retrieval-Augmented Generation) pipeline to fetch contextual usage examples from a high-performance Vector Database (Pinecone). Features advanced image labeling via ML Kit and personalized learning paths optimized for retention using semantic similarity.',
      techStack: [
        'Flutter',
        'Gemini AI',
        'ML Kit',
        'OpenAI Whisper',
        'Pinecone'
      ],
      architecture: 'Clean Architecture + RAG',
      keyFeatures: [
        'Real-time scene reasoning with Gemini Pro Vision',
        'Semantic vocabulary retrieval using Pinecone Vector DB',
        'Voice analysis & feedback via OpenAI Whisper',
        'Contextual RAG-driven learning modules',
        'On-device ML Kit image labeling for low latency',
      ],
      challenge:
          'Integrating real-time object detection with seamless UI updates for learning context.',
      solution:
          'Optimized ML Kit image labeling streams and cached results for smooth user experience.',
      result:
          'Enhanced user engagement through interactive, real-world learning.',
      githubUrl: 'https://github.com/KushalVadhar/LinguaVision-AI-',
      liveDemoUrl: null,
      caseStudyUrl: null,
      imageAsset:
          'https://images.unsplash.com/photo-1555099962-4199c345e5dd?auto=format&fit=crop&w=800&q=80',
      category: 'AI Mobile App',
      isFeatured: true,
    ),
    ProjectModel(
      id: 'proj_knorr',
      title: 'Knorr-Bremse Industrial App',
      shortDescription: 'Enterprise-level industrial application',
      fullDescription:
          'Contributed to an enterprise-level Flutter application used internally by industrial teams across multiple locations. Developed dashboards, inspection workflows, dynamic forms, and operational modules based on real-world industrial processes. Collaborated with senior developers to implement secure API communication and maintain scalable application architecture.',
      techStack: ['Flutter', 'Provider', 'REST APIs', 'Firebase'],
      architecture: 'Scalable Modular Architecture',
      keyFeatures: [
        'Dynamic forms for inspection workflows',
        'Real-time operational dashboards',
        'Secure API communication',
        'Offline-capable data entry',
        'Role-based access control',
      ],
      challenge:
          'Digitizing complex industrial inspection workflows into a mobile-friendly interface.',
      solution:
          'Implemented a dynamic form engine that renders UI based on JSON configurations from the backend.',
      result:
          'Streamlined operational processes across multiple industrial locations.',
      githubUrl: null,
      liveDemoUrl: null,
      caseStudyUrl: null,
      imageAsset:
          'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=80',
      category: 'Enterprise App',
      isFeatured: true,
    ),
    ProjectModel(
      id: 'proj_streaming',
      title: 'Live Video Streaming App',
      shortDescription: 'Real-time broadcasting with Agora SDK',
      fullDescription:
          'Developed a real-time video streaming application enabling low-latency audio and video communication. Integrated Agora SDK for live broadcasting, channel management, and real-time user synchronization. Implemented Firebase authentication, cloud storage, and user session handling for secure access control.',
      techStack: ['Flutter', 'Agora SDK', 'Firebase', 'Dart'],
      architecture: 'MVVM',
      keyFeatures: [
        'Low-latency audio/video streaming',
        'Live broadcasting & Channel management',
        'Real-time user synchronization',
        'Firebase Authentication & Secure Session Handling',
        'Interactive audience features',
      ],
      challenge:
          'Ensuring low latency and stable connections for live streams.',
      solution:
          'Optimized Agora SDK configuration and implemented robust connection state handling.',
      result: 'Seamless live streaming experience effectively used by users.',
      githubUrl: 'https://github.com/KushalVadhar/Video-Streaming-App',
      liveDemoUrl: null,
      caseStudyUrl: null,
      imageAsset:
          'https://images.unsplash.com/photo-1611162617474-5b21e879e113?auto=format&fit=crop&w=800&q=80',
      category: 'Mobile App',
      isFeatured: true,
    ),
    ProjectModel(
      id: 'proj_portfolio',
      title: 'MacOS Portfolio',
      shortDescription: 'Responsive portfolio with macOS aesthetics',
      fullDescription:
          'A personal portfolio website designed to mimic the look and feel of macOS. Features include glassmorphism effects, a functional dock, responsive layout, and smooth animations.',
      techStack: [
        'Flutter Web',
        'Provider',
        'CanvasKit',
        'Responsive Framework'
      ],
      architecture: 'Clean Architecture',
      keyFeatures: [
        'MacOS-inspired UI with Glassmorphism',
        'Fully responsive (Mobile, Tablet, Desktop)',
        'Custom Dock with magnification effect',
        'Draggable windows and multitasking',
        'Optimized for Web performance',
      ],
      challenge:
          'Replicating the complex blur and transparency effects of macOS on the web while maintaining performance.',
      solution:
          'utilized Flutter\'s BackdropFilter and custom shaders to create performant glass effects.',
      result:
          'A unique, engaging user experience that stands out from typical portfolios.',
      githubUrl: 'https://github.com/KushalVadhar/macos_portfolio',
      liveDemoUrl: '#',
      caseStudyUrl: null,
      imageAsset:
          'https://images.unsplash.com/photo-1629654297299-c8506221ca97?auto=format&fit=crop&w=800&q=80',
      category: 'Web App',
      isFeatured: true,
    ),
    ProjectModel(
      id: 'proj_backend',
      title: 'Node.js Backend System',
      shortDescription: 'Scalable REST API (In Progress)',
      fullDescription:
          'Currently building a robust backend system using Node.js and Express. Features will include JWT authentication, MongoDB integration for data persistence, and real-time socket communication. Targeted for completion by end of week.',
      techStack: ['Node.js', 'Express', 'MongoDB', 'JavaScript'],
      architecture: 'MVC',
      keyFeatures: [
        'RESTful API Design',
        'JWT Authentication & Security',
        'MongoDB Database Integration',
        'Async/Await Error Handling',
        'Currently in Active Development',
      ],
      challenge:
          'Transitioning from mobile-first to full-stack development patterns.',
      solution:
          'Applying clean architecture principles from Flutter to backend structure.',
      result: ' broadening technical horizon into backend engineering.',
      githubUrl: 'https://github.com/KushalVadhar',
      liveDemoUrl: null,
      caseStudyUrl: null,
      imageAsset:
          'https://images.unsplash.com/photo-1627398242454-45a1465c2479?auto=format&fit=crop&w=800&q=80',
      category: 'Backend',
      isFeatured: true,
    ),
  ];

  // ========== EXPERIENCE DATA ==========

  static final List<ExperienceModel> experiences = [
    ExperienceModel(
      id: 'exp_mindsclik',
      company: 'Mindsclik',
      role: 'Flutter Developer',
      duration: 'May 2024 - Present',
      startDate: 'May 2024',
      endDate: null,
      isCurrent: true,
      description:
          'Developing production-grade Flutter applications for 10,000+ active users.',
      achievements: [
        'Ensured high performance and smooth UI interactions for large user base',
        'Implemented structured state management using Provider',
        'Optimized app startup time and reduced UI rendering issues',
        'Integrated RESTful APIs and secure data flow',
      ],
      technologiesUsed: ['Flutter', 'Provider', 'REST APIs', 'Android'],
      companyLogo: null,
      companyUrl: 'https://mindsclik.com',
    ),
    const ExperienceModel(
      id: 'exp_freelance',
      company: 'Freelance',
      role: 'Flutter Developer',
      duration: 'July 2023 - April 2024',
      startDate: 'July 2023',
      endDate: 'April 2024',
      isCurrent: false,
      description:
          'Built complete mobile applications for service-based and utility-based clients.',
      achievements: [
        'Followed clean architecture and modular project structure',
        'Integrated Firebase Auth, Firestore, and Push Notifications',
        'Real-time data synchronization with third-party APIs',
        'Delivered production-ready Android applications iteratively',
      ],
      technologiesUsed: [
        'Flutter',
        'Firebase',
        'Clean Architecture',
        'API Integration'
      ],
      companyLogo: null,
      companyUrl: null,
    ),
    const ExperienceModel(
      id: 'exp_kintu',
      company: 'Kintu Designs',
      role: 'Intern - AI & Python',
      duration: 'Dec 2022 - Jun 2023',
      startDate: 'Dec 2022',
      endDate: 'Jun 2023',
      isCurrent: false,
      description:
          'Developed AI-powered solutions including chatbots and behavioral analysis models.',
      achievements: [
        'Built AI chatbot using Dialogflow for stress-related pattern analysis',
        'Implemented facial expression models using Python & OpenCV',
        'Performed model testing and tuning using Google Colab',
        'Improved model accuracy through dataset experimentation',
      ],
      technologiesUsed: ['Python', 'Dialogflow', 'OpenCV', 'Machine Learning'],
      companyLogo: null,
      companyUrl: null,
    ),
  ];

  // ========== EDUCATION DATA ==========

  static final List<EducationModel> education = [
    EducationModel(
      id: 'edu_charusat',
      institution: 'Charusat University',
      degree: 'Bachelor of Technology',
      field: 'Computer Science and Technology',
      startYear: '2019', // Inferring start based on 2023 grad
      endYear: '2023',
      grade: '8.7 GPA',
      description: 'specialized in Computer Science & Technology.',
      achievements: [],
    ),
    const EducationModel(
      id: 'edu_sigma',
      institution: 'Sigma Institute of Technology',
      degree: 'Diploma',
      field: 'Computer Engineering',
      startYear: '2017', // Inferring
      endYear: '2020',
      grade: '8.3 GPA',
      description: 'Foundation in Computer Engineering.',
      achievements: [],
    ),
  ];

  // ========== GET FEATURES ==========

  static List<ProjectModel> get featuredProjects {
    return projects.where((project) => project.isFeatured).toList();
  }

  static ExperienceModel? get currentJob {
    try {
      return experiences.firstWhere((exp) => exp.isCurrent);
    } catch (e) {
      return null;
    }
  }
}
