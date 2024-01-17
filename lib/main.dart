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
  const SearchBarApp({super.key});

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
                  Container(
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
                          child: Text('ВВ'),
                        ),
                      ),
                      title: Text('User A'),
                      subtitle: Text('Last message'),
                      onTap: () {
                        _navigateToChat(context, 'User A');
                      },
                    ),
                  ),
                  Container(
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
                          child: Text('B'),
                        ),
                      ),
                      title: Text('User B'),
                      subtitle: Text('Last message'),
                      onTap: () {
                        _navigateToChat(context, 'User B');
                      },
                    ),
                  ),
                  Container(
                    height: 80,
                    child: ListTile(
                      leading: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF1FDB5F), // Начальный цвет градиента
                                Color(0xFF31C764), // Конечный цвет градиента
                              ],
                            ),
                            shape: BoxShape.circle),
                        child: const CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          child: Text('C'),
                        ),
                      ),
                      title: Text('User C'),
                      subtitle: Text('Last message'),
                      onTap: () {
                        _navigateToChat(context, 'User C');
                      },
                    ),
                  ),
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
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String username = args['username'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Чат с $username'),
      ),
      body: Center(
        child: Text('Это экран чата с $username'),
      ),
    );
  }
}
