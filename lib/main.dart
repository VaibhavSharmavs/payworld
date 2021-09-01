import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants/test_data.dart';
import 'package:test_app/provider/test_provider.dart';
import 'package:test_app/response_models/response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TestProivder(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Test'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Response> response;
  TestProivder? testProivder;

  @override
  void initState() {
    response = responseFromJson(Constant.testData);

    Future.delayed(Duration.zero, () async {
      for (int i = 0; i <= response.length; i++) {
        testProivder!
            .updateCheckbox(i, response[4].options![i].checked as bool);
        if (response[i].label == 'Gender') {
          print(i);
          print(response[i].value);

          try {
            testProivder!.updateRadio(int.parse(response[2].value));
          } catch (e) {
            print(e);
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    testProivder = Provider.of<TestProivder>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: response.length,
                  itemBuilder: (BuildContext context, int index) {
                    return response[index].type == 'textfield'
                        ? TextFormField(
                            initialValue: response[index].value,
                            decoration: InputDecoration(
                                hintText: response[index].placeholder,
                                labelText: response[index].label),
                          )
                        : response[index].type == 'multiple_select'
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: response[4].options!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(children: [
                                    Checkbox(
                                        value: testProivder!.map[index] == null
                                            ? false
                                            : testProivder!.map[index],
                                        onChanged: (value) {
                                          testProivder!.updateCheckbox(
                                              index, value as bool);
                                        }),
                                    Text(response[4]
                                        .options![index]
                                        .value
                                        .toString())
                                  ]);
                                })
                            : response[index].type == 'number_textfield'
                                ? TextFormField(
                                    initialValue: response[index].value,
                                    decoration: InputDecoration(
                                        hintText: response[index].placeholder,
                                        labelText: response[index].label),
                                  )
                                : response[index].type == 'date'
                                    ? TextFormField(
                                        initialValue: response[index].value,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          hintText: response[index].placeholder,
                                          labelText: response[index].label,
                                        ),
                                      )
                                    : response[index].type == 'radio'
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                response[2].options!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  RadioListTile(
                                                    title: Text(response[2]
                                                        .options![index]
                                                        .value
                                                        .toString()),
                                                    value: index,
                                                    groupValue: testProivder!
                                                        .selectedRadio,
                                                    onChanged: (ind) =>
                                                        testProivder!
                                                            .updateRadio(
                                                                ind as int),
                                                  ),
                                                ],
                                              );
                                            })
                                        : Text('No data found');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
