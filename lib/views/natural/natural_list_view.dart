import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/natural_area.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';

class NaturalListView extends StatefulWidget {
  const NaturalListView({super.key});

  @override
  State<NaturalListView> createState() => _NaturalListViewState();
}

class _NaturalListViewState extends State<NaturalListView> {
  final ApiService _api = ApiService();
  late Future<List<NaturalArea>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getNaturalAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Áreas Naturales')),
      body: FutureBuilder<List<NaturalArea>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _future = _api.getNaturalAreas()),
            );
          }
          final list = snapshot.data!;
          if (list.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final n = list[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF00695C),
                  child: Icon(
                    Icons.forest_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  n.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (n.departmentName != null)
                      Text(
                        '📍 ${n.departmentName}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    if (n.category != null)
                      Text(
                        n.category!,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                  ],
                ),
                isThreeLine: n.departmentName != null && n.category != null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/natural/${n.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
