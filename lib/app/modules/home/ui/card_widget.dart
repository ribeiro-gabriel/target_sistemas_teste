import 'package:flutter/material.dart';

import 'custom_alert_dialog.dart';

class CardWidget extends StatelessWidget {
  final int cardNumber;
  final String cardText;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const CardWidget({
    super.key,
    required this.cardNumber,
    required this.cardText,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 350, maxWidth: 400),
      child: Card(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.border_color,
                        color: Colors.transparent,
                        size: 32,
                      ),
                      Icon(
                        Icons.cancel,
                        color: Colors.transparent,
                        size: 32,
                      ),
                    ],
                  ),
                  Text(
                    'Texto Digitado $cardNumber',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => onEditTap(),
                          icon: const Icon(
                            Icons.border_color,
                            color: Colors.black,
                            size: 32,
                          )),
                      IconButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    title: 'Deletar Texto $cardNumber',
                                    message:
                                        'Você tem certeza que quer deletar o Texto Digitado $cardNumber?',
                                    actions: [
                                      FilledButton(
                                        style: FilledButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF44BC6F),
                                            elevation: 1),
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Cancelar',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      FilledButton(
                                        style: FilledButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF44BC6F),
                                            elevation: 1),
                                        onPressed: () {
                                          onDeleteTap();
                                          Navigator.of(context).pushReplacementNamed('/home');
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Deletar',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });

                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 32,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Divider(
                height: 1,
                color: Color(0xFFDCDCDC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SelectionArea(
                child: Text(cardText,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold, height: 1.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
