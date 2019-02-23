import json
import requests
from compare import expect

@step(u'I send a {method} request to {endpoint}')
def step_impl(context,method,endpoint):
    context.method = method
    context.endpoint = endpoint

@when(u'I set the query params')
def step_impl(context):
    query = {
        'key': context.key,
        'token': context.token
    }

    for row in context.table:
        query[row[0]] = row[1]

    response = requests.request(
        context.method,
        context.url+context.endpoint,
        params=query)

    context.status_code = response.status_code
    context.body = response.text

@then(u'I get a response status code {status_code:d}')
def step_impl(context,status_code):
    expect(context.status_code).to_equal(status_code)

@then(u'I get a response json based on json schema')
def step_impl(context):
    print('=>', context.text)

#   @then(u'I expect status code (.*)')
#   def step_impl(context, status_code):
#       expect(str(context.response.status_code)).to_equal(status_code)
#
#   @step(u'I save the response as (.*)')
#   def step_impl(context, var_response):
#       exec("context." + var_response + " = context.response")

