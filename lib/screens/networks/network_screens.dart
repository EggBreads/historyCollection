import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:historycollection/Constants/sizes.dart';

class NetworkScreens extends StatefulWidget {
  const NetworkScreens({super.key});

  @override
  State<NetworkScreens> createState() => _NetworkScreensState();
}

class _NetworkScreensState extends State<NetworkScreens>
    with TickerProviderStateMixin {
  late TransformationController _transformationController;
  late Size size;
  late final AnimationController _animationCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  late final SugiyamaConfiguration _sugiyamaConfiguration;

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);
    // final node2 = Node.Id(2);
    // final node3 = Node.Id(3);
    // final node4 = Node.Id(4);
    // final node5 = Node.Id(5);
    // final node6 = Node.Id(6);
    // final node8 = Node.Id(7);
    // final node7 = Node.Id(8);
    // final node9 = Node.Id(9);
    // final node10 = Node.Id(10);
    // final node11 = Node.Id(11);
    // final node12 = Node.Id(12);
    // final node13 = Node.Id(13);
    // final node14 = Node.Id(14);
    // final node15 = Node.Id(15);
    // final node16 = Node.Id(16);
    // final node17 = Node.Id(17);
    // final node18 = Node.Id(18);
    // final node19 = Node.Id(19);
    // final node20 = Node.Id(20);
    // final node21 = Node.Id(21);
    // final node22 = Node.Id(22);
    // final node23 = Node.Id(23);

    graph.addNode(node1);
    // graph.addEdge(node1, node13, paint: Paint()..color = Colors.red);
    // graph.addEdge(node1, node21);
    // graph.addEdge(node1, node4);
    // graph.addEdge(node1, node3);
    // graph.addEdge(node2, node3);
    // graph.addEdge(node2, node20);
    // graph.addEdge(node3, node4);
    // graph.addEdge(node3, node5);
    // graph.addEdge(node3, node23);
    // graph.addEdge(node4, node6);
    // graph.addEdge(node5, node7);
    // graph.addEdge(node6, node8);
    // graph.addEdge(node6, node16);
    // graph.addEdge(node6, node23);
    // graph.addEdge(node7, node9);
    // graph.addEdge(node8, node10);
    // graph.addEdge(node8, node11);
    // graph.addEdge(node9, node12);
    // graph.addEdge(node10, node13);
    // graph.addEdge(node10, node14);
    // graph.addEdge(node10, node15);
    // graph.addEdge(node11, node15);
    // graph.addEdge(node11, node16);
    // graph.addEdge(node12, node20);
    // graph.addEdge(node13, node17);
    // graph.addEdge(node14, node17);
    // graph.addEdge(node14, node18);
    // graph.addEdge(node16, node18);
    // graph.addEdge(node16, node19);
    // graph.addEdge(node16, node20);
    // graph.addEdge(node18, node21);
    // graph.addEdge(node19, node22);
    // graph.addEdge(node21, node23);
    // graph.addEdge(node22, node23);
    // graph.addEdge(node1, node22);
    // graph.addEdge(node7, node8);

    _transformationController = TransformationController();
    _transformationController.value = Matrix4.identity();
    // _transformationController.value =
    //     composeMatrixFromOffsets(); //Matrix4.identity();

    // builder
    //   ..siblingSeparation = (100)
    //   ..levelSeparation = (150)
    //   ..subtreeSeparation = (150)
    //   ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    _sugiyamaConfiguration = SugiyamaConfiguration()
      ..nodeSeparation = (15)
      ..levelSeparation = (15)
      ..orientation;

    _animationCtrl.addListener(_animationTick);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _transformationController.dispose();
    _animationCtrl.dispose();
    super.dispose();
  }

  final Graph graph = Graph();

  // SugiyamaConfiguration builder = SugiyamaConfiguration()
  //   ..orientation = 4
  //   // ..coordinateAssignment = CoordinateAssignment.DownRight
  //   ..bendPointShape = CurvedBendPointShape(curveLength: 20);

  Random r = Random();

  // Widget rectangleWidget(int a) {
  //   return InkWell(
  //     onTap: () {
  //       print('clicked');
  //     },
  //     child: Container(
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.blue,
  //               spreadRadius: 1,
  //             ),
  //           ],
  //         ),
  //         child: Text('Node $a')),
  //   );
  // }

  // final Graph graph = Graph()..isTree = true ;
  // BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  Widget rectangleWidget(int? a) {
    return Container(
      // clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(
        Sizes.size20,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(10),
        //   topRight: Radius.circular(10),
        // ),
        boxShadow: [
          BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
        ],
      ),
      child: Text(
        'Node $a',
        style: const TextStyle(
          fontSize: Sizes.size16,
        ),
      ),
    );
  }

  Matrix4 composeMatrix({
    double scale = 1,
    double rotation = 0,
    double translateX = 0,
    double translateY = 0,
    double anchorX = 0,
    double anchorY = 0,
  }) {
    final double c = cos(rotation) * scale;
    final double s = sin(rotation) * scale;
    final double dx = translateX - c * anchorX + s * anchorY;
    final double dy = translateY - s * anchorX - c * anchorY;

    //  ..[0]  = c       # x scale
    //  ..[1]  = s       # y skew
    //  ..[4]  = -s      # x skew
    //  ..[5]  = c       # y scale
    //  ..[10] = 1       # diagonal "one"
    //  ..[12] = dx      # x translation
    //  ..[13] = dy      # y translation
    //  ..[15] = 1       # diagonal "one"
    return Matrix4(c, s, 0, 0, -s, c, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }

  Matrix4 composeMatrixFromOffsets({
    double scale = 1,
    double rotation = 0,
    Offset translate = Offset.zero,
    Offset anchor = Offset.zero,
  }) =>
      composeMatrix(
        scale: scale,
        rotation: rotation,
        translateX: translate.dx,
        translateY: translate.dy,
        anchorX: anchor.dx,
        anchorY: anchor.dy,
      );

  void _animationTick() {
    // print("Test2 => 123 ${size.width}");
    // final center = size.center(Offset.zero);
    // print("Test2 => 123 $center");
    // final anchor = _transformationController.toScene(center);
    _transformationController.value = composeMatrixFromOffsets(
      scale: lerpDouble(1, 2, _animationCtrl.value)!,
      anchor: Offset.zero,
      translate: Offset.zero,
    );

    // _transformationController.value = Matrix4.zero();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "너와나의연결고리",
          ),
        ),
        body: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      panEnabled: false,
                      constrained: false,
                      minScale: .1,
                      maxScale: 2,
                      // boundaryMargin: const EdgeInsets.all(double.infinity),
                      scaleEnabled: true,
                      onInteractionEnd: (s) {
                        print("Test1 ${_transformationController.value}");
                      },
                      child: GraphView(
                        graph: graph,
                        algorithm: SugiyamaAlgorithm(_sugiyamaConfiguration),
                        paint: Paint()
                          ..color = Colors.green
                          ..strokeWidth = 1
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) {
                          // I can decide what widget should be shown here based on the id
                          var a = node.key!.value as int?;
                          return rectangleWidget(a);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     // Wrap(
            //     //   children: [
            //     //     SizedBox(
            //     //       width: 100,
            //     //       child: TextFormField(
            //     //         initialValue: builder.nodeSeparation.toString(),
            //     //         decoration:
            //     //             const InputDecoration(labelText: 'Node Separation'),
            //     //         onChanged: (text) {
            //     //           builder.nodeSeparation = int.tryParse(text) ?? 100;
            //     //           setState(() {});
            //     //         },
            //     //       ),
            //     //     ),
            //     //     SizedBox(
            //     //       width: 100,
            //     //       child: TextFormField(
            //     //         initialValue: builder.levelSeparation.toString(),
            //     //         decoration: const InputDecoration(
            //     //             labelText: 'Level Separation'),
            //     //         onChanged: (text) {
            //     //           builder.levelSeparation = int.tryParse(text) ?? 100;
            //     //           setState(() {});
            //     //         },
            //     //       ),
            //     //     ),
            //     //     SizedBox(
            //     //       width: 100,
            //     //       child: TextFormField(
            //     //         initialValue: builder.orientation.toString(),
            //     //         decoration:
            //     //             const InputDecoration(labelText: 'Orientation'),
            //     //         onChanged: (text) {
            //     //           builder.orientation = int.tryParse(text) ?? 100;
            //     //           setState(() {});
            //     //         },
            //     //       ),
            //     //     ),
            //     //     SizedBox(
            //     //       width: 150,
            //     //       // height: 70,
            //     //       child: Column(
            //     //         children: [
            //     //           const Text('Alignment'),
            //     //           DropdownButton<CoordinateAssignment>(
            //     //             value: builder.coordinateAssignment,
            //     //             items: CoordinateAssignment.values
            //     //                 .map((coordinateAssignment) {
            //     //               return DropdownMenuItem<CoordinateAssignment>(
            //     //                 value: coordinateAssignment,
            //     //                 child: Text(coordinateAssignment.name),
            //     //               );
            //     //             }).toList(),
            //     //             onChanged: (value) {
            //     //               setState(() {
            //     //                 builder.coordinateAssignment = value!;
            //     //               });
            //     //             },
            //     //           ),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //     ElevatedButton(
            //     //       onPressed: () {
            //     //         final node12 = Node.Id(r.nextInt(100));
            //     //         var edge = graph
            //     //             .getNodeAtPosition(r.nextInt(graph.nodeCount()));
            //     //         print(edge);
            //     //         graph.addEdge(edge, node12);
            //     //         setState(() {});
            //     //       },
            //     //       child: const Text('Add'),
            //     //     )
            //     //   ],
            //     // ),
            //     // LayoutBuilder(
            //     //   builder: (ctx, constrainst) {
            //     //     size = constrainst.biggest;
            //     //     return Expanded(
            //     //       child: InteractiveViewer(
            //     //         transformationController: _transformationController,
            //     //         constrained: false,
            //     //         boundaryMargin: const EdgeInsets.all(100),
            //     //         scaleEnabled: true,
            //     //         minScale: .1,
            //     //         maxScale: 1,
            //     //         onInteractionEnd: (s) {
            //     //           print("Test1 ${_transformationController.value}");
            //     //         },
            //     //         child: GraphView(
            //     //           graph: graph,
            //     //           algorithm: SugiyamaAlgorithm(builder),
            //     //           paint: Paint()
            //     //             ..color = Colors.green
            //     //             ..strokeWidth = 1
            //     //             ..style = PaintingStyle.stroke,
            //     //           builder: (Node node) {
            //     //             // I can decide what widget should be shown here based on the id
            //     //             var a = node.key!.value as int?;
            //     //             return rectangleWidget(a);
            //     //           },
            //     //         ),
            //     //       ),
            //     //     );
            //     //   },
            //     // ),
            //     Expanded(
            //       child: InteractiveViewer(
            //         transformationController: _transformationController,
            //         panEnabled: false,
            //         constrained: false,
            //         minScale: .1,
            //         maxScale: 2,
            //         boundaryMargin: const EdgeInsets.all(double.infinity),
            //         scaleEnabled: true,
            //         onInteractionEnd: (s) {
            //           print("Test1 ${_transformationController.value}");
            //         },
            //         child: Expanded(
            //           child: GraphView(
            //             graph: graph,
            //             algorithm: SugiyamaAlgorithm(_sugiyamaConfiguration),
            //             paint: Paint()
            //               ..color = Colors.green
            //               ..strokeWidth = 1
            //               ..style = PaintingStyle.stroke,
            //             builder: (Node node) {
            //               // I can decide what widget should be shown here based on the id
            //               var a = node.key!.value as int?;
            //               return rectangleWidget(a);
            //             },
            //           ),
            //         ),
            //         // child: OverflowBox(
            //         //   alignment: Alignment.center,
            //         //   minWidth: 0.0,
            //         //   minHeight: 0.0,
            //         //   maxWidth: double.infinity,
            //         //   maxHeight: double.infinity,
            //         //   child: GraphView(
            //         //     graph: graph,
            //         //     algorithm: SugiyamaAlgorithm(builder),
            //         //     paint: Paint()
            //         //       ..color = Colors.green
            //         //       ..strokeWidth = 1
            //         //       ..style = PaintingStyle.stroke,
            //         //     builder: (Node node) {
            //         //       // I can decide what widget should be shown here based on the id
            //         //       var a = node.key!.value as int?;
            //         //       return rectangleWidget(a);
            //         //     },
            //         //   ),
            //         // ),
            //       ),
            //     ),
            //   ],
            // ),
            // Positioned(
            //   bottom: Sizes.size30,
            //   right: Sizes.size1,
            //   child: Column(
            //     children: [
            //       ElevatedButton(
            //         onPressed: _animationCtrl.forward,
            //         child: const FaIcon(
            //           FontAwesomeIcons.circlePlus,
            //         ),
            //       ),
            //       ElevatedButton(
            //         onPressed: _animationCtrl.reverse,
            //         child: const FaIcon(
            //           FontAwesomeIcons.circleMinus,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
