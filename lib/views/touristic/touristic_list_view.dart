import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/touristic_attraction.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';

class TouristicListView extends StatefulWidget {
  const TouristicListView({super.key});

  @override
  State<TouristicListView> createState() => _TouristicListViewState();
}

class _TouristicListViewState extends State<TouristicListView> {
  final ApiService _api = ApiService();
  late Future<List<TouristicAttraction>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getTouristicAttractions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atractivos Turísticos')),
      body: FutureBuilder<List<TouristicAttraction>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () =>
                  setState(() => _future = _api.getTouristicAttractions()),
            );
          }
          final list = snapshot.data!;
          if (list.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final t = list[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE65100),
                  child: Icon(
                    Icons.place_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  t.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(t.cityName ?? 'N/D'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/touristic/${t.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
