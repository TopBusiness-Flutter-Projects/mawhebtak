import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';

import 'package:photo_view/photo_view.dart';

class ImageFileView extends StatefulWidget {
  ImageFileView({required this.image, this.isNetwork = false, super.key});
  String? image;
  bool isNetwork;
  @override
  State<ImageFileView> createState() => _ImageFileViewState();
}

class _ImageFileViewState extends State<ImageFileView> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('some key here file'),
      direction: DismissDirection.down,
      background: Container(),
      onDismissed: (_) => Navigator.pop(context),
      child: BlocBuilder<FeedsCubit, FeedsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () {
              Navigator.pop(context);
              return Future.value(false);
            },
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                          )),
                    ]),
                body: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 32,
                    vertical: MediaQuery.of(context).size.width / 44,
                  ),
                  child: widget.image == null
                      ? PhotoView(
                          imageProvider:
                              const AssetImage('assets/images/app_icon.png'),
                          backgroundDecoration: const BoxDecoration(),
                          // enableRotation: true,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 1.8,
                          initialScale: PhotoViewComputedScale.contained,
                          basePosition: Alignment.center,
                        )
                      : widget.isNetwork
                          ? PhotoView(
                              imageProvider: NetworkImage(widget.image ?? ''),
                              backgroundDecoration: const BoxDecoration(),
                              // enableRotation: true,
                              minScale: PhotoViewComputedScale.contained * 0.8,
                              maxScale: PhotoViewComputedScale.covered * 1.8,
                              initialScale: PhotoViewComputedScale.contained,
                              basePosition: Alignment.center,
                            )
                          : PhotoView(
                              imageProvider: FileImage(
                                  File(widget.image ?? '') ?? File('')),
                              backgroundDecoration: const BoxDecoration(),
                              // enableRotation: true,
                              minScale: PhotoViewComputedScale.contained * 0.8,
                              maxScale: PhotoViewComputedScale.covered * 1.8,
                              initialScale: PhotoViewComputedScale.contained,
                              basePosition: Alignment.center,
                            ),
                )),
          );
        },
      ),
    );
  }
}
