---
title: Multiprocessing Queue Example in Python
author:
  - Sam Stevens
keywords: [multiprocessing queue, queue, multiprocessing, python, example]
abstract: How to use `multiprocessing.Queue` in Pythong like `queue.Queue`
---

# `multiprocessing.Queue` in Python

I tried to use the `multiprocessing` version of `Queue` rather than the threaded version (`queue.Queue`) and found that without `task_done()` and `Queue.join()` I didn't understand how to actually end a queue. This is my approach, followed by how the docs do it.

**The key understanding that I missed: processees exit once their target finishes. If you know that, this probably won't be useful.**

I didn't see how to exit a queue without `task_done` and `join`. However, if you know that a process exits once it finishes it's target, it becomes clearer. For example, assume we have 2 producers and 2 consumers:

```python
import time
from multiprocessing import Queue, Process


def produce(q: "Queue[int]", length: int) -> None:
    for _ in range(length):
        q.put(3)


def consume(q: "Queue[int]") -> None:
    while True:
        num = q.get()
        print(f"Sleeping for {num} seconds.")
        time.sleep(num)  # expensive work

        # q.task_done() would go here! How do we know to exit?


def main() -> None:
    q: "Queue[int]" = Queue()

    for _ in range(2):
        c = Process(target=consume, args=(q,))
        c.start()

    for _ in range(2):
        p = Process(target=produce, args=(q, 5))
        p.start()

    for _ in range(2):
        p.join()

    for _ in range(2):
        c.join()


if __name__ == "__main__":
    main()
```

Running this program will never exit because of `while True:` in `consume`.

> To satisfy [`mypy`](https://mypy.readthedocs.io/en/stable/), `Queue` needs a type parameter. However, `Queue` cannot be indexed via `[]`, so you can put the whole type in quotes so that it's not evaluated at runtime.

How does `consume` know to exit? It can't check if `q.empty` because according to [the docs](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Queue.empty) it's not reliable. We could just use `get_nowait()` and exit if it raises an exception. But can the queue ever be empty without it being finished? Yes, so just checking if it's empty isn't a reliable way to end the program either.

The solution is to send some sort of "stop"-value that tells the consumer that it's done working. For example, if we were to use negative values as a stop value:

```python
def consume(q: "Queue[int]") -> None:
    while True:
        num = q.get()
        if num < 0: # sentinel value
            break

        print(f"Sleeping for {num} seconds.")
        time.sleep(num)  # expensive work
```

Now if we modify `produce`:

```python
def produce(q: "Queue[int]", length: int) -> None:
    for _ in range(length):
        q.put(3)

    q.put(-1) # stop-value
```

Now we can run `time python queue_demo.py` and see that it takes less than 30 seconds (3 seconds \* 5 elements produced \* 2 producers). It's not perfect (should be exactly 15 seconds), but it's definitely faster than in a single process.

Here's the final program, licensed under [GNU AGPLv3](/license-gnu). If you have any improvements/suggestions, I can be reached at [samuel.robert.stevens@gmail.com](mailto:samuel.robert.stevens@gmail.com)

```python
import time
from multiprocessing import Process, Queue


def produce(q: "Queue[int]", length: int) -> None:
    for _ in range(length):
        q.put(3)

    q.put(-1)  # stop-value


def consume(q: "Queue[int]") -> None:
    while True:
        num = q.get()
        if num < 0:  # sentinel value
            break

        print(f"Sleeping for {num} seconds.")
        time.sleep(num)  # expensive work


def main() -> None:
    q: "Queue[int]" = Queue()

    for _ in range(2):
        c = Process(target=consume, args=(q,))
        c.start()

    for _ in range(2):
        p = Process(target=produce, args=(q, 5))
        p.start()

    for _ in range(2):
        p.join()

    for _ in range(2):
        c.join()


if __name__ == "__main__":
    main()

```
