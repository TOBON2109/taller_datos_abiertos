import 'package:flutter/material.dart';
import '../../models/airport.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/detail_row.dart';

class AirportDetailView extends StatefulWidget {
  final int id;
  const AirportDetailView({super.key, required this.id});

  @override
  State<AirportDetailView> createState() => _AirportDetailViewState();
}

class _AirportDetailViewState extends State<AirportDetailView> {
  final ApiService _api = ApiService();
  late Future<Airport> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getAirportById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Aeropuerto')),
      body: FutureBuilder<Airport>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () =>
                  setState(() => _future = _api.getAirportById(widget.id)),
            );
          }
          final a = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF1565C0).withOpacity(0.1),
                    child: const Icon(
                      Icons.flight_outlined,
                      size: 40,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    a.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 32),
                DetailRow(
                  icon: Icons.confirmation_number,
                  label: 'Código IATA',
                  value: a.iataCode,
                ),
                DetailRow(
                  icon: Icons.confirmation_number_outlined,
                  label: 'Código OACI',
                  value: a.oaciCode,
                ),
                DetailRow(
                  icon: Icons.category_outlined,
                  label: 'Tipo',
                  value: a.type,
                ),
                DetailRow(
                  icon: Icons.map_outlined,
                  label: 'Departamento',
                  value: a.departmentName ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Latitud',
                  value: a.latitude ?? 'N/D',
                ),
                DetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Longitud',
                  value: a.longitude ?? 'N/D',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
