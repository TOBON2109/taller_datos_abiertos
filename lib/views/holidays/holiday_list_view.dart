import 'package:flutter/material.dart';
import '../../models/holiday.dart';
import '../../services/api_service.dart';
import '../../widgets/state_widgets.dart';

class HolidayListView extends StatefulWidget {
  const HolidayListView({super.key});

  @override
  State<HolidayListView> createState() => _HolidayListViewState();
}

class _HolidayListViewState extends State<HolidayListView> {
  final ApiService _api = ApiService();
  late Future<List<Holiday>> _future;
  int _selectedYear = 2025;
  DateTime _focusedMonth = DateTime(2025, 1);

  @override
  void initState() {
    super.initState();
    _future = _api.getHolidays(year: _selectedYear);
  }

  void _changeYear(int year) {
    setState(() {
      _selectedYear = year;
      _focusedMonth = DateTime(year, 1);
      _future = _api.getHolidays(year: year);
    });
  }

  void _prevMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  List<Holiday> _holidaysForMonth(List<Holiday> all, int month) {
    return all.where((h) {
      final parts = h.date.split('-');
      if (parts.length < 2) return false;
      return int.tryParse(parts[1]) == month;
    }).toList();
  }

  String _monthName(int month) {
    const names = [
      '',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return names[month];
  }

  int _dayOfMonth(String date) {
    final parts = date.split('-');
    return parts.length >= 3 ? int.tryParse(parts[2]) ?? 0 : 0;
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  int _firstWeekday(int year, int month) =>
      DateTime(year, month, 1).weekday % 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Festivos')),
      body: Column(
        children: [
          // Selector de año
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [2024, 2025, 2026].map((year) {
                final selected = year == _selectedYear;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('$year'),
                    selected: selected,
                    onSelected: (_) => _changeYear(year),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Holiday>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (snapshot.hasError) {
                  return ErrorWidget2(
                    message: snapshot.error.toString(),
                    onRetry: () => _changeYear(_selectedYear),
                  );
                }
                final allHolidays = snapshot.data!;
                final monthHolidays = _holidaysForMonth(
                  allHolidays,
                  _focusedMonth.month,
                );
                final holidayDays = monthHolidays
                    .map((h) => _dayOfMonth(h.date))
                    .toSet();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Navegación de mes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed:
                                _focusedMonth.month > 1 ||
                                    _focusedMonth.year > _selectedYear
                                ? _prevMonth
                                : null,
                            icon: const Icon(Icons.chevron_left),
                          ),
                          Text(
                            '${_monthName(_focusedMonth.month)} $_selectedYear',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: _focusedMonth.month < 12
                                ? _nextMonth
                                : null,
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Cabecera días
                      Row(
                        children:
                            ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb']
                                .map(
                                  (d) => Expanded(
                                    child: Center(
                                      child: Text(
                                        d,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: d == 'Dom' || d == 'Sáb'
                                              ? Colors.red[300]
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(height: 4),
                      // Grid del calendario
                      _buildCalendarGrid(
                        holidayDays,
                        _focusedMonth.year,
                        _focusedMonth.month,
                      ),
                      const SizedBox(height: 16),
                      // Lista de festivos del mes
                      if (monthHolidays.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'No hay festivos este mes',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      else
                        ...monthHolidays.map(
                          (h) => Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(
                                  0xFF2E7D32,
                                ).withOpacity(0.1),
                                child: Text(
                                  '${_dayOfMonth(h.date)}',
                                  style: const TextStyle(
                                    color: Color(0xFF2E7D32),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                h.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(h.date),
                              trailing: Chip(
                                label: Text(
                                  h.type,
                                  style: const TextStyle(fontSize: 11),
                                ),
                                backgroundColor: const Color(
                                  0xFF2E7D32,
                                ).withOpacity(0.1),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(Set<int> holidayDays, int year, int month) {
    final firstDay = _firstWeekday(year, month);
    final daysInMonth = _daysInMonth(year, month);
    final today = DateTime.now();

    final List<Widget> cells = [];

    // Celdas vacías al inicio
    for (int i = 0; i < firstDay; i++) {
      cells.add(const SizedBox());
    }

    // Días del mes
    for (int day = 1; day <= daysInMonth; day++) {
      final isHoliday = holidayDays.contains(day);
      final isToday =
          today.year == year && today.month == month && today.day == day;
      final isWeekend =
          (firstDay + day - 1) % 7 == 0 || (firstDay + day - 1) % 7 == 6;

      cells.add(
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isHoliday
                ? const Color(0xFF2E7D32)
                : isToday
                ? const Color(0xFF003DA5).withOpacity(0.15)
                : null,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isHoliday || isToday
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: isHoliday
                    ? Colors.white
                    : isToday
                    ? const Color(0xFF003DA5)
                    : isWeekend
                    ? Colors.red[300]
                    : Colors.black87,
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1,
      children: cells,
    );
  }
}
