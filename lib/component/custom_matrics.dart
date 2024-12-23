import 'package:flutter/material.dart';

class MatrixComponent extends StatelessWidget {
  final int rows;
  final int columns;
  final List<List<String>> data;
  final double cellWidth;
  final double cellHeight;
  final Color borderColor;

  const MatrixComponent({
    super.key,
    required this.rows,
    required this.columns,
    required this.data,
    this.cellWidth = 80,
    this.cellHeight = 40,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: borderColor),
      children: List.generate(rows, (rowIndex) {
        return TableRow(
          children: List.generate(columns, (colIndex) {
            return Container(
              width: cellWidth,
              height: cellHeight,
              alignment: Alignment.center,
              child: Text(
                data[rowIndex][colIndex],
                style: const TextStyle(fontSize: 14),
              ),
            );
          }),
        );
      }),
    );
  }
}
