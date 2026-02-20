import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/constants/app_constants.dart';

class TerminalApp extends StatefulWidget {
  const TerminalApp({super.key});

  @override
  State<TerminalApp> createState() => _TerminalAppState();
}

class _TerminalAppState extends State<TerminalApp> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<TerminalLine> _lines = [];

  @override
  void initState() {
    super.initState();
    _lines.add(TerminalLine(
      text:
          "Last login: ${DateTime.now().toString().substring(0, 19)} on ttys000",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "Welcome to Kushal's Terminal! Type 'help' to start your exploration.",
      color: Colors.white,
    ));

    // Auto-focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _executeCommand(String input) {
    if (input.trim().isEmpty) return;

    final command = input.trim().toLowerCase();

    setState(() {
      // Add command line
      _lines.add(TerminalLine(
        text: "${_getPrompt()} $input",
        color: Colors.white,
        isCommand: true,
      ));

      // Process command
      try {
        switch (command) {
          case 'help':
            _printHelp();
            break;
          case 'clear':
          case 'cls':
            _lines.clear();
            break;
          case 'skills':
            _printSkills();
            break;
          case 'journey':
            _printJourney();
            break;
          case 'aim':
            _printAim();
            break;
          case 'future':
            _printFuture();
            break;
          case 'whoami':
            _lines.add(TerminalLine(
                text: "Kushal Vadhar - The Architect",
                color: Colors.greenAccent));
            break;
          case 'date':
            _lines.add(TerminalLine(
              text: DateTime.now().toString(),
              color: Colors.white,
            ));
            break;
          case 'ai':
            _printAI();
            break;
          case 'exit':
            _lines.add(TerminalLine(
                text: "Terminal session ended. Have a great day!",
                color: Colors.white));
            break;
          default:
            _printError(
                "command not found: $command. Try 'help' for available story paths.");
        }
      } catch (e) {
        _printError("Error executing command: $e");
      }
    });

    _controller.clear();
    _scrollToBottom();
  }

  /// Helper Commands

  void _printHelp() {
    _lines.add(TerminalLine(
        text: "Discover Kushal's story through these commands:",
        color: Colors.yellow));
    _lines.add(TerminalLine(
        text: "  skills   Technical expertise & philosophy",
        color: Colors.white));
    _lines.add(TerminalLine(
        text: "  journey  Carrier milestones since May 2024",
        color: Colors.white));
    _lines.add(TerminalLine(
        text: "  aim      Professional mission and goals",
        color: Colors.white));
    _lines.add(TerminalLine(
        text: "  future   Upcoming innovations & AI roadmap",
        color: Colors.white));
    _lines.add(TerminalLine(
        text: "  ai       My daily AI integration habits",
        color: Colors.cyanAccent));
    _lines.add(TerminalLine(
        text: "  clear    Reset terminal screen", color: Colors.white));
    _lines.add(TerminalLine(
        text: "  whoami   Reveal the identity", color: Colors.white));
  }

  void _printSkills() {
    _lines.add(TerminalLine(
      text: "--- TECHNICAL CORE & CONSTANT UPGRADING ---",
      color: Colors.cyanAccent,
    ));
    _lines.add(TerminalLine(
      text: "• Architecture: ${AppConstants.mySkills}",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "• Performance: Optimizing UI rendering and complex state management using Provider.",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "• Mindset: I consider myself a lifelong student, constantly upgrading my skill stack with the latest industry shifts and AI-driven methodologies.",
      color: Colors.greenAccent,
    ));
  }

  void _printJourney() {
    _lines.add(
        TerminalLine(text: "--- THE JOURNEY ---", color: Colors.orangeAccent));
    _lines.add(TerminalLine(
      text: "• May 2024 mark: ${AppConstants.myJourney}",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "• Impact: Averaging weekly skill expansions into backend optimization and AI-assisted workflows.",
      color: Colors.white,
    ));
  }

  void _printAim() {
    _lines.add(TerminalLine(
        text: "--- PROFESSIONAL AIM ---", color: Colors.purpleAccent));
    _lines.add(TerminalLine(
      text: AppConstants.myAim,
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "I target the intersection of bridge-edge engineering and user-centric design.",
      color: Colors.white,
    ));
  }

  void _printFuture() {
    _lines.add(TerminalLine(
        text: "--- LOOKING FORWARD ---", color: Colors.blueAccent));
    _lines.add(TerminalLine(
      text: AppConstants.myFuture,
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "Vision: Leading teams to build the next generation of intuitive, AI-powered software.",
      color: Colors.white,
    ));
  }

  void _printAI() {
    _lines.add(TerminalLine(
        text: "--- AI INTEGRATION HABITS ---", color: Colors.cyanAccent));
    _lines.add(TerminalLine(
      text:
          "Integrating AI into my daily life using specialized tools for peak efficiency:",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "• Development: Cursor AI & LLMs for rapid prototyping, architecture design, and unit testing.",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "• Problem Solving: Using AI agents to summarize complex research and explore new API patterns.",
      color: Colors.white,
    ));
    _lines.add(TerminalLine(
      text:
          "• Daily Live: Leveraging different AI tools to automate repetitive tasks and focus on high-value creative engineering.",
      color: Colors.greenAccent,
    ));
    _lines.add(TerminalLine(
      text:
          "Status: Constantly upgrading my AI interaction models (Prompt Engineering, Agentic Workflows).",
      color: Colors.white70,
    ));
  }

  void _printError(String message) {
    _lines.add(TerminalLine(text: message, color: Colors.redAccent));
  }

  String _getPrompt() {
    return "guest@portfolio ~ %";
  }

  void _scrollToBottom() {
    Timer(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E), // Terminal Background
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _focusNode.requestFocus(),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: _lines.length,
                itemBuilder: (context, index) {
                  final line = _lines[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      line.text,
                      style: TextStyle(
                        fontFamily: 'Courier', // Monospace font
                        fontSize: 14,
                        color: line.color,
                        fontWeight: line.isCommand
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Input Line
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white12)),
            ),
            child: Row(
              children: [
                Text(
                  "${_getPrompt()} ",
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    cursorColor: Colors.grey,
                    cursorWidth: 8, // Block cursor style
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    onSubmitted: _executeCommand,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TerminalLine {
  final String text;
  final Color color;
  final bool isCommand;

  TerminalLine(
      {required this.text, required this.color, this.isCommand = false});
}
