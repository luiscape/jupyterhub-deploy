'''
JUPYTER HUB CONFIGURATION
-------------------------

Configuration file for deploying Jupyter Hub.
Jupyter Hub will use the system credentials to
create Docker-powered Jupyter notebook servers.
Each system user has a server. Those servers
contain both a local data folder and a local
notebook folder so that the data of the notebooks
is safely stored in disk.

'''

c = get_config()

c.Authenticator.admin_users = {'luiscapelo'}

c.JupyterHub.port = 80
c.JupyterHub.hub_port = 8001

c.JupyterHub.hub_ip = '0.0.0.0'
c.JupyterHub.proxy_api_ip = '0.0.0.0'
c.DockerSpawner.hub_ip_connect = '172.17.0.1'

c.Spawner.debug = True
c.PAMAuthenticator.create_system_users = True
c.JupyterHub.spawner_class = 'dockerspawner.SystemUserSpawner'
c.JupyterHub.cookie_secret_file = '/root/jupyterhub_cookie_secret'