import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tutor_letter_gen/bloc/email_letter/email_letter_bloc.dart';
import 'package:tutor_letter_gen/bloc/email_letter/email_letter_state.dart';
import '/bloc/email_answers/email_answers_bloc.dart';
import '/bloc/email_answers/email_answers_event.dart';
import '/screens/email_answers_pad.dart';
import '/models/status.dart';
import '/services/clipboard_service.dart';

@RoutePage()
class EmailAnswerPage extends StatefulWidget {
  const EmailAnswerPage({
    super.key,
  });

  @override
  State<EmailAnswerPage> createState() => _EmailAnswerPageState();
}

class _EmailAnswerPageState extends State<EmailAnswerPage> {
  Future<void> copy() async {
    final letter = context.read<EmailLetterBloc>().state;
    final result = await ClipboardService.copy(
      text: letter.toText,
      html: letter.toHtml,
    );
    if (!mounted) return;

    final message = switch (result) {
      ClipboardCopyResult.richText => 'Ответ скопирован',
      ClipboardCopyResult.plainText => 'Ответ скопирован как обычный текст',
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
        title: const Text('Ответы в почту'),
        actions: [
          context.watch<EmailAnswersBloc>().state.canUpdate
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<EmailAnswersBloc>()
                            .add(UpdateEmailAnswers());
                      },
                      child: const Text('Обновить списки для ответов в почту')),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: context.watch<EmailAnswersBloc>().state.status ==
                          Status.download
                      ? const CircularProgressIndicator.adaptive()
                      : ElevatedButton(
                          onPressed: () {
                            context
                                .read<EmailAnswersBloc>()
                                .add(FetchLocalEmailAnswers());
                          },
                          child: const Text('Проверить обновления')),
                ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: EmailAnswersPad(),
          ),
          const Divider(
            height: 10,
            color: Colors.black,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<EmailLetterBloc, EmailLetterState>(
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
