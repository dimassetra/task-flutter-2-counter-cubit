import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
      color: const Color.fromARGB(255, 141, 185, 190),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Generated Words History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (appState.history.isNotEmpty)
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Clear History'),
                            content: Text(
                                'Are you sure you want to clear all history?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  appState.clearHistory();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('History cleared'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Text('Clear'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete_outline),
                    label: Text('Clear History'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (appState.history.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('No words generated yet'),
                    ),
                  )
                else
                  ...appState.history.asMap().entries.map(
                        (entry) => ListTile(
                          title: Text(entry.value.asLowerCase),
                          textColor: Theme.of(context).primaryColor,
                          trailing: Text(
                            'Generated ${appState.history.length - entry.key}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(entry.value.asLowerCase),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
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
