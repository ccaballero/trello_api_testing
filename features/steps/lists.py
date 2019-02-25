from behave import *
from compare import expect
import requests
import uuid
import json
import time

@given('I have an existing board')
def step_impl(context):
  board_name = int(round(time.time() * 1000))
  r = requests.post(f'{context.url}/boards/?name={board_name}&key={context.key}&token={context.token}')
  expect(r.status_code).to_equal(requests.codes.ok)
  context.board_id = r.json()["id"]
  if 'generated' not in context:
    context.generated = {}
  context.generated['{board_id}'] = context.board_id


@given('I have an existing list')
def step_impl(context):
  list_name = int(round(time.time() * 1000))
  r = requests.post(f'{context.url}/lists?name={list_name}&idBoard={context.board_id}&key={context.key}&token={context.token}')
  expect(r.status_code).to_equal(requests.codes.ok)
  context.list_id = r.json()["id"]
  if 'generated' not in context:
    context.generated = {}
  context.generated['{list_id}'] = context.list_id
