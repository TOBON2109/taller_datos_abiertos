import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/department.dart';
import '../models/president.dart';
import '../models/airport.dart';
import '../models/holiday.dart';
import '../models/touristic_attraction.dart';
import '../models/natural_area.dart';

class ApiService {
  final String _base = AppConfig.baseUrl;

  Future<List<T>> _getList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await http.get(Uri.parse('$_base/$endpoint'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception(
        'Error ${response.statusCode}: No se pudo cargar $endpoint',
      );
    }
  }

  Future<T> _getById<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await http.get(Uri.parse('$_base/$endpoint'));
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
        'Error ${response.statusCode}: No se encontró el recurso',
      );
    }
  }

  // Departments
  Future<List<Department>> getDepartments() =>
      _getList('Department', Department.fromJson);

  Future<Department> getDepartmentById(int id) =>
      _getById('Department/$id', Department.fromJson);

  // Presidents
  Future<List<President>> getPresidents() =>
      _getList('President', President.fromJson);

  Future<President> getPresidentById(int id) =>
      _getById('President/$id', President.fromJson);

  // Airports
  Future<List<Airport>> getAirports() => _getList('Airport', Airport.fromJson);

  Future<Airport> getAirportById(int id) =>
      _getById('Airport/$id', Airport.fromJson);

  // Holidays
  Future<List<Holiday>> getHolidays({int year = 2025}) =>
      _getList('Holiday/year/$year', Holiday.fromJson);

  // Touristic Attractions
  Future<List<TouristicAttraction>> getTouristicAttractions() =>
      _getList('TouristicAttraction', TouristicAttraction.fromJson);

  Future<TouristicAttraction> getTouristicAttractionById(int id) =>
      _getById('TouristicAttraction/$id', TouristicAttraction.fromJson);

  // Natural Areas
  Future<List<NaturalArea>> getNaturalAreas() =>
      _getList('NaturalArea', NaturalArea.fromJson);

  Future<NaturalArea> getNaturalAreaById(int id) =>
      _getById('NaturalArea/$id', NaturalArea.fromJson);
}
