// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// // ⚠️ FIX: Use 'ai' as a prefix to avoid conflict with 'flutter_gemini'
// import 'package:google_generative_ai/google_generative_ai.dart' as ai;

// // --- Data Model ---
// // A simple data class for our chat messages
// class ChatMessage {
//   final String text;
//   final bool isUser;

//   ChatMessage({required this.text, required this.isUser});
// }

// // --- State Management ---
// class SimpleChatScreen extends StatefulWidget {
//   const SimpleChatScreen({super.key});

//   @override
//   State<SimpleChatScreen> createState() => _SimpleChatScreenState();
// }

// class _SimpleChatScreenState extends State<SimpleChatScreen> {
//   final _textController = TextEditingController();
//   final List<ChatMessage> _messages = [];
//   final ScrollController _scrollController =
//       ScrollController(); // For auto-scroll
//   bool _isLoading = false;

//   // We need both the GenerativeModel to set the system instruction
//   // and the ChatSession to maintain history.
//   late final ai.GenerativeModel _model;
//   late final ai.ChatSession _chat;

//   @override
//   void initState() {
//     super.initState();
//     final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
//     // 1. INITIALIZE THE MODEL WITH SYSTEM INSTRUCTIONS
//     _model = ai.GenerativeModel(
//       model: 'gemini-2.5-flash',
//       // Get the API key passed in via main.dart
//       apiKey: apiKey,

//       systemInstruction: ai.Content.system(
//           "You are a helpful and polite medical assistant for a doctor booking app. "
//           "Your primary role is to answer user questions related to health, medicine, doctors, symptoms, and appointments. "
//           "Always give advice that is general and safe, and never act as a substitute for a real doctor. "
//           "Politely decline to answer any questions that are not related to these medical or health topics. "
//           "Do not answer non-medical questions like history, movies, or politics."),
//     );

//     // 2. START THE CHAT SESSION (This is what enables history/memory)
//     _chat = _model.startChat();
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('🩺 AI Medical Assistant'),
//         backgroundColor: Colors.blueAccent,
//         foregroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           // This will display the chat messages
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController, // Attach controller
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return _buildMessageBubble(message);
//               },
//             ),
//           ),

//           // Loading indicator
//           if (_isLoading)
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: LinearProgressIndicator(),
//             ),

//           // The input area
//           _buildChatInput(),
//         ],
//       ),
//     );
//   }

//   // --- UI Builder Methods ---

//   Widget _buildMessageBubble(ChatMessage message) {
//     return Align(
//       alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         constraints:
//             BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         decoration: BoxDecoration(
//           color: message.isUser ? Colors.blueAccent : Colors.grey[200],
//           borderRadius: BorderRadius.circular(15).copyWith(
//             topLeft: message.isUser
//                 ? const Radius.circular(15)
//                 : const Radius.circular(0),
//             topRight: message.isUser
//                 ? const Radius.circular(0)
//                 : const Radius.circular(15),
//           ),
//         ),
//         child: Text(
//           message.text,
//           style: TextStyle(
//             color: message.isUser ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChatInput() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 hintText: 'Ask a health question...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               ),
//               enabled: !_isLoading, // Disable input while loading
//               onSubmitted: (value) => _sendMessage(),
//             ),
//           ),
//           const SizedBox(width: 8),
//           // The send button
//           FloatingActionButton(
//             mini: true,
//             backgroundColor: Colors.blueAccent,
//             foregroundColor: Colors.white,
//             onPressed: _isLoading ? null : _sendMessage,
//             child: const Icon(Icons.send),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Core Logic ---

//   void _sendMessage() async {
//     if (_textController.text.isEmpty || _isLoading) return;

//     final userMessageText = _textController.text;
//     _textController.clear();

//     // 3. Add user message and set loading
//     setState(() {
//       _messages.add(ChatMessage(text: userMessageText, isUser: true));
//       _isLoading = true;
//     });

//     try {
//       // 4. Send message using the CHAT SESSION for history
//       final response =
//           await _chat.sendMessage(ai.Content.text(userMessageText));

//       // 5. Add bot's response and scroll
//       setState(() {
//         _messages.add(ChatMessage(
//           // Use response.text for the final output
//           text: response.text ?? "Sorry, I couldn't respond.",
//           isUser: false,
//         ));
//         _isLoading = false;

//         // Auto-scroll to the bottom
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       });
//     } catch (e) {
//       // Handle API errors
//       setState(() {
//         _messages.add(ChatMessage(
//           text: "Error Details: ${e.toString()}",
//           isUser: false,
//         ));
//         _isLoading = false;
//       });
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as ai;

// --- Data Model ---
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

// --- State Management ---
class SimpleChatScreen extends StatefulWidget {
  const SimpleChatScreen({super.key});

  @override
  State<SimpleChatScreen> createState() => _SimpleChatScreenState();
}

class _SimpleChatScreenState extends State<SimpleChatScreen> {
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  late final ai.GenerativeModel _model;
  late final ai.ChatSession _chat;

  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _model = ai.GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: ai.Content.system(
          "You are a helpful and polite medical assistant for a doctor booking app. "
          "Your primary role is to answer user questions related to health, medicine, doctors, symptoms, and appointments. "
          "Always give advice that is general and safe, and never act as a substitute for a real doctor. "
          "Politely decline to answer any questions that are not related to these medical or health topics. "
          "Do not answer non-medical questions like history, movies, or politics."),
    );
    _chat = _model.startChat();
    
    // Add welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add(ChatMessage(
          text: "Hello! 👋 I'm your AI medical assistant. How can I help you today?",
          isUser: false,
        ));
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.medical_services, 
                color: Colors.white, 
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Medical Assistant',
                  style: TextStyle(
                    color: Color(0xFF2D3748),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Always online',
                  style: TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF4A5568)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
          ),
          if (_isLoading) _buildTypingIndicator(),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF667eea).withOpacity(0.1),
                  const Color(0xFF764ba2).withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Color(0xFF667eea),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Start a conversation',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ask me anything about health & medicine',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final delay = index * 0.2;
        final animValue = ((value + delay) % 1.0);
        final scale = 0.5 + (0.5 * (1 - (animValue - 0.5).abs() * 2));
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF667eea),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted && _isLoading) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: message.isUser
                    ? const LinearGradient(
                        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                      )
                    : null,
                color: message.isUser ? null : Colors.white,
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: message.isUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  topRight: message.isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : const Color(0xFF2D3748),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF667eea).withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF667eea),
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Type your health question...',
                    hintStyle: TextStyle(color: Color(0xFFA0AEC0)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  enabled: !_isLoading,
                  onSubmitted: (value) => _sendMessage(),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667eea).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isLoading ? null : _sendMessage,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      _textController.text.isEmpty ? Icons.send : Icons.send,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    if (_textController.text.trim().isEmpty || _isLoading) return;

    final userMessageText = _textController.text.trim();
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(text: userMessageText, isUser: true));
      _isLoading = true;
    });

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    try {
      final response =
          await _chat.sendMessage(ai.Content.text(userMessageText));

      setState(() {
        _messages.add(ChatMessage(
          text: response.text ?? "Sorry, I couldn't respond.",
          isUser: false,
        ));
        _isLoading = false;
      });

      // Scroll to bottom after response
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: "I apologize, but I'm having trouble connecting right now. Please try again in a moment.",
          isUser: false,
        ));
        _isLoading = false;
      });
    }
  }
}