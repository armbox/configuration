"""
gunicorn configuration file: http://docs.gunicorn.org/en/develop/configure.html
Ansible managed
"""

timeout = 300
bind = "127.0.0.1:8100"
pythonpath = "/edx/app/analytics_api/analytics_api"
workers = 2
worker_class = "gevent"




def pre_request(worker, req):
    worker.log.info("%s %s" % (req.method, req.path))
