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
  context.id = r.json()["id"]

@given('I have an existing list')
def step_impl(context):
  list_name = int(round(time.time() * 1000))
  r = requests.post(f'{context.url}/lists?name={list_name}&idBoard={context.id}&key={context.key}&token={context.token}')
  expect(r.status_code).to_equal(requests.codes.ok)
  context.id = r.json()["id"]
