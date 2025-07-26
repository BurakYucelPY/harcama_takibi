import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EtkilesimliPastaGrafigi extends StatefulWidget {
  final Map<String, double> kategoriVerisi;
  final Map<String, IconData> kategoriIkonlari;

  const EtkilesimliPastaGrafigi({
    super.key,
    required this.kategoriVerisi,
    required this.kategoriIkonlari,
  });

  @override
  State<EtkilesimliPastaGrafigi> createState() =>
      _EtkilesimliPastaGrafigiState();
}

class _EtkilesimliPastaGrafigiState extends State<EtkilesimliPastaGrafigi> {
  int touchedIndex = -1;

  final List<Color> renkler = [
    Colors.blue.shade400,
    Colors.red.shade400,
    Colors.yellow.shade700,
    Colors.purple.shade400,
    Colors.orange.shade500,
    Colors.green.shade400,
    Colors.pink.shade300,
    Colors.teal.shade400,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final entries = widget.kategoriVerisi.entries.toList();

    return List.generate(entries.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final anahtar = entries[i].key;
      final deger = entries[i].value;
      final toplamTutar =
          widget.kategoriVerisi.values.fold(0.0, (a, b) => a + b);
      final yuzde = (deger / toplamTutar * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: renkler[i % renkler.length],
        value: deger,
        title: '$yuzde%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          widget.kategoriIkonlari[anahtar]!,
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.ikon, {
    required this.size,
    required this.borderColor,
  });
  final IconData ikon;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Icon(ikon, color: borderColor, size: size * 0.6),
      ),
    );
  }
}

class EtkilesimliCubukGrafigi extends StatelessWidget {
  final List<Map<String, dynamic>> veri;
  final Map<String, IconData> ikonlar;

  const EtkilesimliCubukGrafigi({
    super.key,
    required this.veri,
    required this.ikonlar,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < veri.length) {
                    return Text(veri[value.toInt()]["kategori"]);
                  } else {
                    return const Text('');
                  }
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barGroups: veri.asMap().entries.map((e) {
            final index = e.key;
            final item = e.value;
            final tutar = item["tutar"] ?? 0.0;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: tutar.toDouble(),
                  width: 18,
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
