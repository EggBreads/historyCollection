// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  // final AraeModel areaRegisterForm;

  const CameraScreen({
    Key? key,
    // required this.areaRegisterForm,
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late CameraController _cameraController;

  late List<CameraDescription> camearaList;

  bool _hasPermission = false;

  @override
  initState() {
    super.initState();

    initPermission();
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (cameraDenied || micDenied) {
      return;
    }

    _hasPermission = true;

    await _setCameara();

    setState(() {});
  }

  Future<void> _setCameara() async {
    camearaList = await availableCameras();

    if (camearaList.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      camearaList[0],
      ResolutionPreset.medium,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _cameraController.initialize();

    // await
  }

  Future<void> _onTakePicture() async {
    final picture = await _cameraController.takePicture();

    if (!mounted) return;
    context.pop(picture.path);
  }

  void _onTapBack() {
    context.pop();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // if (!_noCamera) {
    //   return;
    // }

    if (!_hasPermission) {
      return;
    }

    if (!_cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await _setCameara();
      setState(() {});
    }
  }

  double getScaleSize(Size sized) {
    double aspectRatio = 1.0;
    if (_cameraController.value.isInitialized) {
      aspectRatio = _cameraController.value.aspectRatio;
    }
    final scale = 1 / (aspectRatio * sized.aspectRatio);

    return scale;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
          ),
          onPressed: _onTapBack,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: sized.width,
          // height: sized.height,
          child: !_hasPermission || !_cameraController.value.isInitialized
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(_cameraController),
                    // Transform.scale(
                    //   scale: getScaleSize(sized),
                    //   alignment: Alignment.topCenter,
                    //   child: CameraPreview(_cameraController),
                    // ),
                    Positioned(
                      bottom: Sizes.size30,
                      child: Container(
                        width: Sizes.size60,
                        height: Sizes.size60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: Sizes.size5,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.indigo.shade100,
                        ),
                        child: IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.cameraRetro,
                            // size: Sizes.size,
                          ),
                          onPressed: _onTakePicture,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
