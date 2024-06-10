import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VangtiChai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyBreakdownPage(),
    );
  }
}

class CurrencyBreakdownPage extends StatefulWidget {
  @override
  _CurrencyBreakdownPageState createState() => _CurrencyBreakdownPageState();
}

class _CurrencyBreakdownPageState extends State<CurrencyBreakdownPage> {
  String _amount = '';
  Map<String, int> _breakdown = {
    '500': 0,
    '100': 0,
    '50': 0,
    '20': 0,
    '10': 0,
    '5': 0,
    '2': 0,
    '1': 0,
  };

  void _calculateBreakdown() {
    int amount = int.tryParse(_amount) ?? 0;
    _breakdown['500'] = amount ~/ 500;
    amount %= 500;
    _breakdown['100'] = amount ~/ 100;
    amount %= 100;
    _breakdown['50'] = amount ~/ 50;
    amount %= 50;
    _breakdown['20'] = amount ~/ 20;
    amount %= 20;
    _breakdown['10'] = amount ~/ 10;
    amount %= 10;
    _breakdown['5'] = amount ~/ 5;
    amount %= 5;
    _breakdown['2'] = amount ~/ 2;
    amount %= 2;
    _breakdown['1'] = amount ~/ 1;
  }

  void _onKeyPress(String key) {
    setState(() {
      if (key == 'C') {
        _amount = '';
      } else {
        _amount += key;
      }
      _calculateBreakdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VangtiChai'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: orientation == Orientation.portrait
                ? _buildPortraitLayout()
                : _buildLandscapeLayout(),
          );
        },
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDisplay(),
        SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              _buildBreakdown(),
              _buildKeypad(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDisplay(),
        SizedBox(height: 30),
        Expanded(
          child: Row(
            children: [
              _buildBreakdown(),
              _buildKeypad(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDisplay() {
    return Text(
      'Taka: $_amount',
      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBreakdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreakdownItem('500', _breakdown['500']!),
          _buildBreakdownItem('100', _breakdown['100']!),
          _buildBreakdownItem('50', _breakdown['50']!),
          _buildBreakdownItem('20', _breakdown['20']!),
          _buildBreakdownItem('10', _breakdown['10']!),
          _buildBreakdownItem('5', _breakdown['5']!),
          _buildBreakdownItem('2', _breakdown['2']!),
          _buildBreakdownItem('1', _breakdown['1']!),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, int count) {
    return Text(
      '$label Taka: $count',
      style: TextStyle(fontSize: 30),
    );
  }

  Widget _buildKeypad() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          _buildKeypadButton('1'),
          _buildKeypadButton('2'),
          _buildKeypadButton('3'),
          _buildKeypadButton('4'),
          _buildKeypadButton('5'),
          _buildKeypadButton('6'),
          _buildKeypadButton('7'),
          _buildKeypadButton('8'),
          _buildKeypadButton('9'),
          _buildKeypadButton('0'),
          _buildKeypadButton('C'),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(String label) {
    return ElevatedButton(
      onPressed: () => _onKeyPress(label),
      child: Text(label, style: TextStyle(fontSize: 25)),
    );
  }
}
