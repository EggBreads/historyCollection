import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:zoom_widget/zoom_widget.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Zoom(
      initTotalZoomOut: true,
      child: const Center(
        child: FlutterLogo(
          size: 1000,
        ),
      ),
    );
    // return Scaffold(
    //     appBar: AppBar(),
    //     body: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         Wrap(
    //           children: [
    //             SizedBox(
    //               width: 100,
    //               child: TextFormField(
    //                 initialValue: builder.nodeSeparation.toString(),
    //                 decoration:
    //                     const InputDecoration(labelText: 'Node Separation'),
    //                 onChanged: (text) {
    //                   builder.nodeSeparation = int.tryParse(text) ?? 100;
    //                   setState(() {});
    //                 },
    //               ),
    //             ),
    //             SizedBox(
    //               width: 100,
    //               child: TextFormField(
    //                 initialValue: builder.levelSeparation.toString(),
    //                 decoration:
    //                     const InputDecoration(labelText: 'Level Separation'),
    //                 onChanged: (text) {
    //                   builder.levelSeparation = int.tryParse(text) ?? 100;
    //                   setState(() {});
    //                 },
    //               ),
    //             ),
    //             SizedBox(
    //               width: 150,
    //               child: TextFormField(
    //                 initialValue: builder.orientation.toString(),
    //                 decoration: const InputDecoration(labelText: 'Orientation'),
    //                 onChanged: (text) {
    //                   builder.orientation = int.tryParse(text) ?? 100;
    //                   setState(() {});
    //                 },
    //               ),
    //             ),
    //             SizedBox(
    //               width: 150,
    //               child: Column(
    //                 children: [
    //                   const Text('Alignment'),
    //                   DropdownButton<CoordinateAssignment>(
    //                     value: builder.coordinateAssignment,
    //                     items: CoordinateAssignment.values
    //                         .map((coordinateAssignment) {
    //                       return DropdownMenuItem<CoordinateAssignment>(
    //                         value: coordinateAssignment,
    //                         child: Text(coordinateAssignment.name),
    //                       );
    //                     }).toList(),
    //                     onChanged: (value) {
    //                       setState(() {
    //                         builder.coordinateAssignment = value!;
    //                       });
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 final node12 = Node.Id(r.nextInt(100));
    //                 var edge =
    //                     graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
    //                 print(edge);
    //                 graph.addEdge(edge, node12);
    //                 setState(() {});
    //               },
    //               child: const Text('Add'),
    //             )
    //           ],
    //         ),
    //         Zoom(
    //           initTotalZoomOut: true,
    //           child: const Center(
    //             child: FlutterLogo(
    //               size: 1000,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ));
  }

  Random r = Random();

  Widget rectangleWidget(int? a) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text('Node $a'));
  }

  final Graph graph = Graph();

  SugiyamaConfiguration builder = SugiyamaConfiguration()
    ..bendPointShape = CurvedBendPointShape(curveLength: 20);

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);
    final node13 = Node.Id(13);
    final node14 = Node.Id(14);
    final node15 = Node.Id(15);
    final node16 = Node.Id(16);
    final node17 = Node.Id(17);
    final node18 = Node.Id(18);
    final node19 = Node.Id(19);
    final node20 = Node.Id(20);
    final node21 = Node.Id(21);
    final node22 = Node.Id(22);
    final node23 = Node.Id(23);

    graph.addEdge(node1, node13, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node21);
    graph.addEdge(node1, node4);
    graph.addEdge(node1, node3);
    graph.addEdge(node2, node3);
    graph.addEdge(node2, node20);
    graph.addEdge(node3, node4);
    graph.addEdge(node3, node5);
    graph.addEdge(node3, node23);
    graph.addEdge(node4, node6);
    graph.addEdge(node5, node7);
    graph.addEdge(node6, node8);
    graph.addEdge(node6, node16);
    graph.addEdge(node6, node23);
    graph.addEdge(node7, node9);
    graph.addEdge(node8, node10);
    graph.addEdge(node8, node11);
    graph.addEdge(node9, node12);
    graph.addEdge(node10, node13);
    graph.addEdge(node10, node14);
    graph.addEdge(node10, node15);
    graph.addEdge(node11, node15);
    graph.addEdge(node11, node16);
    graph.addEdge(node12, node20);
    graph.addEdge(node13, node17);
    graph.addEdge(node14, node17);
    graph.addEdge(node14, node18);
    graph.addEdge(node16, node18);
    graph.addEdge(node16, node19);
    graph.addEdge(node16, node20);
    graph.addEdge(node18, node21);
    graph.addEdge(node19, node22);
    graph.addEdge(node21, node23);
    graph.addEdge(node22, node23);
    graph.addEdge(node1, node22);
    graph.addEdge(node7, node8);

    builder
      ..nodeSeparation = (15)
      ..levelSeparation = (15)
      ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
  }
}