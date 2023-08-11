/// Uma biblioteca Flutter que oferece funcionalidade para exibir toasts personalizados na tela.
library btoast;

import 'package:flutter/material.dart';

/// Enumeração que define os diferentes tipos de toasts.
enum Type {
  SUCCESS, // Toast de sucesso.
  ERROR, // Toast de erro.
  WARNING, // Toast de aviso.
  INFO, // Toast de informação.
}

/// Classe responsável por exibir os toasts personalizados.
class BToast {
  static late OverlayEntry? _overlayEntry;
  static late bool _inScreen = false;
  static List<Widget> _toasts = [];
  static final GlobalKey<_ListToastState> _listToastKey =
      GlobalKey<_ListToastState>();

  /// Exibe um toast personalizado na tela.
  ///
  /// - [context]: O contexto do widget onde o toast será exibido.
  /// - [content]: O conteúdo a ser exibido no toast.
  /// - [duration]: A duração do toast em segundos. O padrão é 5 segundos.
  /// - [theme]: O tema do toast (Type.SUCCESS, Type.ERROR, Type.WARNING, Type.INFO).
  /// - [isDark]: Define se o toast terá um tema escuro ou claro.
  /// - [title]: O título do toast (opcional).
  static void show(BuildContext context, String content,
      {int duration = 5,
      Type theme = Type.SUCCESS,
      bool isDark = true,
      String title = ""}) {
    int index = _toasts.length;
    _toasts.add(BToastComponent(
      hide: () => removeList(index),
      duration: duration,
      id: index,
      theme: theme,
      isDark: isDark,
      content: content,
      title: title,
    ));
    if (!_inScreen) {
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) => ListToast(
          key: _listToastKey,
          toasts: _toasts,
        ),
      );
      Overlay.of(context).insert(overlayEntry);
      _overlayEntry = overlayEntry;
      _inScreen = true;
    }
    _listToastKey.currentState?.updateToasts('add');
  }

  static void removeList(int index) {
    _toasts.removeAt(index);
    _listToastKey.currentState?.updateToasts('rmv');
    if (_toasts.isEmpty) {
      hide();
    }
  }

  static void hide() {
    if (_toasts.isNotEmpty) {
      _toasts.clear();
      _listToastKey.currentState?.updateToasts('rmv');
    }
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _inScreen = false;
    }
  }
}

/// Classe StatefulWidget que exibe a lista de toasts na tela.
class ListToast extends StatefulWidget {
  const ListToast({
    Key? key,
    required this.toasts,
  }) : super(key: key);

  final List<Widget> toasts;

  @override
  State<ListToast> createState() => _ListToastState();
}

class _ListToastState extends State<ListToast> {
  void updateToasts(String fun) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.toasts.toList(),
    );
  }
}

/// Classe StatefulWidget que exibe um toast personalizado na tela.
class BToastComponent extends StatefulWidget {
  final Function hide;
  final int id;
  final int duration;
  final bool isDark;
  final Type theme;
  final String content;
  final String title;

  BToastComponent({
    Key? key,
    required this.hide,
    required this.duration,
    required this.id,
    required this.isDark,
    required this.theme,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  _BToastComponentState createState() => _BToastComponentState();
}

class _BToastComponentState extends State<BToastComponent>
    with TickerProviderStateMixin {
  final themeColor = {
    Type.SUCCESS: const Color(0xff00f391),
    Type.ERROR: const Color(0xfffe5050),
    Type.WARNING: const Color(0xffff8a00),
    Type.INFO: const Color(0xff5093fe)
  };
  double percent = 0.0;
  late AnimationController _controller;

  bool _isVisible = true;
  late int time = widget.duration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Adicionar um listener para atualizar o estado quando a animação for executada
    _controller.addListener(() {
      setState(() {});
    });

    // Iniciar a animação ao montar o widget
    animatePercent();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animatePercent() {
    // Simulando uma animação gradual para a barra de progresso
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        percent = 0.7;
      });
      _controller.forward().then((value) {});
    });
  }

  void _animateOut() {
    _controller.reverse().then((value) {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? SafeArea(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(_controller),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  heightFactor: 1.0,
                  widthFactor: 1,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: widget.isDark
                                ? const Color(0xff252831)
                                : const Color(0xffe5e6e8),
                            border: Border.all(
                              color: themeColor[widget.theme]!,
                              width: 4.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                if (widget.title != "")
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        widget.title,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: themeColor[widget.theme]!,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    widget.content,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: widget.isDark
                                          ? const Color(0xffC6C6C6)
                                          : Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _animateOut();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: widget.isDark
                                        ? const Color(0xffC6C6C6)
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration(seconds: time),
                        onEnd: () {
                          _animateOut();
                        },
                        right: (_controller.value) *
                            MediaQuery.of(context).size.width,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: themeColor[widget.theme]!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
