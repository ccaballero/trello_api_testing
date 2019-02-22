import os
import yaml

global config

dir_path = os.path.dirname(os.path.realpath(__file__))
config = yaml.load(open(dir_path+'/config/config.yml'))

def before_all(context):
    context.url = config['url']
    context.key = config['key']
    context.token = config['token']

