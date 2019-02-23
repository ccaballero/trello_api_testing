@when(u'I set the query params')
def step_impl(context):
    for query in context.table:
        print('=>',query)

@then(u'I get a response status code 200')
def step_impl(context):
    pass

@then(u'I get a response json based on json schema')
def step_impl(context):
    pass

