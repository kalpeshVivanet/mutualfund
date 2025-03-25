import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MutualFundPerformanceChart extends StatefulWidget {
  final Map<String, List<MapEntry<String, double>>> performanceData;

  const MutualFundPerformanceChart({
    Key? key, 
    required this.performanceData
  }) : super(key: key);

  @override
  _MutualFundPerformanceChartState createState() => _MutualFundPerformanceChartState();
}

class _MutualFundPerformanceChartState extends State<MutualFundPerformanceChart> {
  late String _selectedRange;
  late List<MapEntry<String, double>> _currentRangeData;

  @override
  void initState() {
    super.initState();
    _selectedRange = '3M';  // Default to 3 months view
    _updateCurrentRangeData();
  }

  void _updateCurrentRangeData() {
    _currentRangeData = widget.performanceData[_selectedRange] ?? [];
  }

  List<FlSpot> _getChartData() {
    return _currentRangeData.asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.value))
        .toList();
  }

  List<String> _getSmartLabels() {
    final data = _currentRangeData;
    
    // If 5 or fewer data points, return all labels
    if (data.length <= 5) {
      return data.map((e) => e.key).toList();
    }

    // For more than 5 data points, use a smarter selection strategy
    final totalItems = data.length;
    final desiredLabelCount = 5;
    
    // Calculate step size to distribute labels
    final step = (totalItems - 1) ~/ (desiredLabelCount - 1);
    
    return List.generate(desiredLabelCount, (index) {
      // Ensure we don't go out of bounds
      final position = index == desiredLabelCount - 1 
        ? totalItems - 1 
        : index * step;
      return data[position].key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRangeSelector(),
        const SizedBox(height: 16),
        _buildLineChart(),
        const SizedBox(height: 16),
        _buildPerformanceStats(),
      ],
    );
  }

  Widget _buildRangeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.performanceData.keys
            .map((range) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(range),
                    selected: _selectedRange == range,
                    onSelected: (selected) {
                      setState(() {
                        _selectedRange = range;
                        _updateCurrentRangeData();
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLineChart() {
    if (_currentRangeData.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final smartLabels = _getSmartLabels();

    // Calculate min and max Y values with a small buffer
    final yValues = _currentRangeData.map((e) => e.value);
    final minY = yValues.reduce((a, b) => a < b ? a : b) * 0.95;
    final maxY = yValues.reduce((a, b) => a > b ? a : b) * 1.05;

    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: _currentRangeData.length.toDouble() - 1,
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            verticalInterval: _currentRangeData.length > 5 
              ? _currentRangeData.length / 5 
              : 1,
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: _currentRangeData.length > 5 
                  ? (_currentRangeData.length - 1) / (smartLabels.length - 1)
                  : 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < smartLabels.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        smartLabels[index],
                        style: const TextStyle(
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (maxY - minY) / 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 10),
                  );
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black12),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: _getChartData(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.blue,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceStats() {
    if (_currentRangeData.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstNav = _currentRangeData.first.value;
    final lastNav = _currentRangeData.last.value;
    final percentageChange = ((lastNav - firstNav) / firstNav) * 100;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Performance ($_selectedRange)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(
                  title: 'Total Return',
                  value: '${percentageChange.toStringAsFixed(2)}%',
                  color: percentageChange >= 0 ? Colors.green : Colors.red,
                ),
                _buildStatColumn(
                  title: 'Current NAV',
                  value: lastNav.toStringAsFixed(2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required String title, 
    required String value, 
    Color? color
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(
            color: color ?? Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}