
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مهندس البيت',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  Map<String, String> videoLinks = {
    "تركيب البلاط": "https://www.youtube.com/watch?v=xUhwHDntGSo",
    "العزل": "https://www.youtube.com/watch?v=Dj79GlnEIQY",
    "شبابيك PVC": "https://www.youtube.com/watch?v=TjjkSy5ybWQ",
    "أبواب خشب": "https://www.youtube.com/watch?v=oa3EvCt8HX8",
    "تمديد كهرباء": "https://www.youtube.com/watch?v=pcKSgrMgG3E",
    "تمديد الماء": "https://www.youtube.com/watch?v=5yNnK2YDVbo",
    "تدفئة": "https://www.youtube.com/watch?v=CFLV4JrjTGg",
    "أسقف مستعارة": "https://www.youtube.com/watch?v=L8njYXJuNhc",
    "الحنفيات": "https://www.youtube.com/watch?v=Z71EF5qDYZU",
    "مكيفات": "https://www.youtube.com/watch?v=MG3BtopVQSg",
    "الإنترنت": "https://www.youtube.com/watch?v=4inmVxCGuWU",
    "المجاري": "https://www.youtube.com/watch?v=eb_FONcaroM",
    "خزائن المطابخ": "https://www.youtube.com/watch?v=yiNn0e4J7-U",
  };

  void sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'content': text});
    });

    String reply = "عذرًا، لم أفهم سؤالك. حاول مجددًا بكلمات أوضح.";

    videoLinks.forEach((keyword, link) {
      if (text.contains(keyword)) {
        reply = "لديك استفسار حول "$keyword"، أنصحك بمشاهدة هذا الفيديو:
$link";
      }
    });

    setState(() {
      messages.add({'role': 'bot', 'content': reply});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('مساعد مهندس البيت')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final msg = messages[index];
                  final isUser = msg['role'] == 'user';
                  return Container(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Text(msg['content'] ?? ''),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _controller)),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: sendMessage,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
