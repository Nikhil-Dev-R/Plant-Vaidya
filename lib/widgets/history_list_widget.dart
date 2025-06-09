
import 'package:flutter/material.dart';
import 'package:plant_vaidya/models/plant_models.dart';
import 'package:plant_vaidya/widgets/history_list_item_widget.dart';
import 'package:plant_vaidya/widgets/history_detail_dialog.dart';

class HistoryListWidget extends StatelessWidget {
  final List<HistoryEntry> history;
  final VoidCallback onClearHistory;

  const HistoryListWidget({
    super.key,
    required this.history,
    required this.onClearHistory,
  });

  void _showDetailsDialog(BuildContext context, HistoryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HistoryDetailDialog(entry: entry);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.info_outline, size: 60, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No History Yet',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Your plant analysis history will appear here once you analyze some plants.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Analysis History', style: Theme.of(context).textTheme.titleLarge),
              TextButton.icon(
                icon: Icon(Icons.delete_sweep_outlined, color: Theme.of(context).colorScheme.error),
                label: Text('Clear All', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                onPressed: onClearHistory,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final entry = history[index];
              return HistoryListItemWidget(
                entry: entry,
                onTap: () => _showDetailsDialog(context, entry),
              );
            },
          ),
        ),
      ],
    );
  }
}
