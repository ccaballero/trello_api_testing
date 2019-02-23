from behave import *
import requests
import uuid
from compare import expect
import json
from jsonschema import validate

@given('I have an existing board')
def step_impl(context):
  board_name = uuid.uuid4()
  print(f'{context.url}/boards/?name={board_name}&key={context.key}&token={context.token}')
  r = requests.post(f'{context.url}/boards/?name={board_name}&key={context.key}&token={context.token}')
  expect(r.status_code).to_equal(requests.codes.ok)
  context.board_id = r.json()["id"]
  
@when(u'I send a POST request to {endpoint} with name {name}')
def step_impl(context, endpoint, name):
  r = requests.post(f'{context.url}{endpoint}?name={name}&idBoard={context.board_id}&key={context.key}&token={context.token}')
  context.response = r


@then(u'I get a resp0nse with  HTTP status code {status_code:d}')
def step_impl(context, status_code):
  expect(context.response.status_code).to_equal(status_code)
  

@then('with valid b0dy')
def step_impl(context):
  validate(context.response, context.text)
