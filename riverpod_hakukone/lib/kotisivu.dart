import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_hakukone/providers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'widgets/fav_horizontal_list.dart';

class KotiSivu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containsFav = ref.watch(containsFavProvider);

    return Scaffold(
        appBar: AppBar(
          actions: [
            MaterialButton(
              onPressed: () {
                final String currentUrl = ref.read(currentUrlProvider);
                // final bool containsFav = ref.read(containsFavProvider);
                if (containsFav) {
                  ref
                      .read(browserFavouriteProvider.notifier)
                      .removeFromFavorites(currentUrl);
                } else {
                  ref
                      .read(browserFavouriteProvider.notifier)
                      .addToFavourites(currentUrl);
                }
              },
              child: Text(containsFav ? 'Remove from favs' : 'Add to favs'),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: ref.read(textEditingControllerProvider),
                    onChanged: (value) {
                      ref.read(currentUrlProvider.notifier).setLink(value);
                    },
                  )),
                  IconButton(
                    onPressed: () {
                      final textEditingController =
                          ref.read(textEditingControllerProvider);
                      // final String currentUrl = ref.read(currentUrlProvider);

                      FocusScope.of(context).unfocus();
                      ref
                          .read(controllerProvider.notifier)
                          .goToPage(url: textEditingController.text);

                      textEditingController.clear();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            ref.watch(favsCountProvider) == 0
                ? const SizedBox()
                : const FavsHorizonList(),
            Expanded(
              child: WebView(
                onWebViewCreated: (webViewController) {
                  ref
                      .read(controllerProvider.notifier)
                      .setController(webViewController);
                },
                onWebResourceError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Error, can not go to ${error.failingUrl}')));
                },
                onPageStarted: (link) =>
                    ref.read(currentUrlProvider.notifier).setLink(link),
                initialUrl: ref.read(currentUrlProvider),
              ),
            ),
          ],
        ));
  }
}
