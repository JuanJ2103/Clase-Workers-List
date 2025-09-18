import 'package:flutter/material.dart';
import 'package:juan10d/Student.dart';
import 'package:juan10d/worker.dart'; // Asegúrate de que esta clase exista

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // --------------------------- Student (original) --------------------------
  int _counter = 0;
  String name = 'Juan';
  int age = 22;
  bool programming = true;

  List<String> lista = ["Juan", "Wero", "Jasso"];
  Student student = Student(name: "Juan", enrollment: "JJRV123456");

  TextEditingController _txtNameCtrl = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addStudent() {
    final name = _txtNameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please set all data")),
      );
      return;
    }
    setState(() {
      lista.add(name);
    });
    _txtNameCtrl.clear();
  }

  Widget getStudents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        const Text("Student List:"),
        const SizedBox(height: 10),
        ...lista.map((n) => Text("- $n")).toList(),
      ],
    );
  }

  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _lastnameCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();

  List<Worker> workerList = [];

  void _addWorker() {
    final idText = _idCtrl.text.trim();
    final name = _nameCtrl.text.trim();
    final lastname = _lastnameCtrl.text.trim();
    final ageText = _ageCtrl.text.trim();

    if (idText.isEmpty || name.isEmpty || lastname.isEmpty || ageText.isEmpty) {
      _showError("No se admiten campos nulos o vacíos");
      return;
    }

    final id = int.tryParse(idText);
    final age = int.tryParse(ageText);

    if (id == null || age == null) {
      _showError("ID y Edad deben ser números válidos.");
      return;
    }

    if (age < 18) {
      _showError("Solo se pueden registrar mayores de edad");
      return;
    }

    if (workerList.any((w) => w.id == id)) {
      _showError("No se admiten ids repetidos");
      return;
    }

    setState(() {
      workerList.add(
        Worker(id: id, name: name, lastname: lastname, age: age),
      );
      _idCtrl.clear();
      _nameCtrl.clear();
      _lastnameCtrl.clear();
      _ageCtrl.clear();
    });
  }

  void _removeLastWorker() {
    if (workerList.isNotEmpty) {
      setState(() {
        workerList.removeLast();
      });
    } else {
      _showError("No hay trabajadores para eliminar.");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget getWorkers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Lista de Trabajadores:"),
        const SizedBox(height: 10),
        ...workerList.map((w) => Text("- ${w.name} ${w.lastname} (ID: ${w.id}, Edad: ${w.age})")),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 15),
            Text('Nombre: $name'),
            Text('Mi edad es: $age'),
            Text('¿Soy bueno pa la chamba? $programming'),
            const SizedBox(height: 15),

            getStudents(),

            const SizedBox(height: 14),
            TextField(
              controller: _txtNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addStudent,
              child: const Text('Add Student'),
            ),

            const Divider(height: 40, thickness: 2),

            const Text("Agregar Trabajador:"),

            const SizedBox(height: 10),
            TextField(
              controller: _idCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _lastnameCtrl,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addWorker,
                    child: const Text("Agregar Trabajador"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _removeLastWorker,
                    child: const Text("Eliminar Último"),
                  ),
                ),
              ],
            ),

            getWorkers(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
