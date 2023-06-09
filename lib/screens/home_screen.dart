import 'package:flutter/material.dart';
import 'package:parksearch/screens/components/map_alert.dart';
import 'package:parksearch/screens/components/park_dialog.dart';
import 'package:provider/provider.dart';

import '../viewmodels/park_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parkViewModel = context.read<ParkViewModel>();

    Future(parkViewModel.getParkInfo);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MapAlert(),
                      //   ),
                      // );
                      //
                      //
                      //

                      ParkDialog(
                        context: context,
                        widget: MapAlert(),
                      );
                    },
                    icon: const Icon(Icons.map),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<ParkViewModel>(
                builder: (context, model, child) {
                  return model.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: model.parks.length,
                          itemBuilder: (context, index) {
                            final ll = [
                              model.parks[index].latitude,
                              model.parks[index].longitude,
                            ];

                            return Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.4),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: Text(
                                      model.parks[index].id.toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(model.parks[index].name),
                                        Row(
                                          children: [
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(ll.join(' / ')),
                                                  Text(model
                                                      .parks[index].address),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
