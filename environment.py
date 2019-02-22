import yaml
from utils.api_request import RequestApi
from utils.utils import delete_projects
from utils.utils import delete_item

global config
global request_api

config = yaml.load(open('../config/config.yml'))

def before_all(context):
    context.url = config['url']
    context.key = config['key']
    context.token = config['token']
    #context.request_api = RequestApi(context.token, context.url, context.username, context.password)

def before_tag(context, tag):
    if tag == 'delete_project':
        delete_projects(context)

def after_tag(context, tag):
    if tag == 'delete_item':
        delete_projects(context)
        delete_item(context)

