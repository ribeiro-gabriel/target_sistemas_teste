import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:target_sistemas_teste/app/modules/login/value_objects/email_vo.dart';
import 'package:target_sistemas_teste/app/modules/login/value_objects/password_vo..dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
final userController = TextEditingController();
final passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    //Isso é para facilitar meus testes
    if (kDebugMode) {
      userController.text = 'gabriehlr@gmail.com';
      passwordController.text = '123456';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Usuário',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    controller: userController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      var (error, _) = EmailVO(value ?? '').validate();
                      if (error != null) return error;
                      return null;
                    },
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Color(0xFFFF7777)),
                      prefixIcon: const Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Senha',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      var (error, _) = PasswordVO(value ?? '').validate();
                      if (error != null) return error;
                      return null;
                    },
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Color(0xFFFF7777)),
                      errorMaxLines: 3,
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).popAndPushNamed('/home');
                      }
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF44BC6F), elevation: 1),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      child: Text('Entrar'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: InkWell(
              child: const Text(
                'Política de Privacidade',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onTap: () =>
                  accessExternalLink(context, 'https://www.google.com'),
            ),
          )
        ],
      ),
    );
  }
}

void accessExternalLink(BuildContext context, String link) async {
  final url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
    );
    return;
  }
}
