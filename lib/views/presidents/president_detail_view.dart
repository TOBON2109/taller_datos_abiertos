import 'package:flutter/material.dart';
import '../../models/president.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';
import '../../widgets/detail_row.dart';

class PresidentDetailView extends StatefulWidget {
  final int id;
  const PresidentDetailView({super.key, required this.id});

  @override
  State<PresidentDetailView> createState() => _PresidentDetailViewState();
}

class _PresidentDetailViewState extends State<PresidentDetailView> {
  final ApiService _api = ApiService();
  late Future<President> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getPresidentById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Presidente')),
      body: FutureBuilder<President>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () =>
                  setState(() => _future = _api.getPresidentById(widget.id)),
            );
          }
          final p = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF8B0000).withOpacity(0.1),
                    child: const Icon(
                      Icons.person_outline,
                      size: 40,
                      color: Color(0xFF8B0000),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    p.fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 32),
                DetailRow(
                  icon: Icons.account_balance,
                  label: 'Partido político',
                  value: p.politicalParty,
                ),
                DetailRow(
                  icon: Icons.calendar_today,
                  label: 'Inicio de período',
                  value: p.startPeriodDate,
                ),
                DetailRow(
                  icon: Icons.event,
                  label: 'Fin de período',
                  value: p.endPeriodDate,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descripción',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(p.description, style: const TextStyle(height: 1.5)),
              ],
            ),
          );
        },
      ),
    );
  }
}
