import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profil_view.dart';

class ProfilProvider extends ChangeNotifier {}

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late ProfilProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = ProfilProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: const ProfilView(),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }
}
