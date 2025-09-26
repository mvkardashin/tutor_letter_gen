import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rich_clipboard/rich_clipboard.dart';
import '/bloc/criterias/criterias_event.dart';
import '/bloc/letter/letter_bloc.dart';
import '/models/status.dart';
import '/screens/criterias_pad.dart';
import '/bloc/criterias/criterias_bloc.dart';
import '/bloc/letter/letter_state.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _copyToClipboard() async {
    final letterState = context.read<LetterBloc>().state;
    await RichClipboard.setData(RichClipboardData(
      text: letterState.toText,
      html: letterState.toHtml,
    ));
  }

  Widget _buildUpdateButton() {
    final criteriasBloc = context.watch<CriteriasBloc>();
    final state = criteriasBloc.state;

    if (state.status == Status.download) {
      return const CircularProgressIndicator.adaptive();
    }

    if (state.canUpdate) {
      return ElevatedButton(
        onPressed: () => criteriasBloc.add(UpdateCriterias()),
        child: const Text('Обновить списки'),
      );
    }

    return state.status == Status.checkUpdate
        ? const CircularProgressIndicator.adaptive()
        : ElevatedButton(
            onPressed: () => criteriasBloc.add(FetchLocalCriterias()),
            child: const Text('Проверить обновления'),
          );
  }

  Widget _buildLetterPreview() {
    return BlocBuilder<LetterBloc, LetterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: HtmlWidget(state.toHtml),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Письмо репетитору'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: _buildUpdateButton(),
          ),
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
              child: _buildLetterPreview(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _copyToClipboard,
        tooltip: 'Copy',
        label: const Text('Копировать письмо'),
        icon: const Icon(Icons.copy),
      ),
    );
  }
}
