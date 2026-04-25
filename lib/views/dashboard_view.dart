import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const List<Map<String, dynamic>> _endpoints = [
    {
      'title': 'Departamentos',
      'subtitle': 'Los 32 departamentos de Colombia',
      'icon': Icons.map_outlined,
      'color': Color(0xFF003DA5),
      'route': '/departments',
    },
    {
      'title': 'Presidentes',
      'subtitle': 'Historia presidencial colombiana',
      'icon': Icons.person_outline,
      'color': Color(0xFF8B0000),
      'route': '/presidents',
    },
    {
      'title': 'Aeropuertos',
      'subtitle': 'Aeropuertos en todo el país',
      'icon': Icons.flight_outlined,
      'color': Color(0xFF1565C0),
      'route': '/airports',
    },
    {
      'title': 'Festivos',
      'subtitle': 'Días festivos de Colombia 2025',
      'icon': Icons.calendar_today_outlined,
      'color': Color(0xFF2E7D32),
      'route': '/holidays',
    },
    {
      'title': 'Atractivos Turísticos',
      'subtitle': 'Lugares que debes visitar',
      'icon': Icons.place_outlined,
      'color': Color(0xFFE65100),
      'route': '/touristic',
    },
    {
      'title': 'Áreas Naturales',
      'subtitle': 'Parques y reservas naturales',
      'icon': Icons.forest_outlined,
      'color': Color(0xFF00695C),
      'route': '/natural',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🇨🇴 Datos Abiertos Colombia')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explora Colombia',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Selecciona una categoría para comenzar',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: _endpoints.length,
                itemBuilder: (context, index) {
                  final item = _endpoints[index];
                  return _DashboardCard(
                    title: item['title'],
                    subtitle: item['subtitle'],
                    icon: item['icon'],
                    color: item['color'],
                    onTap: () => context.push(item['route']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                radius: 28,
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
