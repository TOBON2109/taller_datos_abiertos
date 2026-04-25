import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/airport.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';

class AirportListView extends StatefulWidget {
  const AirportListView({super.key});

  @override
  State<AirportListView> createState() => _AirportListViewState();
}

class _AirportListViewState extends State<AirportListView> {
  final ApiService _api = ApiService();
  late Future<List<Airport>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getAirports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aeropuertos')),
      body: FutureBuilder<List<Airport>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _future = _api.getAirports()),
            );
          }
          final list = snapshot.data!;
          if (list.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final a = list[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF1565C0),
                  child: Icon(
                    Icons.flight_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  a.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'IATA: ${a.iataCode} · ${a.departmentName ?? 'N/D'}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/airports/${a.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
