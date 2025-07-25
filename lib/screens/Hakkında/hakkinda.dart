import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:harcama_takibi/screens/Hakkında/hakkinda_view.dart';

class HakkindaProvider extends ChangeNotifier {}

class Hakkinda extends StatefulWidget {
  const Hakkinda({super.key});

  @override
  State<Hakkinda> createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  late HakkindaProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = HakkindaProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: const HakkindaView(),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }
}
