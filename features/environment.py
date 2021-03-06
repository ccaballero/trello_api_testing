import os
import yaml

from requests import request

global config

dir_path = os.path.dirname(os.path.realpath(__file__))
config = yaml.load(open(dir_path+'/../config/config.dist.yml'))

def before_all(context):
    context.url = config['url']
    context.key = config['key']
    context.token = config['token']

def after_scenario(context,scenario):
    if 'organizations' in context.tags:
        if 'acceptance' in context.tags:
            if 'create' in context.tags:
                request('DELETE',
                    context.url+'/organizations/'+context.id,
                    params={
                        'key': context.key,
                        'token': context.token
                    })
            elif 'read' in context.tags or \
               'update' in context.tags:
                request('DELETE',
                    context.url+'/organizations/'+context.organization_id,
                    params={
                        'key': context.key,
                        'token': context.token
                    })
        elif 'negative' in context.tags:
            if 'update' in context.tags:
                request('DELETE',
                    context.url+'/organizations/'+context.organization_id,
                    params={
                        'key': context.key,
                        'token': context.token
                    })

