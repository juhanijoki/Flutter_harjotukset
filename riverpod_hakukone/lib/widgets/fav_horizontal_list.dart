import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_hakukone/providers.dart';

class FavsHorizonList extends ConsumerWidget {
  const FavsHorizonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserFavs = ref.watch(browserFavouriteProvider);
    final favsCount = ref.watch(favsCountProvider);

    return Container(
      margin: const EdgeInsets.all(6),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: favsCount,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: InkWell(
                onTap: () {
                  // Siirtyy urliin
                  ref
                      .read(controllerProvider.notifier)
                      .goToPage(url: browserFavs[index]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        browserFavs[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // Poistaa suosikeista'
                          ref
                              .read(browserFavouriteProvider.notifier)
                              .removeFromFavorites(browserFavs[index]);
                        },
                        icon: const Icon(Icons.close, color: Colors.red)),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
