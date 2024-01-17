import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: SearchBarApp(),
        routes: {
          '/chat': (context) => ChatScreen(),
        },
      ),
    );

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Чаты')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String username = 'User $index';
                    return ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF1FDB5F), // Начальный цвет градиента
                              Color(0xFF31C764), // Конечный цвет градиента
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          child: Text('${username[0]}'),
                        ),
                      ),
                      title: Text(username),
                      subtitle: Text('Last message'),
                      onTap: () {
                        _navigateToChat(context, username);
                      },
                    );
                  });
                },
              ),
            ),
            // Wrap the ListView with an Expanded widget
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  buildChatItem('User A', 'Last message', context),
                  buildChatItem('User B', 'Last message', context),
                  buildChatItem('User C', 'Last message', context),
                  buildChatItem('User D', 'Last message', context),
                  buildChatItem('User E', 'Last message', context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChat(BuildContext context, String username) {
    Navigator.pushNamed(
      context,
      '/chat',
      arguments: {'username': username}, // Передача данных в чат
    );
  }

  Widget buildChatItem(
      String username, String lastMessage, BuildContext context) {
    return Container(
      height: 80,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1FDB5F), // Начальный цвет градиента
                  Color(0xFF31C764), // Конечный цвет градиента
                ],
              ),
              shape: BoxShape.circle),
          child: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            child: Text(username[0]),
          ),
        ),
        title: Text(username),
        subtitle: Text(lastMessage),
        onTap: () {
          _navigateToChat(context, username);
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// ...

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String username = args['username'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Чат с $username'),
        actions: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              // Добавьте функциональность для вложения файлов
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: messages
                  .length, // Теперь количество сообщений берется из списка
              itemBuilder: (BuildContext context, int index) {
                return buildMessageItem('User $username', messages[index]);
              },
            ),
          ),
          // Ввод сообщения
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget buildMessageItem(String sender, String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.transparent,
            child: Text(sender[0]),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sender, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(message),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.attach_file),
                onPressed: () {
                  // Добавьте функциональность для вложения файлов
                },
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () {
                  // Добавьте функциональность для записи голосовых сообщений
                },
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _sendMessage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      _messageController.clear();

      setState(() {
        // Добавьте новое сообщение в список
        messages.add(message);
      });
    }
  }
}
