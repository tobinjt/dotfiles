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
