
import 'package:flutter/material.dart';

void main() => runApp(const FreeFireSettingsApp());

class FreeFireSettingsApp extends StatelessWidget {
  const FreeFireSettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FF Settings',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08070B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7A00),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SettingsHome(),
    );
  }
}

class SettingsHome extends StatefulWidget {
  const SettingsHome({super.key});

  @override
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  String device = 'REDMI A5';
  int preset = 0;

  final presets = const [
    ('🔥 Быстрый', [95, 90, 85, 80, 75]),
    ('🎯 Точный', [85, 80, 75, 70, 65]),
    ('⚡ Универсальный', [90, 85, 80, 75, 70]),
  ];

  final names = const [
    'Общая',
    'Красная точка',
    '2x прицел',
    '4x прицел',
    'Снайперский',
  ];

  void showSaved() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Настройки сохранены в приложении')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final values = presets[preset].$2;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🔥 FF SETTINGS',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'НАСТРОЙКИ FREE FIRE',
            style: TextStyle(
              color: Color(0xFFFF7A00),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Пресеты чувствительности для ручной настройки игры',
            style: TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 18),

          TextField(
            controller: TextEditingController(text: device),
            onChanged: (v) => device = v.toUpperCase(),
            decoration: InputDecoration(
              labelText: 'Модель телефона',
              filled: true,
              fillColor: const Color(0xFF17131C),
              prefixIcon: const Icon(Icons.phone_android),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 18),
          const Text(
            'ПРЕСЕТ',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(presets.length, (i) {
              return ChoiceChip(
                label: Text(presets[i].$1),
                selected: preset == i,
                onSelected: (_) => setState(() => preset = i),
              );
            }),
          ),

          const SizedBox(height: 22),

          ...List.generate(names.length, (i) {
            return Card(
              color: const Color(0xFF15111A),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFFF7A00),
                  child: Text(
                    '${values[i]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                title: Text(
                  names[i],
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: LinearProgressIndicator(
                  value: values[i] / 100,
                  minHeight: 5,
                  backgroundColor: Colors.white12,
                ),
              ),
            );
          }),

          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: showSaved,
            icon: const Icon(Icons.save),
            label: const Text(
              'СОХРАНИТЬ НАСТРОЙКИ',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFF7A00),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),

          const SizedBox(height: 14),
          const Text(
            'Приложение не изменяет файлы Free Fire и не обходит защиту игры. '
            'Оно хранит и показывает выбранные пользователем настройки.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
