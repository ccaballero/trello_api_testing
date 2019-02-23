@given(u'I want to execute service GET')
def step_impl(context):
    raise NotImplementedError(u'STEP: Given I want to execute service GET')


@when(u'I submit the GET request to /boards/{id}')
def step_impl(context):
    raise NotImplementedError(u'STEP: When I submit the GET request to /boards/{id}')


@then(u'I get a response with  HTTP status code 200')
def step_impl(context):
    raise NotImplementedError(u'STEP: Then I get a response with  HTTP status code 200')


@then(u'with valid body')
def step_impl(context):
    raise NotImplementedError(u'STEP: Then with valid body')


@given(u'I want to execute service POST')
def step_impl(context):
    raise NotImplementedError(u'STEP: Given I want to execute service POST')


@when(u'I submit the POST request to /boards/')
def step_impl(context):
    raise NotImplementedError(u'STEP: When I submit the POST request to /boards/')


@given(u'I want to execute service PUT')
def step_impl(context):
    raise NotImplementedError(u'STEP: Given I want to execute service PUT')


@given(u'I want to execute service <serviceName>')
def step_impl(context):
    raise NotImplementedError(u'STEP: Given I want to execute service <serviceName>')
