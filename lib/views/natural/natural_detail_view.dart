import 'package:flutter/material.dart';
import '../../models/natural_area.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/detail_row.dart';

class NaturalDetailView extends StatefulWidget {
  final int id;
  const NaturalDetailView({super.key, required this.id});

  @override
  State<NaturalDetailView> createState() => _NaturalDetailViewState();
}

class _NaturalDetailViewState extends State<NaturalDetailView> {
  final ApiService _api = ApiService();
  late Future<NaturalArea> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getNaturalAreaById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Área Natural')),
      body: FutureBuilder<NaturalArea>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () =>
                  setState(() => _future = _api.getNaturalAreaById(widget.id)),
            );
          }
          final n = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF00695C).withOpacity(0.1),
                    child: const Icon(
                      Icons.forest_outlined,
                      size: 40,
                      color: Color(0xFF00695C),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    n.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 32),
                DetailRow(
                  icon: Icons.category_outlined,
                  label: 'Categoría',
                  value: n.category ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.map_outlined,
                  label: 'Departamento',
                  value: n.departmentName ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Latitud',
                  value: n.latitude ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Longitud',
                  value: n.longitude ?? 'N/D',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descripción',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(n.description, style: const TextStyle(height: 1.5)),
              ],
            ),
          );
        },
      ),
    );
  }
}
