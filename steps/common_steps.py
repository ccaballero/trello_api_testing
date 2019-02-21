import json
from behave import *
from compare import expect
from utils.utils import map_url

use_step_matcher("re")


@step(u'I send a (.*) request to (.*)')
def step_impl(context, method, end_point):
    if context.text:
        context.object_data = json.loads(context.text)
        context.response = context.request_api.execute_request(method, map_url(end_point, context),
                                                               data=context.object_data)
    else:
        context.response = context.request_api.execute_request(method, map_url(end_point, context))


@then(u'I expect status code (.*)')
def step_impl(context, status_code):
    expect(str(context.response.status_code)).to_equal(status_code)


@step(u'I save the response as (.*)')
def step_impl(context, var_response):
    exec("context." + var_response + " = context.response")
