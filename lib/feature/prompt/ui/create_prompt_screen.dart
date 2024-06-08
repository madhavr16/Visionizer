import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionizer/feature/prompt/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController _promptController = TextEditingController();
  final PromptBloc _promptBloc = PromptBloc();

  @override
  void initState() {
    _promptBloc.add(PromptInitialEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Visionizer',
            style: TextStyle(
                color: Color.fromARGB(255, 202, 199, 199),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<PromptBloc, PromptState>(
          bloc: _promptBloc,
          listener: (context, state) {
          },
          builder: (context, state) {
            switch(state.runtimeType){
              case PromptGeneratingImageLoadState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PromptGeneratingImageErrorState:
                return const Center(
                  child: Text('An error occured'),
                );
              case PromptGeneratingImageSuccessState:
                final successState = state as PromptGeneratingImageSuccessState;
                return Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(successState.uint8list),
                          fit: BoxFit.cover)),
                )),
                Container(
                  height: 240,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Your Prompt',
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _promptController,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.deepPurple,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Enter your prompt here'),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                if (_promptController.text.isNotEmpty) {
                                  _promptBloc.add(PromptEnteredEvent(prompt: _promptController.text));
                                
                                }
                              },
                              icon: const Icon(Icons.generating_tokens),
                              label: const Text('Generate')),
                        )
                      ]),
                )
              ],
            ));
            default:
              return const Center(
        child: Text('Unhandled state'),
      );
            }
          },
        ));
  }
}
