// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../extensions/extensions.dart';
import '../../models/park.dart';
import '../../viewmodels/park_view_model.dart';

class MapAlert extends StatelessWidget {
  MapAlert({super.key});

  Map<String, double> boundsLatLngMap = {};

  late double boundsInner;

  double boundsLatLngDiffSmall = 0;

  List<Marker> markerList = [];

  ///
  @override
  Widget build(BuildContext context) {
    final parkViewModel = context.read<ParkViewModel>();

    Future(parkViewModel.getParkInfo);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ParkViewModel>(
                builder: (context, model, child) {
                  if (model.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  makeBounds(data: model.parks);

                  makeMarker(data: model.parks);

                  //---------------------------------------------
                  return Expanded(
                    child: FlutterMap(
                      options: MapOptions(
                        bounds: LatLngBounds(
                          LatLng(
                            boundsLatLngMap['minLat']! - boundsInner,
                            boundsLatLngMap['minLng']! - boundsInner,
                          ),
                          LatLng(
                            boundsLatLngMap['maxLat']! + boundsInner,
                            boundsLatLngMap['maxLng']! + boundsInner,
                          ),
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(markers: markerList),
                      ],
                    ),
                  );
                  //---------------------------------------------
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  void makeBounds({required List<Park> data}) {
    final latList = <double>[];
    final lngList = <double>[];

    data.forEach((element) {
      latList.add(element.latitude.toDouble());
      lngList.add(element.longitude.toDouble());
    });

    final minLat = latList.reduce(min);
    final maxLat = latList.reduce(max);
    final minLng = lngList.reduce(min);
    final maxLng = lngList.reduce(max);

    final latDiff = maxLat - minLat;
    final lngDiff = maxLng - minLng;
    boundsLatLngDiffSmall = (latDiff < lngDiff) ? latDiff : lngDiff;
    boundsInner = boundsLatLngDiffSmall * 0.2;

    boundsLatLngMap = {
      'minLat': minLat,
      'maxLat': maxLat,
      'minLng': minLng,
      'maxLng': maxLng,
    };
  }

  ///
  void makeMarker({required List<Park> data}) {
    data.forEach((element) {
      markerList.add(
        Marker(
          point: LatLng(
            element.latitude.toDouble(),
            element.longitude.toDouble(),
          ),
          builder: (context) {
            return CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.6),
              child: Text(element.id.toString()),
            );
          },
        ),
      );
    });
  }
}
