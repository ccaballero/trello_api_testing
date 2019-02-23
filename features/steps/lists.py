from behave import *
import requests
import uuid
from compare import expect
import json

@given('I have an existing board')
def step_impl(context):
  board_name = uuid.uuid4()
  print(context.url)
  r = requests.post(f'{context.url}/boards/?name={board_name}&key={context.key}&token={context.token}')
  expect(r.status_code).to_equal(requests.codes.ok)
  context.board_id = json.load(r.text)
  
@when(u'I send a POST request to {endpoint} with name {name}')
def step_impl(context, endpoint, name):
  r = requests.post(f'{context.url}{endpoint}?name={name}&idBoard={context.board_id}&key={context.key}&token={context.token}')
  context.response = r.text


@then(u'I get a response with  HTTP status code {status_code}')
def step_impl(context, status_code):
  expect(context.response.status_code).to_equals(status_code)
  

#   @then('with valid body')
#   def step_impl(context, status_code):
#       pass
#
  
