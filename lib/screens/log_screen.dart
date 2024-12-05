import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<String> _logs = [];

  Future<void> _loadLogs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> logs = prefs.getStringList('logs') ?? [];

    setState(() {
      _logs = logs;
    });
  }

  Future<void> _addLog(String log) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> logs = prefs.getStringList('logs') ?? [];

    logs.add(log);
    await prefs.setStringList('logs', logs);

    setState(() {
      _logs = logs;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Screen'),
      ),
      body: _logs.isEmpty
          ? Center(child: Text('No logs found.'))
          : ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_logs[index]),
                );
              },
            ),
    );
  }
}
