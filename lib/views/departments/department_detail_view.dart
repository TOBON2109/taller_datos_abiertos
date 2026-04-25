import 'package:flutter/material.dart';
import '../../models/department.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/detail_row.dart';

class DepartmentDetailView extends StatefulWidget {
  final int id;
  const DepartmentDetailView({super.key, required this.id});

  @override
  State<DepartmentDetailView> createState() => _DepartmentDetailViewState();
}

class _DepartmentDetailViewState extends State<DepartmentDetailView> {
  final ApiService _api = ApiService();
  late Future<Department> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getDepartmentById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Departamento')),
      body: FutureBuilder<Department>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () =>
                  setState(() => _future = _api.getDepartmentById(widget.id)),
            );
          }
          final d = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF003DA5).withOpacity(0.1),
                    child: const Icon(
                      Icons.map_outlined,
                      size: 40,
                      color: Color(0xFF003DA5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    d.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 32),
                DetailRow(
                  icon: Icons.location_city,
                  label: 'Capital',
                  value: d.capital,
                ),
                DetailRow(
                  icon: Icons.straighten,
                  label: 'Superficie',
                  value: d.surface,
                ),
                DetailRow(
                  icon: Icons.people_outline,
                  label: 'Población',
                  value: d.population,
                ),
                DetailRow(
                  icon: Icons.phone,
                  label: 'Indicativo',
                  value: d.phonePrefix,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descripción',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(d.description, style: const TextStyle(height: 1.5)),
              ],
            ),
          );
        },
      ),
    );
  }
}
