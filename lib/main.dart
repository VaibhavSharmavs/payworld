import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants/dummy_data.dart';
import 'package:test_app/models/response.dart';
import 'package:test_app/provider/my_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  MyProvider? myProvider;

  @override
  void initState() {
    getResponse();
    Future.delayed(Duration.zero, () async {
      for (int i = 0; i <= response.length; i++) {
        myProvider!.updateCheckbox(i, response[4].options![i].checked as bool);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);

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
                                        value: myProvider!.map[index] == null
                                            ? false
                                            : myProvider!.map[index],
                                        onChanged: (value) {
                                          myProvider!.updateCheckbox(
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
                                                    value: index
                                                    //  int.parse(
                                                    //     response[2].value)
                                                    ,
                                                    groupValue: myProvider!
                                                        .selectedRadio,
                                                    onChanged: (ind) =>
                                                        myProvider!
                                                            .setSelectedRadio(
                                                                ind as int),
                                                  ),
                                                ],
                                              );
                                            })
                                        : Text('');
                  })
            ],
          ),
        ),
      ),
    );
  }

  bool showChecked(int index, MyProvider? provider) {
    bool isSelected = false;
    if (response[4].options![index].checked == true) {
      isSelected = true;
      provider!.updateCheckbox(index, true);
    } else {
      provider!.updateCheckbox(index, false);
      isSelected = false;
    }

    return isSelected;
  }

  void getResponse() {
    response = responseFromJson(Constant.dummyData);
  }
}
