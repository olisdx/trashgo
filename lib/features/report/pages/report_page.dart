import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashgo/features/report/widgets/form_dialog.dart';

import '../../../common/action_dialog.dart';
import '../../../common/camera_settings.dart';
import '../../../common/mediaquery.dart';
import '../../../common/primary_button.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_font.dart';
import '../cubit/report_cubit.dart';

@RoutePage()
class ReportPage extends StatefulWidget {
  const ReportPage({
    super.key,
    required this.currentLoc,
    required this.onCallback,
  });

  final LatLng currentLoc;
  final VoidCallback onCallback;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  CameraPosition _cameraPosition = CameraPosition.back;

  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _initializeCameraController();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController.dispose();
    super.dispose();
  }

  void _initializeCameraController() {
    _cameraController = CameraSettings.defaults(position: _cameraPosition);
    _initializeControllerFuture = _cameraController.initialize();
  }

  void _toggleCamera() {
    setState(() {
      _cameraPosition =
          (_cameraPosition == CameraPosition.front)
              ? CameraPosition.back
              : CameraPosition.front;

      _cameraController.dispose();
      _initializeCameraController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportCubit(),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        width: MQ.w(context),
                        height: MQ.h(context),
                        child: CameraPreview(
                          _cameraController,
                          child: BlocConsumer<ReportCubit, ReportState>(
                            listener: (context, state) {
                              if (state is ReportFailure) {
                                ActionDialog.failed(
                                  context,
                                  title: "Failed",
                                  desc: "An error occurred, please try again.",
                                  onTap: () => Navigator.pop(context),
                                );
                              }
                              if (state is ReportLoaded) {
                                ActionDialog.success(
                                  context,
                                  title: "Success",
                                  desc: "Report trash progress",
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    widget.onCallback();
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 72),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: InkWell(
                                        onTap: () {
                                          if (snapshot.connectionState !=
                                              ConnectionState.done) {
                                            return;
                                          }

                                          if (_titleCtrl.text.isEmpty ||
                                              _descCtrl.text.isEmpty) {
                                            FormDialog.show(
                                              context,
                                              title: _titleCtrl,
                                              desc: _descCtrl,
                                            );

                                            return;
                                          }

                                          context.read<ReportCubit>().postData(
                                            location: widget.currentLoc,
                                            cameraController: _cameraController,
                                            description: _descCtrl.text,
                                            title: _titleCtrl.text,
                                          );
                                        },
                                        child: Container(
                                          width: 72,
                                          height: 72,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.deepPurple,
                                              width: 4,
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child:
                                                (state is ReportLoading)
                                                    ? SpinKitFadingCircle(
                                                      color: AppColors.black,
                                                    )
                                                    : SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 24,
                                      bottom: 48,
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          if (state is ReportLoading) return;
                                          _toggleCamera();
                                        },
                                        child: Icon(
                                          TablerIcons.camera_rotate,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 12,
                          children: [
                            Text("Failed", style: Typograph.label14),
                            PrimaryButton(
                              width: MQ.w(context) * 0.5,
                              text: "An error occurred, please try again.",
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.black),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(TablerIcons.chevron_left),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
