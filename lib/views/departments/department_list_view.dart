import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/department.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';

class DepartmentListView extends StatefulWidget {
  const DepartmentListView({super.key});

  @override
  State<DepartmentListView> createState() => _DepartmentListViewState();
}

class _DepartmentListViewState extends State<DepartmentListView> {
  final ApiService _api = ApiService();
  late Future<List<Department>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Departamentos')),
      body: FutureBuilder<List<Department>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorWidget2(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _future = _api.getDepartments()),
            );
          }
          final departments = snapshot.data!;
          if (departments.isEmpty) return const EmptyWidget();
          return ListView.builder(
            itemCount: departments.length,
            itemBuilder: (context, index) {
              final d = departments[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF003DA5),
                  child: Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  d.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Capital: ${d.capital}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/departments/${d.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
