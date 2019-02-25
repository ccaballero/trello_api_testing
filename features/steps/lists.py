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
    print(r.status_code)
    expect(r.status_code).to_equal(requests.codes.ok)
    context.id = r.json()["id"]
