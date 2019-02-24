from compare import expect
from json import loads
from jsonschema import validate
from requests import request

@when(u'I set the query parameters')
def step_impl(context):
    query = {}

    for row in context.table:
        query[row[0]] = row[1]

    context.parameters = query

@when(u'I send a {method} request to {endpoint}')
def step_impl(context,method,endpoint):
    context.method = method

    if '{id}' in endpoint:
        endpoint = endpoint.replace('{id}',context.id)

    context.endpoint = endpoint

    if 'parameters' not in context:
        context.parameters = {}

    context.parameters['key'] = context.key
    context.parameters['token'] = context.token

    response = request(
        context.method,
        context.url+context.endpoint,
        params=context.parameters)

    context.status_code = response.status_code
    context.headers = response.headers
    context.body_response = response.text

@then(u'I get a response status code {status_code:d}')
def step_impl(context,status_code):
    expect(context.status_code).to_equal(status_code)

@then(u'I get a response header {header} {value}')
def step_impl(context,header,value):
    expect(value in context.headers[header]).to_be_truthy()

@then(u'I get a response json based on json schema')
def step_impl(context):
    schema = loads(context.text)
    body = loads(context.body_response)

    context.id = body['id']

    print('response =>',context.body_response)
    validate(body,schema)

@then(u'I get a return values')
def step_impl(context):
    body = loads(context.body_response)

    for row in context.table:
        expect(body[row[0]]).to_equal(row[1])

@then(u'I get a response text')
def step_impl(context):
    print('response =>',context.body_response)
    expect(context.body_response).to_equal(context.text)

