import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

class AIWithHtml extends StatefulWidget {
  const AIWithHtml({super.key});

  @override
  State<AIWithHtml> createState() => _AIWithHtmlState();
}

class _AIWithHtmlState extends State<AIWithHtml> {
  String? textResponse;

  String lang = "ar";

  generateComingAIData() async {
    String apiKey = 'YOUR_API_KEY';
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    String prompt =
        'wrote for me a basic html page just html code and show some basic items in the html and add one random gif image and on other random image from any basic url just in one file without in title and strings just code and the items language will be in $lang';
    // final prompt = 'Give me an advice about health in $lang.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    setState(() {
      textResponse = response.text;
    });
    log(response.text ?? "no thing generated");
  }

  @override
  void initState() {
    generateComingAIData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "AI With Html",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  textResponse == null
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        )
                      : HtmlWidget(
                          textResponse ?? "no thing generated",
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
