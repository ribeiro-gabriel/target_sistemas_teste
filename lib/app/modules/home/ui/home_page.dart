import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:target_sistemas_teste/app/modules/home/stores/home_page_store.dart';

class HomePage extends StatefulWidget {
  final HomePageStore store;

  const HomePage({super.key, required this.store});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    debugPrint('HomePage initstate');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    runInAction(() {
      debugPrint('build HomePage');
      widget.store.fetchCardNumber();
    });

    return Observer(
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, '/'),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Skeletonizer(
                enabled: widget.store.isLoading,
                child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: GridView.builder(
                    itemCount: (widget.store.cardNumber ?? 0) + 1,
                    itemBuilder: (BuildContext context, int index) {
                      index++;
              
                      if (widget.store.cardNumber == null) {
                        return buildNewItem(context, index);
                      }
              
                      if (index == widget.store.cardNumber! + 1) {
                        return buildNewItem(context, index);
                      }
              
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/card_page',
                                arguments: index,
                              );
                            },
                            child: Card(
                              color: const Color(0xFF44BC6F),
                              child: Center(
                                  child: Text('$index',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontWeight: FontWeight.bold))),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Padding buildNewItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/card_page',
              arguments: index,
            );
          },
          child: const Card(
            color: Colors.white,
            child: Center(child: Icon(Icons.add)),
          ),
        ),
      ),
    );
  }
}
