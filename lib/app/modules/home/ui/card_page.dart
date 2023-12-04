import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../stores/card_text_store.dart';
import 'card_widget.dart';
import 'custom_alert_dialog.dart';

class CardPage extends StatefulWidget {
  final CardTextStore store;

  const CardPage({super.key, required this.store});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const saveSnackBar = SnackBar(
      content: Text('Texto salvo com sucesso!'),
    );

    if (widget.store.cardNumber == null) {
      int? numberReceived = ModalRoute.of(context)!.settings.arguments as int?;

      runInAction(() {
        if (numberReceived == null) {
          widget.store.isError = true;
        } else {
          widget.store.isError = false;
          widget.store.cardNumber = numberReceived;
          widget.store.fetchText();
        }
      });
    }

    return Observer(
      builder: (BuildContext context) {
        if (widget.store.isError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Ops! Algo de errado aconteceu!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: const Color(0xFFFF7777)),
              ),
              const SizedBox(height: 32.0),
              FilledButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
                style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF44BC6F), elevation: 1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text('Voltar'),
                ),
              ),
            ],
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, '/home'),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Skeletonizer(
                  enabled: widget.store.isLoading,
                  child: Column(
                    children: [
                      Center(
                        child: CardWidget(
                          onEditTap: () {
                            _focusNode.requestFocus();
                            _controller.text = widget.store.text;
                          },
                          onDeleteTap: () {
                            widget.store.deleteText();
                          },
                          cardNumber: widget.store.cardNumber ?? 0,
                          cardText: widget.store.text,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        height: 100,
                        width: 400,
                        child: Form(
                          child: TextFormField(
                            onTapOutside: (_) {},
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: (value) {
                              runInAction(() {
                                widget.store.text = value;
                              });
                            },
                            onFieldSubmitted: (value) {},
                            textAlign: TextAlign.center,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'O texto não pode estar em branco.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Digite seu texto',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              errorStyle:
                                  const TextStyle(color: Color(0xFFFF7777)),
                              errorMaxLines: 3,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: FilledButton(
                          onPressed: () {
                            widget.store.saveText();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(saveSnackBar);
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF44BC6F),
                              elevation: 1),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: Text('Salvar'),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}
