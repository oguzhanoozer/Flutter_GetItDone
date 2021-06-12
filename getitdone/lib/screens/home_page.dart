import 'package:flutter/material.dart';
import 'package:getitdone/models/item_data.dart';
import 'package:getitdone/screens/settings_page.dart';
import 'package:getitdone/widgets/item_card.dart';
import 'package:provider/provider.dart';

import 'item_adder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              })
        ],
        title: Text("Get It Done"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "${Provider.of<ItemData>(context).items.length} Items",
                    style: Theme.of(context).textTheme.headline3),
              ),
              //  height: 200,
            ),
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //height: 700,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Consumer<ItemData>(
                      builder: (context, itemData, child) => Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: itemData.items.length,
                          itemBuilder: (context, index) => ItemCard(
                            title: itemData.items[index].title,
                            isDone: itemData.items[index].isDone,
                            toggleStatus: (_) {
                              //Provider.of<ItemData>(context, listen: false)
                              itemData.toggleStatus(index);
                            },
                            deleteItem: () {
                              itemData.deleteItem(index);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              context: context,
              builder: (context) => SingleChildScrollView(child: ItemAdder()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
