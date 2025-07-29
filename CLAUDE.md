## Flutter/Dart Practices

- 앞으로는 Navigator.of(context).pop(); 대신에 context.pop();을 사용하도록 해
- Widget 내에서 `_buildSomething()` 같은 private method로 UI를 구성하지 말고, 무조건 별도의 Widget 클래스로 분리해서 작성해줘. 이렇게 해야 state 변화를 제대로 감지할 수 있음

## Supabase Practices

- supabase mcp가 읽기 모드인것을 감안해줘