import 'package:flutter/material.dart';
import '../../models/touristic_attraction.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/detail_row.dart';

class TouristicDetailView extends StatefulWidget {
  final int id;
  const TouristicDetailView({super.key, required this.id});

  @override
  State<TouristicDetailView> createState() => _TouristicDetailViewState();
}

class _TouristicDetailViewState extends State<TouristicDetailView> {
  final ApiService _api = ApiService();
  late Future<TouristicAttraction> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getTouristicAttractionById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Turístico')),
      body: FutureBuilder<TouristicAttraction>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () => setState(
                () => _future = _api.getTouristicAttractionById(widget.id),
              ),
            );
          }
          final t = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFFE65100).withOpacity(0.1),
                    child: const Icon(
                      Icons.place_outlined,
                      size: 40,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    t.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 32),
                DetailRow(
                  icon: Icons.location_city,
                  label: 'Ciudad',
                  value: t.cityName ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.tag,
                  label: 'ID Departamento',
                  value: t.departmentId?.toString() ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Latitud',
                  value: t.latitude ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Longitud',
                  value: t.longitude ?? 'N/D',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descripción',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(t.description, style: const TextStyle(height: 1.5)),
              ],
            ),
          );
        },
      ),
    );
  }
}
