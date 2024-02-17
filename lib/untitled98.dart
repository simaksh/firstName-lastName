import 'dart:io';

class Todo {
  late String title;
  late String description;
  late bool isExecuted;

  Todo(this.title, this.description) {
    isExecuted = false;
  }
}

class Person {
  late String firstName;
  late String lastName;
  List<Todo> todos = [];

  Person(this.firstName, this.lastName);

  void addTodo(String title, String description) {
    todos.add(Todo(title, description));
  }

  void displayTodos() {
    print('$firstName $lastName todos:');
    for (var i = 0; i < todos.length; i++) {
      print('${i + 1}. ${todos[i].title}: ${todos[i].description} - ${todos[i].isExecuted ? 'Done' : 'Not Done'}');
    }
  }

  void executeTodos() {
    print('Executing $firstName\'s todos:');
    for (var todo in todos) {
      print('Executing ${todo.title}: ${todo.description}');
      todo.isExecuted = true;
    }
  }

  void editTodo(int index, String newTitle, String newDescription) {
    todos[index].title = newTitle;
    todos[index].description = newDescription;
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
  }
}

void main() {
  List<Person> people = [];

  while (true) {
    print('''
    1 - Add Person
    2 - Add Todo
    3 - Display People's Todos
    4 - Execute Todos
    5 - Edit Todo
    6 - Remove Todo
    7 - Exit
    ''');

    stdout.write('Enter your option: ');
    String? choice = stdin.readLineSync();
    int? inputChoice = int.tryParse(choice ?? '');

    switch (inputChoice) {
      case 1:
        stdout.write('Enter first name: ');
        var firstName = stdin.readLineSync() ?? '';
        stdout.write('Enter last name: ');
        var lastName = stdin.readLineSync() ?? '';
        people.add(Person(firstName, lastName));
        break;

      case 2:
        stdout.write('Enter person index: ');
        int? personIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (personIndex != null && personIndex > 0 && personIndex <= people.length) {
          stdout.write('Enter todo title: ');
          var title = stdin.readLineSync() ?? '';
          stdout.write('Enter todo description: ');
          var description = stdin.readLineSync() ?? '';
          people[personIndex - 1].addTodo(title, description);
        } else {
          print('Invalid person index!');
        }
        break;

      case 3:
        if (people.isNotEmpty) {
          for (var person in people) {
            person.displayTodos();
          }
        } else {
          print('No people added yet!');
        }
        break;

      case 4:
        if (people.isNotEmpty) {
          for (var person in people) {
            person.executeTodos();
          }
        } else {
          print('No people added yet!');
        }
        break;

      case 5:
        stdout.write('Enter person index: ');
        int? personIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (personIndex != null && personIndex > 0 && personIndex <= people.length) {
          stdout.write('Enter todo index: ');
          int? todoIndex = int.tryParse(stdin.readLineSync() ?? '');
          if (todoIndex != null && todoIndex > 0 && todoIndex <= people[personIndex - 1].todos.length) {
            stdout.write('Enter new title: ');
            var newTitle = stdin.readLineSync() ?? '';
            stdout.write('Enter new description: ');
            var newDescription = stdin.readLineSync() ?? '';
            people[personIndex - 1].editTodo(todoIndex - 1, newTitle, newDescription);
          } else {
            print('Invalid todo index!');
          }
        } else {
          print('Invalid person index!');
        }
        break;

      case 6:
        stdout.write('Enter person index: ');
        int? personIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (personIndex != null && personIndex > 0 && personIndex <= people.length) {
          stdout.write('Enter todo index: ');
          int? todoIndex = int.tryParse(stdin.readLineSync() ?? '');
          if (todoIndex != null && todoIndex > 0 && todoIndex <= people[personIndex - 1].todos.length) {
            people[personIndex - 1].removeTodoAt(todoIndex - 1);
          } else {
            print('Invalid todo index!');
          }
        } else {
          print('Invalid person index!');
        }
        break;

      case 7:
        print('Exiting program.');
        return;

      default:
        print('Invalid option. Please try again.');
    }
  }
}