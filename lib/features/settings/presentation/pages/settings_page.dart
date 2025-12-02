import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _useFahrenheit = false;
  bool _isDarkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useFahrenheit = prefs.getBool(AppConstants.temperatureUnitKey) ?? false;
      _isDarkMode = prefs.getBool(AppConstants.themeKey) ?? false;
      _isLoading = false;
    });
  }

  Future<void> _saveTemperatureUnit(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.temperatureUnitKey, value);
    setState(() => _useFahrenheit = value);
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.themeKey, value);
    setState(() => _isDarkMode = value);
    // Note: Theme change would require app restart or theme provider
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'General',
            [
              _buildSwitchTile(
                context,
                'Temperature Unit',
                'Use Fahrenheit instead of Celsius',
                Icons.thermostat,
                _useFahrenheit,
                (value) => _saveTemperatureUnit(value),
              ),
              _buildSwitchTile(
                context,
                'Dark Mode',
                'Enable dark theme',
                Icons.dark_mode,
                _isDarkMode,
                (value) => _saveTheme(value),
              ),
            ],
          ),
          _buildSection(
            context,
            'About',
            [
              _buildInfoTile(
                context,
                'App Version',
                AppConstants.appVersion,
                Icons.info_outline,
              ),
              _buildInfoTile(
                context,
                'App Name',
                AppConstants.appName,
                Icons.apps,
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('Data Source'),
                subtitle: const Text('OpenWeatherMap API'),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () {
                  // Could open browser to API website
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Support',
            [
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text('Report a Bug'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showComingSoonDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text('Rate the App'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showComingSoonDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share the App'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showComingSoonDialog(context);
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Legal',
            [
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showComingSoonDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _showComingSoonDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text('This feature will be available in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
