from behave import *
import requests
import config
from compare import expect


@given(u'I want to execute service GET')
def step_impl(context):
    print(f'{context.url}/boards/{context.id_Board}?&key={context.key}&token={context.token}')
    r = requests.get(f'{context.url}/boards/{context.id_Board}?&key={context.key}&token={context.token}')
    print(r.status_code)
    expect(r.status_code).to_equal(requests.codes.ok)
    context.board_id = r.json()["id"]


@given(u'I want to execute service POST')
def step_impl(context):
    print(f'{context.url}/boards/?name={context.name_Board}&key={context.key}&token={context.token}')
    r = requests.post(f'{context.url}/boards/?name={context.name_Board}&key={context.key}&token={context.token}')
    print(r.status_code)
    expect(r.status_code).to_equal(requests.codes.ok)
    context.name_Board = r.json()["name"]
