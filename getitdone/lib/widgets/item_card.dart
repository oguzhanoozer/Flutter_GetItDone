import "package:flutter/material.dart";

class ItemCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final Function toggleStatus;
  final Function deleteItem;

  const ItemCard(
      {Key key, this.title, this.isDone, this.toggleStatus, this.deleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Dismissable onDismissed
      onDoubleTap: deleteItem,
      key: UniqueKey(),//Key(title),
      child: Card(
        color: isDone ? Colors.green.shade50 : Colors.white,
        elevation: isDone ? 1 : 5,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(title,
              style: TextStyle(
                  color: Colors.black,
                  decoration: isDone ? TextDecoration.lineThrough : null)),
          trailing: Checkbox(
            activeColor: Colors.green,
            value: isDone,
            onChanged: toggleStatus,
          ),
        ),
      ),
    );
  }
}
