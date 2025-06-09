
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plant_vaidya/providers/app_state_provider.dart';
import 'package:plant_vaidya/widgets/history_list_widget.dart';
import 'package:plant_vaidya/widgets/loading_indicator.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        if (appState.isLoadingHistory) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LoadingIndicator(),
                SizedBox(height: 16),
                Text('Loading history...'),
              ],
            ),
          );
        }

        return HistoryListWidget(
          history: appState.history,
          onClearHistory: () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text('Confirm Clear History'),
                  content: const Text('Are you sure you want to delete all history entries? This action cannot be undone.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Clear All', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      onPressed: () {
                        appState.clearHistory();
                        Navigator.of(ctx).pop();
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('History cleared.')),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
