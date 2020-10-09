import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/create_batch_state.dart';

class BatchSearch extends SearchDelegate<BatchModel> {
  final List<BatchModel> list;
  List<BatchModel> templist;
  HomeState state;
  BatchSearch(this.list, this.state, this.batches) {
    batches.value = list;
  }

  ValueNotifier<List<BatchModel>> batches;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    templist = state.batchList;
    return _result(context);
  }

  Widget _result(BuildContext context) {
    return ValueListenableBuilder<List<BatchModel>>(
      valueListenable: batches,
      builder: (context, listenableList, chils) {
        return ListView.builder(
            itemCount: templist.length,
            itemBuilder: (context, index) {
            var model = templist[index];
             return  Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).cardColor,
                ),
                child: ListTile(
                  title: Text(
                   model.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(model.description ?? "N/A"),
                  trailing: isSelected(model, listenableList)
                      ? Icon(Icons.check_box)
                      : null,
                  onTap: () {
                    var selected = listenableList
                        .firstWhere((element) => compare(element, model))
                        .isSelected;
                    listenableList
                        .firstWhere((element) => compare(element, model))
                        .isSelected = !selected;
                    batches.value = List.from(listenableList);
                    batches.notifyListeners();
                  },
                ),
              );
            });
      },
    );
  }

  bool isSelected(BatchModel model, List<BatchModel> list) {
    var data = list.firstWhere((element) => compare(element, model));
    if (data.isSelected) {
      return true;
    } else {
      return false;
    }
  }

  bool compare(BatchModel value1, BatchModel value2) {
    if (value1.id == value2.id) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    templist = list
            .where((x) =>
                x.name.toLowerCase().contains(query.toLowerCase()) ||
                x.name.toLowerCase().contains(query.toLowerCase()))
            .toList() ??
        list;
    return _result(context);
  }
}
