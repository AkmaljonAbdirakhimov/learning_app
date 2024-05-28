import 'package:flutter/material.dart';
import 'package:learning_app/utils/app_constants.dart';
import 'package:learning_app/providers/app_state_provider.dart';
import 'package:learning_app/widgets/custom_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final formKey = GlobalKey<FormState>();
  final appTitleFocusNode = FocusNode();

  void save() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            onPressed: save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: AppConstants.appTitle,
                focusNode: appTitleFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter app title";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null && newValue.isNotEmpty) {
                    AppConstants.appTitle = newValue;
                    appTitleFocusNode.unfocus();
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "App title",
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile.adaptive(
                value: ThemeMode.dark == appState.themeMode,
                title: const Text("Dark Mode"),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                onChanged: (value) {
                  appState.toggleTheme(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
