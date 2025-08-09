# Python Coding Instructions

## Use `mock.patch.object` for Mocking

When writing Python code, especially for unit tests that use the `unittest.mock`
library, you **must** use `mock.patch.object` instead of `mock.patch`.

### Example

Here is a clear illustration of the correct and incorrect approach.

#### ✅ Correct Usage: `mock.patch.object`

This is the preferred method. You import the module and then patch the function
directly on that module object.

```python
from unittest import mock
import my_project.services

def test_some_feature():
    # Patches 'external_api_call' directly on the imported 'services' object.
    with mock.patch.object(my_project.services, 'external_api_call') as mock_api_call:
        my_project.services.run_feature()
        mock_api_call.assert_called_once()
```

#### ❌ Incorrect Usage: mock.patch

Avoid this method. It relies on a string path that can easily be incorrect or
become outdated.

```python
from unittest import mock
import my_project.services

def test_some_feature():
    # This string path is fragile and less clear.
    with mock.patch('my_project.services.external_api_call') as mock_api_call:
        my_project.services.run_feature()
        mock_api_call.assert_called_once()
```

## Use `mock.create_autospec` for Mocks

When writing Python unit tests, you **must** use `mock.create_autospec` to
create mock objects. Do **not** use `mock.MagicMock` or `mock.Mock` directly.

### Example

Consider a simple class we want to test against.

```python
# in my_project/services.py
class ApiClient:
    def get_user_data(self, user_id: int) -> dict:
        # ... logic to call an external API
        return {"id": user_id, "name": "Jane Doe"}
```

#### ✅ Correct Usage: mock.create_autospec

This test will fail if you try to call get_user_data with the wrong number of
arguments, protecting you from API changes.

```python
from unittest import mock
from my_project.services import ApiClient

def test_user_retrieval():
    # Create a spec'd mock from the ApiClient class
    mock_client = mock.create_autospec(ApiClient, instance=True)

    # This call matches the real method signature
    mock_client.get_user_data(user_id=123)

    # If you tried mock_client.get_user_data(), it would raise a TypeError,
    # which is correct!
    # If you tried mock_client.get_nonexistent_method(), it would raise an
    # AttributeError.

    mock_client.get_user_data.assert_called_once_with(user_id=123)
```

#### ❌ Incorrect Usage: mock.MagicMock

This test is brittle. It would still pass even if the signature of get_user_data
changed or if you misspelled a method name.

```python
from unittest import mock

def test_user_retrieval_brittle():
    # A generic mock has no knowledge of the real ApiClient's interface
    mock_client = mock.MagicMock()

    # This call will *not* be validated against the real method signature.
    # The mock will happily accept any arguments.
    mock_client.get_user_data("wrong", "arguments")

    # This would also work, creating a new magic mock on the fly, hiding a
    # potential typo. mock_client.get_usr_data()

    mock_client.get_user_data.assert_called_once_with("wrong", "arguments")
```

## Import Modules, Not Classes or Functions

When writing Python code, you **must** import entire modules rather than
specific classes or functions from within those modules.

### Example

Here is a clear illustration of the correct and incorrect approach.

#### ✅ Correct Usage: `import my_app.database`

This is the preferred method. Import the module, then access its contents via
the module's namespace.

```python
# In main.py
import my_app.database
import my_app.utils

def initialize_app():
    db_conn = my_app.database.DatabaseConnection()
    data = my_app.utils.load_initial_data()
    # ... more code
```

#### ❌ Incorrect Usage: from my_app.database import DatabaseConnection

Avoid this method, as it can pollute the namespace and obscure the origin of
classes and functions.

```python
# In main.py
from my_app.database import DatabaseConnection
from my_app.utils import load_initial_data

def initialize_app():
    # It's less clear where DatabaseConnection comes from without looking at the
    # imports.
    db_conn = DatabaseConnection()
    data = load_initial_data()
    # ... more code
```

## Format all Python code with `black`

When you are asked to write, modify, or generate Python code, you must always
reformat your final code output using the `black` command-line tool.

- **Trigger**: Any request that results in Python code as the primary output.
- **Action**: Pipe the generated Python code to the `black` formatter.
- **Command**: Assume `black` is installed in the user's `PATH`. Use `black -`
  to read the code from standard input.
- **Output**: Your final response should only contain the `black`-formatted
  code. Do not show the code before formatting.

## Use `foo | None` for optional types

When you write or modify Python code, you must use the `| None` syntax for
optional types, as specified in PEP 604. You must not use `typing.Optional`.

This rule applies to all Python code you generate, including function
signatures, variable annotations, and class attributes.

### Example

**Correct (Do this):**

```python
def find_user(username: str) -> dict | None:
    # ... implementation ...
    return None
```

**Incorrect (Don't do this):**

```python
from typing import Optional

def find_user(username: str) -> Optional[dict]:
    # ... implementation ...
    return None
```

## Docstrings are required

When you write or modify Python code, you must ensure that every function,
method, or generator that is not part of a test suite has a docstring. This
docstring must, at a minimum, document the function's arguments, return values,
and any exceptions that may be raised by the function.

This rule applies to all non-test functions, regardless of their visibility
(public or private).

______________________________________________________________________

### Example: Correct

This function has a docstring that clearly explains what the function does and
what its arguments are.

```python
def connect_to_database(hostname: str, port: int) -> Connection:
    """Establishes a connection to the database.

    Args:
        hostname: The hostname or IP address of the database server.
        port: The port number to connect to.

    Returns:
        A database connection object.
    """
    # ... implementation ...
```

______________________________________________________________________

### Example: Incorrect (Missing Docstring)

This function is missing a docstring entirely.

```python
def connect_to_database(hostname: str, port: int) -> Connection:
    # ... implementation ...
```

______________________________________________________________________

### Example: Incorrect (Incomplete Docstring)

This docstring is incomplete because it does not document the function's
arguments.

```python
def connect_to_database(hostname: str, port: int) -> Connection:
    """Establishes a connection to the database."""
    # ... implementation ...
```

## Tests must use the `unittest` framework

When you are asked to write Python test code, you **must** use the built-in
`unittest` framework. Your tests should be written as methods within a class
that inherits from `unittest.TestCase`.

You **must** use the assertion methods provided by `unittest.TestCase` (e.g.,
`self.assertEqual()`, `self.assertTrue()`, `self.assertRaises()`) to check for
expected outcomes. Do not use the standard `assert` statement for test
assertions.

______________________________________________________________________

### Example: Correct

This example correctly uses the `unittest` module and the `self.assertEqual()`
assertion method.

```python
import unittest

def add(a, b):
    return a + b

class TestMathFunctions(unittest.TestCase):

    def test_add_integers(self):
        """
        Tests that the add function correctly sums two integers.
        """
        self.assertEqual(add(1, 2), 3)

    def test_add_strings(self):
        """
        Tests that the add function correctly concatenates two strings.
        """
        self.assertEqual(add('a', 'b'), 'ab')

if __name__ == '__main__':
    unittest.main()
```

______________________________________________________________________

### Example: Incorrect

This example is incorrect because it uses a plain `assert` statement instead of
a `unittest` assertion method. While this might work with other test runners
like `pytest`, your instructions are to use the `unittest` style exclusively.

```python
# Incorrect: Do not use plain assert statements.
import unittest

def add(a, b):
    return a + b

class TestMathFunctions(unittest.TestCase):

    def test_add_integers(self):
        assert add(1, 2) == 3
```
