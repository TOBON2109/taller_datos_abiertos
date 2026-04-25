import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/president.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';

class PresidentListView extends StatefulWidget {
  const PresidentListView({super.key});

  @override
  State<PresidentListView> createState() => _PresidentListViewState();
}

class _PresidentListViewState extends State<PresidentListView> {
  final ApiService _api = ApiService();
  late Future<List<President>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getPresidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Presidentes')),
      body: FutureBuilder<List<President>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _future = _api.getPresidents()),
            );
          }
          final list = snapshot.data!;
          if (list.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final p = list[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF8B0000),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  p.fullName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(p.politicalParty),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/presidents/${p.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
