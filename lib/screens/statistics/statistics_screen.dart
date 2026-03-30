import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anti_gaspi_app/database/database.dart';
import 'package:drift/drift.dart' hide Column;

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedDays = 7;

  final List<int> _periods = [7, 14, 30];

  Future<List<WasteEvent>> _fetchEvents(AppDatabase db) async {
    final from = DateTime.now().subtract(Duration(days: _selectedDays));
    return (db.select(db.wasteEvents)
          ..where((e) => e.date.isBiggerOrEqualValue(from))
          ..orderBy([(e) => OrderingTerm.desc(e.date)]))
        .get();
  }

  Map<String, int> _count(List<WasteEvent> events, String Function(WasteEvent) key) {
    final map = <String, int>{};
    for (final e in events) {
      map[key(e)] = (map[key(e)] ?? 0) + 1;
    }
    final sorted = Map.fromEntries(
      map.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SegmentedButton<int>(
            segments: _periods
                .map((d) => ButtonSegment(value: d, label: Text('$d jours')))
                .toList(),
            selected: {_selectedDays},
            onSelectionChanged: (val) =>
                setState(() => _selectedDays = val.first),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<WasteEvent>>(
              future: _fetchEvents(db),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final events = snapshot.data ?? [];

                if (events.isEmpty) {
                  return const Center(
                    child: Text('Aucun jet enregistré sur cette période.'),
                  );
                }

                final byCategory = _count(events, (e) => e.category);
                final byReason = _count(events, (e) => e.reason);
                final byProduct = _count(events, (e) => e.productName);

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _SectionTitle(
                        title: '${events.length} jet(s) sur $_selectedDays jours'),
                    const SizedBox(height: 16),
                    _StatSection(title: 'Par catégorie', data: byCategory),
                    const SizedBox(height: 16),
                    _StatSection(title: 'Par raison', data: byReason),
                    const SizedBox(height: 16),
                    _StatSection(title: 'Produits les plus jetés', data: byProduct),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _StatSection extends StatelessWidget {
  final String title;
  final Map<String, int> data;

  const _StatSection({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.values.fold(0, (a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...data.entries.map((entry) {
          final percent = total == 0 ? 0.0 : entry.value / total;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text('${entry.value}x'),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: percent,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}