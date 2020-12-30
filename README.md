# Best Practices

## angular js

### CLI
6 Best Practices & Pro Tips when using Angular CLI ([ref](https://medium.com/@tomastrajan/6-best-practices-pro-tips-for-angular-cli-better-developer-experience-7b328bc9db81))

## C#

### Asynchronous Programming with `async` and `await`

1. Async void is for top-level event-handlers only ([video](https://channel9.msdn.com/Series/Three-Essential-Tips-for-Async/Tip-1-Async-void-is-for-top-level-event-handlers-only?ocid=player))

    - `async void` is fire and forget

    - `async` method should return `Task/Task<TResult>`

2. CPU-boud should use sub-thred insted of IO-boud task

[ref](https://channel9.msdn.com/Series/Three-Essential-Tips-for-Async/Tip-2-Distinguish-CPU-Bound-work-from-IO-bound-work)
