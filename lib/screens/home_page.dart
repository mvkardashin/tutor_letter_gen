import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '/bloc/criterias/criterias_event.dart';
import '/bloc/letter/letter_bloc.dart';
import '/models/status.dart';
import '/screens/criterias_pad.dart';
import '/services/clipboard_service.dart';

import '../bloc/criterias/criterias_bloc.dart';
import '../bloc/letter/letter_state.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> copy() async {
    final letter = context.read<LetterBloc>().state;
    final result = await ClipboardService.copy(
      text: letter.toText,
      html: letter.toHtml,
    );
    if (!mounted) return;

    final message = switch (result) {
      ClipboardCopyResult.richText => 'Письмо скопировано',
      ClipboardCopyResult.plainText => 'Письмо скопировано как обычный текст',
      ClipboardCopyResult.failed =>
        'Не удалось скопировать. Выделите текст и нажмите Ctrl+C.',
    };
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Письмо репетитору'),
        actions: [
          context.watch<CriteriasBloc>().state.canUpdate
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<CriteriasBloc>().add(UpdateCriterias());
                      },
                      child: const Text('Обновить списки')),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: context.watch<CriteriasBloc>().state.status ==
                          Status.download
                      ? const CircularProgressIndicator.adaptive()
                      : ElevatedButton(
                          onPressed: () {
                            context
                                .read<CriteriasBloc>()
                                .add(FetchLocalCriterias());
                          },
                          child: const Text('Проверить обновления')),
                ),
          // ElevatedButton.icon(
          //   label: Text('Настройки'),
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             title: Text('Оформление ошибок и рекомендаций'),
          //             content: SingleChildScrollView(
          //                 child: Column(
          //               children: [
          //                 RadioListTile<int>(
          //                     title: Text('Маркированный список'),
          //                     value: 0,
          //                     groupValue:
          //                         context.watch<LetterBloc>().state.decoration,
          //                     onChanged: (value) {
          //                       context
          //                           .read<LetterBloc>()
          //                           .add(SetDecoration(decoration: value ?? 0));
          //                     }),
          //                 RadioListTile<int>(
          //                     title: Text('Тире'),
          //                     value: 1,
          //                     groupValue:
          //                         context.watch<LetterBloc>().state.decoration,
          //                     onChanged: (value) {
          //                       context
          //                           .read<LetterBloc>()
          //                           .add(SetDecoration(decoration: value ?? 0));
          //                     }),
          //                 RadioListTile<int>(
          //                     title: Text('Отсутствует'),
          //                     value: 2,
          //                     groupValue:
          //                         context.watch<LetterBloc>().state.decoration,
          //                     onChanged: (value) {
          //                       context
          //                           .read<LetterBloc>()
          //                           .add(SetDecoration(decoration: value ?? 0));
          //                     }),
          //               ],
          //             )),
          //           );
          //         });
          //   },
          //   icon: const Icon(Icons.settings),
          // )
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CriteriasPad(),
          ),
          const Divider(
            height: 10,
            color: Colors.black,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<LetterBloc, LetterState>(
                  builder: (context, state) {
                return SelectionArea(
                  child: SingleChildScrollView(
                    child: HtmlWidget(state.toHtml),
                  ),
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: copy,
        tooltip: 'Copy',
        label: const Text('Копировать письмо'),
        icon: const Icon(Icons.copy),
      ),
    );
  }
}
