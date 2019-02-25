from compare import expect
from json import loads
from jsonschema import validate
from re import match
from re import search
from requests import request
from uuid import uuid4

@when(u'I set the query parameters')
def step_impl(context):
    query = {}

    for row in context.table:
        is_template_variable = match('\{([A-Za-z0-9_\-]+)\}',row[1])
        if is_template_variable:
            if 'generated' not in context:
                context.generated = {}

            context.generated[row[1]] = is_template_variable.group(1)+str(uuid4()).replace('-','')
            query[row[0]] = context.generated[row[1]]
        else:
            query[row[0]] = row[1]

    context.parameters = query
    print('==> query parameters:',context.parameters)

@when(u'I send a {method} request to {endpoint}')
def step_impl(context,method,endpoint):
    context.method = method

    if search('\{[A-Za-z0-9_\-]+\}',endpoint):
        for key, _value in context.generated.items():
            endpoint = endpoint.replace(key,_value)

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
    print('==> status code:',context.status_code)
    expect(context.status_code).to_equal(status_code)

@then(u'I get a response header {header} {value}')
def step_impl(context,header,value):
    print('==> header:',header,context.headers[header])
    expect(value in context.headers[header]).to_be_truthy()

@then(u'I get a response json based on json schema')
def step_impl(context):
    schema = loads(context.text)
    body = loads(context.body_response)

    context.id = body['id']

    print('==> response:',context.body_response)
    validate(body,schema)

@then(u'I get a return values')
def step_impl(context):
    body = loads(context.body_response)

    for row in context.table:
        value = smartcast(row[1])

        if isinstance(value, str) and search('\{[A-Za-z0-9_\-]+\}',value):
            for key, _value in context.generated.items():
                value = value.replace(key,_value)

        print('==> json property:',row[0],value)
        expect(body[row[0]]).to_equal(value)

@then(u'I get a response text')
def step_impl(context):
    print('==> response',context.body_response)
    text = context.text.replace('\n','').replace('\r','')
    expect(context.body_response).to_equal(text)

def smartcast(value):
  tests = [int, float]
  for test in tests:
    try:
      return test(value)
    except ValueError:
      continue
  if (value.lower() == 'true'):
    return True
  if (value.lower() == 'false'):
    return False
  return value