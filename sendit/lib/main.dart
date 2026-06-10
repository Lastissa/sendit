import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox(
    'information',
  ); // a db for holdig every non relational data
  runApp(ProviderScope(child: const SendIt()));
}

class SendIt extends StatefulWidget {
  const SendIt({super.key});

  @override
  State<SendIt> createState() => SendItState();
}

class SendItState extends State<SendIt> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
