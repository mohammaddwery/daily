# Daily

Task Management Application.




## Features

- Create task
- Update task
- Change task's state between: todo, inprogress and done
- Track spent time on the inprogress task
- Ability to stop and start the task's timer
- Share tasks as CSV file



## Installing

1- Install [melos](https://pub.dev/packages/melos)

2- Run in the root project's folder:
```terminal
melos exec flutter clean
melos exec flutter pub get
```

3- Edit the run configuration(development example):

Dart entrypoint: ~\app\lib\environments\development\development_main.dart

Additional run args: --flavor=development

Build flavor: development

###note: The build flavors are defined in gradle/app



## Soon features:
- User can add new task's states
- User can archive done tasks




