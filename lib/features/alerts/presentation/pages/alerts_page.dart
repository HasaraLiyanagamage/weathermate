import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alerts_provider.dart';
import '../../data/models/weather_alert_model.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlertsProvider>().loadAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAlertDialog(context),
          ),
        ],
      ),
      body: Consumer<AlertsProvider>(
        builder: (context, alertsProvider, child) {
          if (alertsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (alertsProvider.alerts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No alerts configured',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create a weather alert',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: alertsProvider.alerts.length,
            itemBuilder: (context, index) {
              final alert = alertsProvider.alerts[index];
              return _buildAlertCard(context, alert, alertsProvider);
            },
          );
        },
      ),
    );
  }

  Widget _buildAlertCard(
      BuildContext context, WeatherAlertModel alert, AlertsProvider provider) {
    IconData icon;
    Color color;

    switch (alert.alertType) {
      case 'temperature':
        icon = Icons.thermostat;
        color = Colors.orange;
        break;
      case 'humidity':
        icon = Icons.water_drop;
        color = Colors.blue;
        break;
      case 'wind':
        icon = Icons.air;
        color = Colors.teal;
        break;
      case 'rain':
        icon = Icons.umbrella;
        color = Colors.indigo;
        break;
      case 'snow':
        icon = Icons.ac_unit;
        color = Colors.lightBlue;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          alert.cityName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(alert.getAlertDescription()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: alert.isEnabled,
              onChanged: (value) {
                provider.toggleAlert(alert.id);
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  _showDeleteDialog(context, alert, provider);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAlertDialog(BuildContext context) {
    final cityController = TextEditingController();
    String selectedType = 'temperature';
    String selectedCondition = 'above';
    double threshold = 30.0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Weather Alert'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Alert Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'temperature', child: Text('Temperature')),
                    DropdownMenuItem(value: 'humidity', child: Text('Humidity')),
                    DropdownMenuItem(value: 'wind', child: Text('Wind Speed')),
                    DropdownMenuItem(value: 'rain', child: Text('Rain')),
                    DropdownMenuItem(value: 'snow', child: Text('Snow')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedType = value!);
                  },
                ),
                const SizedBox(height: 16),
                if (selectedType != 'rain' && selectedType != 'snow') ...[
                  DropdownButtonFormField<String>(
                    value: selectedCondition,
                    decoration: const InputDecoration(
                      labelText: 'Condition',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'above', child: Text('Above')),
                      DropdownMenuItem(value: 'below', child: Text('Below')),
                    ],
                    onChanged: (value) {
                      setState(() => selectedCondition = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Threshold',
                      border: const OutlineInputBorder(),
                      suffixText: selectedType == 'temperature'
                          ? '°C'
                          : selectedType == 'humidity'
                              ? '%'
                              : 'm/s',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      threshold = double.tryParse(value) ?? threshold;
                    },
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (cityController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a city name')),
                  );
                  return;
                }

                final alert = WeatherAlertModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  cityName: cityController.text.trim(),
                  alertType: selectedType,
                  condition: selectedCondition,
                  threshold: threshold,
                  isEnabled: true,
                  createdAt: DateTime.now(),
                );

                context.read<AlertsProvider>().addAlert(alert);
                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WeatherAlertModel alert, AlertsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Alert'),
        content: Text('Delete alert for ${alert.cityName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteAlert(alert.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
