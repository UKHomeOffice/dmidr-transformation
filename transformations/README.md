# Building More Models

1. To start create and name a new subdirectory within `./transformations/models/`

2. Create a `models.yml` file within that subdirectory.

3. Add the above headers;
```
version: 2

models:
```

4. Then using the format specified create your models as such;

```
models:
    - name: test_model
      columns: 
        - name : column_a
          quotes: true
          tests:
            - not_null
```

5. The quotes column adds quotation marks to all columns that get passed around from tests, to the views. This ensures that we can put spaces, which are much more easily viewed in a report.

6. DBT comes with some prebuilt verification tests such as; `not_null`, `accepted_values`, `greater_than_zero`, and others.

7. There are a suite of generic DBT tests as well, these are found in ./transformations/tests/generic

8. To create a new generic DBT create a new `SQL` file in `./transformations/tests/generic`

9. A test use this syntax with these arguements;
```
{% test example_test(model, column_name) %}

{% endtest %}
```

10. Testing is built by writing SQL as part of the test, and verifying conditions are met/not met. 

11. You can view the compiled SQL from tests in  `./transformation/targets/run/MODEL_NAME/models.yml/example_test_ MODEL_NAME_run_number`

## Writing Python Integration Tests

1. All tests use the `test_base.py`

2. Create a new Python test in ./transformations/tests/ named `test_MODEL_NAME.py`

3. Create a test that looks at the model;
```
def test_new_model
    record = self.get_result("public.new_model")
```

4. Then write your assertions

5. To run them locally you can call;
```
$ make testpy
```