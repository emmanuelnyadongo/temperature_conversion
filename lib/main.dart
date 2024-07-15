import 'package:flutter/material.dart';

void main() => runApp(TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  String _conversionType = 'F to C';
  TextEditingController _controller = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convert() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0;
      double output;
      if (_conversionType == 'F to C') {
        output = (input - 32) * 5 / 9;
      } else {
        output = input * 9 / 5 + 32;
      }
      _result = output.toStringAsFixed(2);
      _history.add('$_conversionType: $input => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('F to C'),
                    leading: Radio<String>(
                      value: 'F to C',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('C to F'),
                    leading: Radio<String>(
                      value: 'C to F',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 10),
            Text(
              _result.isEmpty ? '' : 'Converted Temperature: $_result',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
