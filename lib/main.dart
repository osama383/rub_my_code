import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = "https://cjjdlvuwqxhcgvprbyck.supabase.co";
const anonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNqamRsdnV3cXhoY2d2cHJieWNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgxMTE1MjQsImV4cCI6MjA2MzY4NzUyNH0.rNA3XgzzMvPMynhotgbHBJ6R-Hju6usKvm3EbEKZ47k";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Rub my code', home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('instruments').select();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final instruments = snapshot.data!;
          return ListView.builder(
            itemCount: instruments.length,
            itemBuilder: ((context, index) {
              final instrument = instruments[index];
              return ListTile(title: Text('$index'));
            }),
          );
        },
      ),
    );
  }
}
