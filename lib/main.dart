import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rich_clipboard/rich_clipboard.dart';
import '/bloc/letter/letter_bloc.dart';
import '/bloc/letter/letter_state.dart';

import 'bloc/criterias/criterias_bloc.dart';
import 'bloc/criterias/criterias_event.dart';
import 'screens/criterias_pad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CriteriasBloc>(
            lazy: false,
            create: (context) => CriteriasBloc()..add(FetchLocalCriterias()),
          ),
          BlocProvider<LetterBloc>(
            lazy: false,
            create: (context) => LetterBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Письмо репетитору',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(title: 'Письмо репетитору'),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void copy() async {
    await RichClipboard.setData(RichClipboardData(
        text: context.read<LetterBloc>().state.toText,
        html: context.read<LetterBloc>().state.toHtml));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
              : Container()
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              child: SingleChildScrollView(
                child: CriteriasPad(),
              ),
            ),
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
                return SingleChildScrollView(child: HtmlWidget(state.toHtml));
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
