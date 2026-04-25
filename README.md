# 🇨🇴 Taller Datos Abiertos Colombia

Aplicación Flutter que consume la [API Colombia](https://api-colombia.com/) para mostrar información pública del país, implementando arquitectura por capas, navegación con `go_router` y manejo de estados.

---

## API Utilizada

**Base URL:** `https://api-colombia.com/api/v1`  
**Documentación:** [Swagger](https://api-colombia.com/swagger/index.html)  
No requiere autenticación.

### Endpoints implementados

| Endpoint | Descripción |
|----------|-------------|
| `GET /Department` | Lista de los 32 departamentos |
| `GET /Department/{id}` | Detalle de un departamento |
| `GET /President` | Lista de presidentes de Colombia |
| `GET /President/{id}` | Detalle de un presidente |
| `GET /Airport` | Lista de aeropuertos del país |
| `GET /Airport/{id}` | Detalle de un aeropuerto |
| `GET /Holiday/year/{year}` | Festivos por año (2024, 2025, 2026) |
| `GET /TouristicAttraction` | Atractivos turísticos |
| `GET /TouristicAttraction/{id}` | Detalle de un atractivo turístico |
| `GET /NaturalArea` | Áreas naturales y parques |
| `GET /NaturalArea/{id}` | Detalle de un área natural |

---

## Arquitectura y Estructura
lib/
├── config/
│   └── app_config.dart         # Lee la URL base desde .env
├── models/
│   ├── department.dart         # Modelo Departamento
│   ├── president.dart          # Modelo Presidente
│   ├── airport.dart            # Modelo Aeropuerto
│   ├── holiday.dart            # Modelo Festivo
│   ├── touristic_attraction.dart # Modelo Atractivo Turístico
│   └── natural_area.dart       # Modelo Área Natural
├── routes/
│   └── app_router.dart         # Configuración de go_router
├── services/
│   └── api_service.dart        # Llamadas HTTP con el paquete http
├── themes/
│   └── app_theme.dart          # Tema global (colores bandera Colombia)
├── views/
│   ├── dashboard_view.dart     # Pantalla principal con cards
│   ├── departments/
│   │   ├── department_list_view.dart
│   │   └── department_detail_view.dart
│   ├── presidents/
│   │   ├── president_list_view.dart
│   │   └── president_detail_view.dart
│   ├── airports/
│   │   ├── airport_list_view.dart
│   │   └── airport_detail_view.dart
│   ├── holidays/
│   │   └── holiday_list_view.dart
│   ├── touristic/
│   │   ├── touristic_list_view.dart
│   │   └── touristic_detail_view.dart
│   └── natural/
│       ├── natural_list_view.dart
│       └── natural_detail_view.dart
├── widgets/
│   ├── state_widgets.dart      # LoadingWidget, ErrorWidget2, EmptyWidget
│   └── detail_row.dart         # Fila reutilizable para detalles
└── main.dart

---

## Paquetes utilizados

| Paquete | Versión | Uso |
|---------|---------|-----|
| `http` | ^1.2.1 | Peticiones HTTP GET a la API |
| `go_router` | ^13.2.4 | Navegación entre pantallas con rutas nombradas |
| `flutter_dotenv` | ^5.1.0 | Manejo de variables de entorno (.env) |

---

## Rutas implementadas con go_router

| Nombre | Path | Descripción |
|--------|------|-------------|
| `dashboard` | `/` | Pantalla principal |
| `departments` | `/departments` | Lista de departamentos |
| `department-detail` | `/departments/:id` | Detalle de departamento |
| `presidents` | `/presidents` | Lista de presidentes |
| `president-detail` | `/presidents/:id` | Detalle de presidente |
| `airports` | `/airports` | Lista de aeropuertos |
| `airport-detail` | `/airports/:id` | Detalle de aeropuerto |
| `holidays` | `/holidays` | Festivos en vista calendario |
| `touristic` | `/touristic` | Lista de atractivos turísticos |
| `touristic-detail` | `/touristic/:id` | Detalle de atractivo turístico |
| `natural` | `/natural` | Lista de áreas naturales |
| `natural-detail` | `/natural/:id` | Detalle de área natural |

Los parámetros se pasan en el path como `:id` y se reciben en el widget con `state.pathParameters['id']`.

---

## Manejo de estados

Cada vista implementa tres estados usando `FutureBuilder`:

- **Cargando:** `CircularProgressIndicator` centrado
- **Error:** Mensaje + botón de reintentar que relanza la petición
- **Éxito:** Datos renderizados con `ListView.builder`

---

## Ejemplo de respuesta JSON

**Endpoint:** `GET /api/v1/Department/2`

```json
{
  "id": 2,
  "name": "Antioquia",
  "description": "Antioquia es uno de los treinta y dos departamentos...",
  "surface": 63612,
  "population": 6887306,
  "phonePrefix": 4,
  "cityCapital": {
    "id": 12,
    "name": "Medellín"
  }
}
```

**Endpoint:** `GET /api/v1/Holiday/year/2025`

```json
[
  {
    "date": "2025-01-01",
    "name": "Año Nuevo",
    "type": "Fijo"
  },
  {
    "date": "2025-01-06",
    "name": "Reyes Magos",
    "type": "Puente"
  }
]
```

---

## Flujo GitFlow
main
└── dev
└── feature/taller_api_colombia  ← desarrollo aquí

1. Se creó `feature/taller_api_colombia` a partir de `dev`
2. Commits atómicos con prefijos: `feat:`, `fix:`, `docs:`
3. Pull Request: `feature/taller_api_colombia` → `dev`
4. Merge final: `dev` → `main`

---

## Cómo ejecutar

```bash
git clone https://github.com/TOBON2109/taller_datos_abiertos.git
cd taller_datos_abiertos
flutter pub get
flutter run
```

Requiere Flutter 3.x o superior. No necesita API Key.